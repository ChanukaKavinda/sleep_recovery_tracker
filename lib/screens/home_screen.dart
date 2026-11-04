import 'package:flutter/material.dart';

import '../app_scope.dart';
import '../data/database.dart';
import '../logic/scoring.dart';
import '../models/sleep_night.dart';
import '../theme/clay_theme.dart';
import '../utils/formatters.dart';
import '../widgets/clay.dart';
import '../widgets/sleep_stage_ring.dart';
import 'history_screen.dart';
import 'log_sleep_screen.dart';

/// Home tab: last night's score, stages, recovery, heart data, morning
/// check-in and tonight's bedtime. Rebuilds whenever the database changes.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Created once (on first build), so a rebuild does not restart the query.
  late final Stream<List<SleepEntry>> _nights =
      AppScope.of(context).db.watchNights(limit: 30);

  @override
  Widget build(BuildContext context) {
    final settings = SettingsScope.of(context);
    return StreamBuilder<List<SleepEntry>>(
      stream: _nights,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _Message(text: 'Could not load nights:\n${snapshot.error}');
        }
        final entries = snapshot.data;
        if (entries == null) return const _Loading();
        return _HomeContent(
          settings: settings,
          nights: entries.map((e) => e.toModel()).toList(),
        );
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.settings, required this.nights});

  final SettingsRow settings;

  /// Newest first, naps excluded.
  final List<SleepNight> nights;

  void _openLog(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const LogSleepScreen()),
    );
  }

  void _openHistory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const HistoryScreen()),
    );
  }

  Future<void> _pickBedtime(BuildContext context) async {
    final db = AppScope.of(context).db;
    final current = settings.bedtimeGoalMinutes;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: current ~/ 60, minute: current % 60),
    );
    if (picked != null) {
      await db.setBedtimeGoal(picked.hour * 60 + picked.minute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = AppScope.of(context).db;
    final latest = nights.isEmpty ? null : nights.first;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              date: DateTime.now(),
              userName: settings.userName,
              onLog: () => _openLog(context),
              onHistory: () => _openHistory(context),
            ),
            const SizedBox(height: 18),
            if (latest == null)
              _EmptyState(onLog: () => _openLog(context))
            else
              ..._latestNight(context, latest),
            const SizedBox(height: 18),
            _BedtimeCard(
              bedtimeMinutes: settings.bedtimeGoalMinutes,
              reminderOn: settings.bedtimeReminder,
              onBedtimeTap: () => _pickBedtime(context),
              onReminderChanged: db.setBedtimeReminder,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _latestNight(BuildContext context, SleepNight night) {
    final db = AppScope.of(context).db;
    final scores = scoreAt(nights, 0, goalMinutes: settings.sleepGoalMinutes);
    final nightId = night.id;
    return [
      Center(
        child: SleepStageRing(
          night: night,
          score: scores.sleepScore,
          goalMinutes: settings.sleepGoalMinutes,
        ),
      ),
      const SizedBox(height: 14),
      _AsleepLine(night: night),
      const SizedBox(height: 12),
      _StageLegend(night: night),
      const SizedBox(height: 18),
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _RecoveryCard(percent: scores.recoveryPercent)),
            const SizedBox(width: 16),
            Expanded(
              child: _HeartRateCard(
                restingHeartRate: night.restingHeartRate,
                hrvMs: night.hrvMs,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 18),
      _MoodCard(
        selected: night.mood,
        onSelected:
            nightId == null ? null : (value) => db.setMood(nightId, value),
      ),
    ];
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: context.clay.accent));
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: context.clay.textMuted),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.date,
    required this.userName,
    required this.onLog,
    required this.onHistory,
  });

  final DateTime date;
  final String userName;
  final VoidCallback onLog;
  final VoidCallback onHistory;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatLongDate(date),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: c.textMuted,
                ),
              ),
              Text(
                'Hi $userName',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        ClayCircleButton(
          onTap: onHistory,
          semanticLabel: 'Sleep history',
          depth: 6,
          child: Icon(Icons.history_rounded, size: 24, color: c.text),
        ),
        const SizedBox(width: 14),
        ClayCircleButton(
          onTap: onLog,
          semanticLabel: 'Log sleep',
          depth: 6,
          child: Icon(Icons.add_rounded, size: 26, color: c.accent),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onLog});

  final VoidCallback onLog;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    return ClayCard(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
      child: Column(
        children: [
          Icon(Icons.bedtime_outlined, size: 40, color: c.remSleep),
          const SizedBox(height: 12),
          const Text(
            'No sleep logged yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'Log last night to see your sleep score.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: c.textMuted,
            ),
          ),
          const SizedBox(height: 20),
          ClayPillButton(
            label: 'Log sleep',
            icon: Icons.add_rounded,
            onTap: onLog,
          ),
        ],
      ),
    );
  }
}

class _AsleepLine extends StatelessWidget {
  const _AsleepLine({required this.night});

  final SleepNight night;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: formatDuration(night.totalAsleep),
            style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
          ),
          TextSpan(
            text: ' asleep · ${formatTime(night.bedtime)} – '
                '${formatTime(night.wakeTime)}',
          ),
        ],
      ),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: c.textMuted,
      ),
    );
  }
}

class _StageLegend extends StatelessWidget {
  const _StageLegend({required this.night});

  final SleepNight night;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final stages = night.stages;
    if (stages == null) {
      return Text(
        'Sleep stages show up once a watch syncs through Health Connect.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: c.textMuted,
        ),
      );
    }
    return Row(
      children: [
        Expanded(
          child: StageLegendItem(
            color: c.deepSleep,
            label: 'Deep',
            value: formatDuration(stages.deep),
          ),
        ),
        Expanded(
          child: StageLegendItem(
            color: c.remSleep,
            label: 'REM',
            value: formatDuration(stages.rem),
          ),
        ),
        Expanded(
          child: StageLegendItem(
            color: c.lightSleep,
            label: 'Light',
            value: formatDuration(stages.light),
          ),
        ),
      ],
    );
  }
}

/// Coloured dot + label + value. Also used on the Trends screen.
class StageLegendItem extends StatelessWidget {
  const StageLegendItem({
    super.key,
    required this.color,
    required this.label,
    required this.value,
  });

  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: c.textMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _RecoveryCard extends StatelessWidget {
  const _RecoveryCard({required this.percent});

  /// Null = not enough data yet.
  final int? percent;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final value = percent;
    return ClayCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recovery',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: c.textMuted,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value == null ? '—' : '$value%',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          const SizedBox(height: 10),
          if (value == null)
            Text(
              'Check in below',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: c.textMuted,
              ),
            )
          else
            ClayProgressBar(value: value / 100, color: c.vitals),
        ],
      ),
    );
  }
}

class _HeartRateCard extends StatelessWidget {
  const _HeartRateCard({required this.restingHeartRate, required this.hrvMs});

  final int? restingHeartRate;
  final int? hrvMs;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final rhr = restingHeartRate;
    final hrv = hrvMs;
    final labelStyle = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: c.textMuted,
    );
    return ClayCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Heart rate', style: labelStyle),
              Icon(Icons.favorite_border_rounded, size: 18, color: c.vitals),
            ],
          ),
          const SizedBox(height: 6),
          // One Text.rich (not a baseline Row) so IntrinsicHeight measures
          // the card exactly and the bottom does not overflow.
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: rhr == null ? '—' : '$rhr',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                if (rhr != null) TextSpan(text: ' bpm resting', style: labelStyle),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            hrv != null
                ? 'HRV $hrv ms'
                : (rhr == null ? 'No heart data yet' : 'HRV —'),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: c.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodCard extends StatelessWidget {
  const _MoodCard({required this.selected, required this.onSelected});

  final int? selected;

  /// Null = cannot save (should not happen for a saved night).
  final ValueChanged<int>? onSelected;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final hintStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: c.textMuted,
    );
    final onSelected = this.onSelected;
    return ClayCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How do you feel this morning?',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var value = 1; value <= 5; value++)
                ClayCircleButton(
                  onTap: onSelected == null ? null : () => onSelected(value),
                  semanticLabel: 'Feeling $value out of 5',
                  selected: value == selected,
                  color: value == selected ? c.accent : null,
                  child: Text(
                    '$value',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: value == selected ? c.onAccent : c.text,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Drained', style: hintStyle),
              Text('Fresh', style: hintStyle),
            ],
          ),
        ],
      ),
    );
  }
}

class _BedtimeCard extends StatelessWidget {
  const _BedtimeCard({
    required this.bedtimeMinutes,
    required this.reminderOn,
    required this.onBedtimeTap,
    required this.onReminderChanged,
  });

  /// Minutes after midnight.
  final int bedtimeMinutes;
  final bool reminderOn;
  final VoidCallback onBedtimeTap;
  final ValueChanged<bool> onReminderChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final time = formatMinutesOfDay(bedtimeMinutes);
    return ClayCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              button: true,
              label: "Tonight's bedtime $time. Tap to change.",
              onTap: onBedtimeTap,
              excludeSemantics: true,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onBedtimeTap,
                child: Row(
                  children: [
                    Icon(Icons.bedtime_outlined, size: 24, color: c.accent),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tonight's bedtime",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: c.textMuted,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                time,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.edit_outlined,
                                size: 16,
                                color: c.textMuted,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ClaySwitch(
            value: reminderOn,
            onChanged: onReminderChanged,
            semanticLabel: 'Bedtime reminder',
          ),
        ],
      ),
    );
  }
}
