import 'package:flutter/material.dart';

import '../data/database.dart';
import '../logic/scoring.dart';
import '../models/sleep_night.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import '../widgets/clay.dart';
import '../widgets/sleep_stage_ring.dart';
import 'log_sleep_screen.dart';

const _labelStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w700,
  color: AppColors.textMuted,
);

const _captionStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: AppColors.textMuted,
);

const _bigNumberStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w800,
  height: 1,
);

/// Listens to the database and rebuilds whenever a night or a setting
/// changes (new log, mood tap, bedtime change...).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.db});

  final AppDatabase db;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Created once, so a rebuild does not restart the queries.
  late final Stream<SettingsRow> _settings = widget.db.watchSettings();
  late final Stream<List<SleepEntry>> _nights = widget.db.watchRecentNights();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SettingsRow>(
      stream: _settings,
      builder: (context, settingsSnap) {
        if (settingsSnap.hasError) {
          return _Message(text: 'Could not load settings:\n${settingsSnap.error}');
        }
        final settings = settingsSnap.data;
        if (settings == null) return const _Loading();

        return StreamBuilder<List<SleepEntry>>(
          stream: _nights,
          builder: (context, nightsSnap) {
            if (nightsSnap.hasError) {
              return _Message(text: 'Could not load nights:\n${nightsSnap.error}');
            }
            final entries = nightsSnap.data;
            if (entries == null) return const _Loading();

            return _HomeContent(
              db: widget.db,
              settings: settings,
              nights: entries.map((e) => e.toModel()).toList(),
            );
          },
        );
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.db,
    required this.settings,
    required this.nights,
  });

  final AppDatabase db;
  final SettingsRow settings;

  /// Newest first.
  final List<SleepNight> nights;

  void _openLog(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => LogSleepScreen(db: db)),
    );
  }

  Future<void> _pickBedtime(BuildContext context) async {
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
    final latest = nights.isEmpty ? null : nights.first;
    final latestId = latest?.id;

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
            ),
            const SizedBox(height: 18),
            if (latest == null)
              _EmptyState(onLog: () => _openLog(context))
            else
              ..._latestNight(latest, latestId),
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

  List<Widget> _latestNight(SleepNight night, int? nightId) {
    final scores = scoreNight(
      night,
      previous: nights.skip(1).toList(),
      goalMinutes: settings.sleepGoalMinutes,
    );
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
            Expanded(
              child: _RecoveryCard(percent: scores.recoveryPercent),
            ),
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
        onSelected: nightId == null
            ? null
            : (value) => db.setMood(nightId, value),
      ),
    ];
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.accent),
    );
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
          child: Text(text, textAlign: TextAlign.center, style: _labelStyle),
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
  });

  final DateTime date;
  final String userName;
  final VoidCallback onLog;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatLongDate(date),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
              Text(
                'Hi $userName',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        ClayCircleButton(
          onTap: onLog,
          semanticLabel: 'Log sleep',
          depth: 6,
          child: const Icon(
            Icons.add_rounded,
            size: 26,
            color: AppColors.accent,
          ),
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
    return ClayCard(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
      child: Column(
        children: [
          const Icon(
            Icons.bedtime_outlined,
            size: 40,
            color: AppColors.remSleep,
          ),
          const SizedBox(height: 12),
          const Text(
            'No sleep logged yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Log last night to see your sleep score.',
            textAlign: TextAlign.center,
            style: _labelStyle,
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
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: formatDuration(night.totalAsleep),
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          TextSpan(
            text: ' asleep · ${formatTime(night.bedtime)} – '
                '${formatTime(night.wakeTime)}',
          ),
        ],
      ),
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textMuted,
      ),
    );
  }
}

class _StageLegend extends StatelessWidget {
  const _StageLegend({required this.night});

  final SleepNight night;

  @override
  Widget build(BuildContext context) {
    final stages = night.stages;
    if (stages == null) {
      return const Text(
        'Sleep stages show up once a watch syncs through Health Connect.',
        textAlign: TextAlign.center,
        style: _captionStyle,
      );
    }
    return Row(
      children: [
        Expanded(
          child: _LegendItem(
            color: AppColors.deepSleep,
            label: 'Deep',
            value: formatDuration(stages.deep),
          ),
        ),
        Expanded(
          child: _LegendItem(
            color: AppColors.remSleep,
            label: 'REM',
            value: formatDuration(stages.rem),
          ),
        ),
        Expanded(
          child: _LegendItem(
            color: AppColors.lightSleep,
            label: 'Light',
            value: formatDuration(stages.light),
          ),
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
  });

  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
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
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted,
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
    final value = percent;
    return ClayCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recovery', style: _labelStyle),
          const SizedBox(height: 6),
          Text(value == null ? '—' : '$value%', style: _bigNumberStyle),
          const SizedBox(height: 10),
          if (value == null)
            const Text('Check in below', style: _captionStyle)
          else
            SizedBox(
              width: double.infinity,
              height: 8,
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: ClayInset(radius: 4, depth: 2),
                  ),
                  FractionallySizedBox(
                    widthFactor: (value / 100).clamp(0.0, 1.0).toDouble(),
                    heightFactor: 1,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.vitals,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
    final rhr = restingHeartRate;
    final hrv = hrvMs;
    return ClayCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Heart rate', style: _labelStyle),
              Icon(
                Icons.favorite_border_rounded,
                size: 18,
                color: AppColors.vitals,
              ),
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
                  style: _bigNumberStyle,
                ),
                if (rhr != null)
                  const TextSpan(text: ' bpm resting', style: _labelStyle),
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
            style: _captionStyle,
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
    const hintStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: AppColors.textMuted,
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
                  onTap: () => onSelected?.call(value),
                  semanticLabel: 'Feeling $value out of 5',
                  selected: value == selected,
                  color: value == selected
                      ? AppColors.accent
                      : AppColors.background,
                  child: Text(
                    '$value',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color:
                          value == selected ? Colors.white : AppColors.text,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
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
    final time = formatClock(bedtimeMinutes ~/ 60, bedtimeMinutes % 60);
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
                    const Icon(
                      Icons.bedtime_outlined,
                      size: 24,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tonight's bedtime",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textMuted,
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
                              const Icon(
                                Icons.edit_outlined,
                                size: 16,
                                color: AppColors.textMuted,
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
