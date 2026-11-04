import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_scope.dart';
import '../models/sleep_night.dart';
import '../theme/clay_theme.dart';
import '../utils/formatters.dart';
import '../widgets/clay.dart';
import 'history_screen.dart';

/// Add a night by hand, or edit an existing one ([existing] != null).
class LogSleepScreen extends StatefulWidget {
  const LogSleepScreen({super.key, this.existing});

  /// The night being edited. Must have an id.
  final SleepNight? existing;

  @override
  State<LogSleepScreen> createState() => _LogSleepScreenState();
}

class _LogSleepScreenState extends State<LogSleepScreen> {
  /// The calendar date the night started (e.g. Mon 5 Oct for Mon -> Tue).
  late DateTime _night;
  late TimeOfDay _bed;
  late TimeOfDay _wake;

  final _rhrController = TextEditingController();
  final _hrvController = TextEditingController();
  bool _saving = false;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    if (existing != null) {
      final bed = existing.bedtime;
      // A bedtime after midnight belongs to the previous evening's night.
      final bedDay = dateOnly(bed);
      _night =
          bed.hour < 12 ? bedDay.subtract(const Duration(days: 1)) : bedDay;
      _bed = TimeOfDay(hour: bed.hour, minute: bed.minute);
      _wake = TimeOfDay(
        hour: existing.wakeTime.hour,
        minute: existing.wakeTime.minute,
      );
      final rhr = existing.restingHeartRate;
      final hrv = existing.hrvMs;
      if (rhr != null) _rhrController.text = '$rhr';
      if (hrv != null) _hrvController.text = '$hrv';
    } else {
      // Before noon you are logging last night, so the night started
      // yesterday.
      final now = DateTime.now();
      final today = dateOnly(now);
      _night =
          now.hour < 12 ? today.subtract(const Duration(days: 1)) : today;
      _bed = const TimeOfDay(hour: 23, minute: 0);
      _wake = const TimeOfDay(hour: 7, minute: 0);
    }
  }

  @override
  void dispose() {
    _rhrController.dispose();
    _hrvController.dispose();
    super.dispose();
  }

  /// A bedtime after midnight (e.g. 12:30 AM) belongs to the next day.
  DateTime get _bedtime {
    final base = DateTime(
      _night.year,
      _night.month,
      _night.day,
      _bed.hour,
      _bed.minute,
    );
    return _bed.hour < 12 ? base.add(const Duration(days: 1)) : base;
  }

  /// Wake time is the morning after; pushed a day later if it would be
  /// before bedtime.
  DateTime get _wakeTime {
    var wake = DateTime(
      _night.year,
      _night.month,
      _night.day + 1,
      _wake.hour,
      _wake.minute,
    );
    if (!wake.isAfter(_bedtime)) {
      wake = wake.add(const Duration(days: 1));
    }
    return wake;
  }

  Future<void> _pickNight() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _night.isAfter(now) ? now : _night,
      firstDate: DateTime(now.year - 2),
      lastDate: now,
    );
    if (picked != null) setState(() => _night = picked);
  }

  Future<void> _pickBed() async {
    final picked = await showTimePicker(context: context, initialTime: _bed);
    if (picked != null) setState(() => _bed = picked);
  }

  Future<void> _pickWake() async {
    final picked = await showTimePicker(context: context, initialTime: _wake);
    if (picked != null) setState(() => _wake = picked);
  }

  Future<void> _save() async {
    final bedtime = _bedtime;
    final wakeTime = _wakeTime;
    final minutes = wakeTime.difference(bedtime).inMinutes;
    if (minutes < 60 || minutes > 16 * 60) {
      showClaySnack(
        context,
        'Sleep should be between 1 and 16 hours. Check the times.',
      );
      return;
    }
    if (wakeTime.isAfter(DateTime.now().add(const Duration(hours: 1)))) {
      showClaySnack(context, 'The wake time is in the future.');
      return;
    }

    final rhrText = _rhrController.text.trim();
    final hrvText = _hrvController.text.trim();
    final rhr = int.tryParse(rhrText);
    final hrv = int.tryParse(hrvText);
    if (rhrText.isNotEmpty && (rhr == null || rhr < 30 || rhr > 120)) {
      showClaySnack(context, 'Resting heart rate should be 30–120 bpm.');
      return;
    }
    if (hrvText.isNotEmpty && (hrv == null || hrv < 5 || hrv > 250)) {
      showClaySnack(context, 'HRV should be 5–250 ms.');
      return;
    }

    final db = AppScope.of(context).db;
    final existing = widget.existing;
    final night = SleepNight(
      bedtime: bedtime,
      wakeTime: wakeTime,
      // Keep everything this screen does not edit.
      stages: existing?.stages,
      awakeMinutes: existing?.awakeMinutes,
      restingHeartRate: rhr,
      hrvMs: hrv,
      mood: existing?.mood,
      tags: existing?.tags ?? const <String>{},
      note: existing?.note,
      isNap: existing?.isNap ?? false,
      source: existing?.source ?? SleepNight.sourceManual,
      externalId: existing?.externalId,
    );

    setState(() => _saving = true);
    try {
      final id = existing?.id;
      if (id != null) {
        await db.updateNight(id, night);
      } else {
        await db.insertNight(night);
      }
      if (!mounted) return;
      Navigator.of(context).pop();
      showClaySnack(context, _isEdit ? 'Night updated' : 'Night saved');
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      showClaySnack(context, 'Could not save: $e');
    }
  }

  Future<void> _delete() async {
    final id = widget.existing?.id;
    if (id == null) return;
    final ok = await confirmDialog(
      context,
      title: 'Delete this night?',
      message: 'You can undo this right after.',
      confirmLabel: 'Delete',
      danger: true,
    );
    if (!ok || !mounted) return;
    final navigator = Navigator.of(context);
    await deleteNightWithUndo(context, id);
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final asleep = _wakeTime.difference(_bedtime);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClayScreenHeader(
                title: _isEdit ? 'Edit night' : 'Log sleep',
                action: _isEdit
                    ? ClayCircleButton(
                        onTap: _saving ? null : _delete,
                        semanticLabel: 'Delete night',
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: c.danger,
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 24),
              _PickerTile(
                icon: Icons.calendar_today_rounded,
                label: 'Night of',
                value: formatShortDate(_night),
                onTap: _pickNight,
              ),
              const SizedBox(height: 14),
              _PickerTile(
                icon: Icons.bedtime_outlined,
                label: 'Went to bed',
                value: formatClock(_bed.hour, _bed.minute),
                onTap: _pickBed,
              ),
              const SizedBox(height: 14),
              _PickerTile(
                icon: Icons.wb_sunny_outlined,
                label: 'Woke up',
                value: formatClock(_wake.hour, _wake.minute),
                onTap: _pickWake,
              ),
              const SizedBox(height: 18),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Time in bed  '),
                    TextSpan(
                      text: formatDuration(asleep),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: c.text,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: c.textMuted,
                ),
              ),
              const SizedBox(height: 22),
              ClayCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Heart data (optional)',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'From your watch or phone app, if you have it.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: c.textMuted,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: ClayNumberField(
                            controller: _rhrController,
                            label: 'Resting HR',
                            suffix: 'bpm',
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: ClayNumberField(
                            controller: _hrvController,
                            label: 'HRV',
                            suffix: 'ms',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              ClayPillButton(
                label: _saving
                    ? 'Saving…'
                    : (_isEdit ? 'Save changes' : 'Save night'),
                icon: Icons.check_rounded,
                onTap: _saving ? null : _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickerTile extends StatelessWidget {
  const _PickerTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    return Semantics(
      button: true,
      label: '$label: $value. Tap to change.',
      onTap: onTap,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: ClayCard(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 22, color: c.accent),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: c.textMuted,
                  ),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.chevron_right_rounded, color: c.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pressed-in number input with a floating label and a unit suffix.
class ClayNumberField extends StatelessWidget {
  const ClayNumberField({
    super.key,
    required this.controller,
    required this.label,
    required this.suffix,
    this.maxLength = 3,
  });

  final TextEditingController controller;
  final String label;
  final String suffix;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return ClayInset(
      height: 60,
      radius: 16,
      depth: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: maxLength,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          decoration: InputDecoration(
            labelText: label,
            suffixText: suffix,
            counterText: '',
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
    );
  }
}
