import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/database.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import '../widgets/clay.dart';

/// Manual sleep log: which night, bedtime, wake time, optional heart data.
class LogSleepScreen extends StatefulWidget {
  const LogSleepScreen({super.key, required this.db});

  final AppDatabase db;

  @override
  State<LogSleepScreen> createState() => _LogSleepScreenState();
}

class _LogSleepScreenState extends State<LogSleepScreen> {
  /// The calendar date the night started (e.g. Mon 5 Oct for Mon -> Tue).
  late DateTime _night;
  TimeOfDay _bed = const TimeOfDay(hour: 23, minute: 0);
  TimeOfDay _wake = const TimeOfDay(hour: 7, minute: 0);

  final _rhrController = TextEditingController();
  final _hrvController = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    // Before noon you are logging last night, so the night started yesterday.
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    _night = now.hour < 12 ? today.subtract(const Duration(days: 1)) : today;
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
      initialDate: _night,
      firstDate: DateTime(now.year - 1),
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

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _save() async {
    final bedtime = _bedtime;
    final wakeTime = _wakeTime;
    final minutes = wakeTime.difference(bedtime).inMinutes;
    if (minutes < 60 || minutes > 16 * 60) {
      _showError('Sleep should be between 1 and 16 hours. Check the times.');
      return;
    }

    final rhrText = _rhrController.text.trim();
    final hrvText = _hrvController.text.trim();
    final rhr = int.tryParse(rhrText);
    final hrv = int.tryParse(hrvText);
    if (rhrText.isNotEmpty && (rhr == null || rhr < 30 || rhr > 120)) {
      _showError('Resting heart rate should be 30–120 bpm.');
      return;
    }
    if (hrvText.isNotEmpty && (hrv == null || hrv < 5 || hrv > 250)) {
      _showError('HRV should be 5–250 ms.');
      return;
    }

    setState(() => _saving = true);
    try {
      await widget.db.addManualNight(
        bedtime: bedtime,
        wakeTime: wakeTime,
        restingHeartRate: rhr,
        hrvMs: hrv,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      _showError('Could not save: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final asleep = _wakeTime.difference(_bedtime);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ClayCircleButton(
                    onTap: () => Navigator.of(context).pop(),
                    semanticLabel: 'Back',
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Log sleep',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ],
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
                    const TextSpan(text: 'Time asleep  '),
                    TextSpan(
                      text: formatDuration(asleep),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
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
                    const Text(
                      'From your watch or phone app, if you have it.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _NumberField(
                            controller: _rhrController,
                            label: 'Resting HR',
                            suffix: 'bpm',
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _NumberField(
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
                label: _saving ? 'Saving…' : 'Save night',
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
              Icon(icon, size: 22, color: AppColors.accent),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted,
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
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.controller,
    required this.label,
    required this.suffix,
  });

  final TextEditingController controller;
  final String label;
  final String suffix;

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
          maxLength: 3,
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
