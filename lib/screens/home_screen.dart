import 'package:flutter/material.dart';

import '../models/sleep_night.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import '../widgets/clay.dart';
import '../widgets/sleep_stage_ring.dart';

const _labelStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w700,
  color: AppColors.textMuted,
);

const _bigNumberStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w800,
  height: 1,
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.night,
    this.userName = 'Chauka',
    this.bedtimeGoal = const TimeOfDay(hour: 22, minute: 45),
  });

  final SleepNight night;
  final String userName;
  final TimeOfDay bedtimeGoal;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Morning check-in answer (1 to 5). Later: save this with the night's data.
  int? _mood = 4;
  bool _bedtimeReminder = true;

  @override
  Widget build(BuildContext context) {
    final night = widget.night;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(date: night.wakeTime, userName: widget.userName),
            const SizedBox(height: 18),
            Center(child: SleepStageRing(night: night)),
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
                    child: _RecoveryCard(percent: night.recoveryPercent),
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
              selected: _mood,
              onSelected: (value) => setState(() => _mood = value),
            ),
            const SizedBox(height: 18),
            _BedtimeCard(
              bedtime: widget.bedtimeGoal,
              reminderOn: _bedtimeReminder,
              onReminderChanged: (value) {
                setState(() => _bedtimeReminder = value);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.date, required this.userName});

  final DateTime date;
  final String userName;

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
          onTap: () {
            // TODO: open notifications.
          },
          semanticLabel: 'Notifications',
          depth: 6,
          child: const Icon(
            Icons.notifications_none_rounded,
            size: 22,
            color: AppColors.text,
          ),
        ),
      ],
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
            text:
                ' asleep · ${formatTime(night.bedtime)} – '
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
    return Row(
      children: [
        Expanded(
          child: _LegendItem(
            color: AppColors.deepSleep,
            label: 'Deep',
            value: formatDuration(night.deep),
          ),
        ),
        Expanded(
          child: _LegendItem(
            color: AppColors.remSleep,
            label: 'REM',
            value: formatDuration(night.rem),
          ),
        ),
        Expanded(
          child: _LegendItem(
            color: AppColors.lightSleep,
            label: 'Light',
            value: formatDuration(night.light),
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

  final int percent;

  @override
  Widget build(BuildContext context) {
    final fraction = (percent / 100).clamp(0.0, 1.0).toDouble();
    return ClayCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recovery', style: _labelStyle),
          const SizedBox(height: 6),
          Text('$percent%', style: _bigNumberStyle),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 8,
            child: Stack(
              children: [
                const Positioned.fill(child: ClayInset(radius: 4, depth: 2)),
                FractionallySizedBox(
                  widthFactor: fraction,
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

  final int restingHeartRate;
  final int hrvMs;

  @override
  Widget build(BuildContext context) {
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
                TextSpan(text: '$restingHeartRate', style: _bigNumberStyle),
                const TextSpan(text: ' bpm resting', style: _labelStyle),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            'HRV $hrvMs ms',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
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
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    const hintStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: AppColors.textMuted,
    );
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
                  onTap: () => onSelected(value),
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
                      color: value == selected ? Colors.white : AppColors.text,
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
    required this.bedtime,
    required this.reminderOn,
    required this.onReminderChanged,
  });

  final TimeOfDay bedtime;
  final bool reminderOn;
  final ValueChanged<bool> onReminderChanged;

  @override
  Widget build(BuildContext context) {
    return ClayCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.bedtime_outlined, size: 24, color: AppColors.accent),
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
                Text(
                  formatClock(bedtime.hour, bedtime.minute),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
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
