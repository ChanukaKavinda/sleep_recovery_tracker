import 'dart:math' as math;

import '../models/sleep_night.dart';
import '../utils/formatters.dart';
import 'time_math.dart';

/// One ingredient of a score, shown in the breakdown sheet.
class ScorePart {
  const ScorePart({
    required this.label,
    required this.score,
    required this.weight,
    required this.detail,
  });

  final String label;

  /// 0 to 100.
  final double score;

  /// Share of the final score before re-balancing (0 to 1).
  final double weight;

  /// Short human explanation, e.g. "7h 24m of your 8h goal".
  final String detail;
}

class NightScores {
  const NightScores({
    required this.sleepScore,
    this.recoveryPercent,
    this.sleepParts = const [],
    this.recoveryParts = const [],
  });

  /// 0 to 100.
  final int sleepScore;

  /// 0 to 100, or null when there is nothing beyond sleep to judge it by.
  final int? recoveryPercent;

  final List<ScorePart> sleepParts;
  final List<ScorePart> recoveryParts;
}

/// "Excellent", "Good", "Fair" or "Poor".
String scoreLabel(int score) {
  if (score >= 85) return 'Excellent';
  if (score >= 70) return 'Good';
  if (score >= 55) return 'Fair';
  return 'Poor';
}

/// Scores the night at [index] in a list of nights sorted newest first,
/// using the (up to 14) older nights after it as history.
NightScores scoreAt(
  List<SleepNight> nightsNewestFirst,
  int index, {
  required int goalMinutes,
}) {
  return scoreNight(
    nightsNewestFirst[index],
    previous: nightsNewestFirst.skip(index + 1).take(14).toList(),
    goalMinutes: goalMinutes,
  );
}

/// Scoring v2.
///
/// [previous] = earlier nights, newest first (not including [night]).
NightScores scoreNight(
  SleepNight night, {
  required List<SleepNight> previous,
  required int goalMinutes,
}) {
  final sleepParts = _sleepParts(night, previous, goalMinutes);
  final sleepScore = _weighted(sleepParts).round();
  final recoveryParts = _recoveryParts(night, previous, sleepScore);
  return NightScores(
    sleepScore: sleepScore,
    recoveryPercent:
        recoveryParts.length < 2 ? null : _weighted(recoveryParts).round(),
    sleepParts: sleepParts,
    recoveryParts: recoveryParts,
  );
}

/// Sleep score =
///   50% duration     (asleep vs goal; short nights lose more, very long
///                     nights lose a little)
/// + 20% bedtime      (vs your last 7 bedtimes; 90+ min off = 0)
/// + 10% wake time    (vs your last 7 wake times)
/// + 10% restfulness  (asleep / time in bed, when a watch reports awake time)
/// + 10% stages       (deep near 20%, REM near 22%, when stages exist)
/// Missing parts are left out and the weights re-balanced.
List<ScorePart> _sleepParts(
  SleepNight night,
  List<SleepNight> previous,
  int goalMinutes,
) {
  final parts = <ScorePart>[];
  final goal = goalMinutes < 1 ? 1 : goalMinutes;
  final asleep = night.totalAsleep.inMinutes;

  // Duration.
  final double durationScore;
  if (asleep >= goal) {
    final over = asleep - goal;
    durationScore =
        over <= 90 ? 100.0 : math.max(70.0, 100 - (over - 90) / 60 * 10);
  } else {
    durationScore = 100 * math.pow(asleep / goal, 1.5).toDouble();
  }
  parts.add(
    ScorePart(
      label: 'Duration',
      score: _clamp(durationScore),
      weight: 0.50,
      detail: '${formatMinutes(asleep)} of your ${formatMinutes(goal)} goal',
    ),
  );

  // Consistency vs your recent nights.
  final recent = previous.take(7).toList();
  if (recent.isNotEmpty) {
    final usualBed = average(recent.map((n) => minutesAfterNoon(n.bedtime)))!;
    final bedDiff = (minutesAfterNoon(night.bedtime) - usualBed).abs();
    parts.add(
      ScorePart(
        label: 'Bedtime',
        score: _clamp(100 - bedDiff / 90 * 100),
        weight: 0.20,
        detail: _offText(bedDiff, 'bedtime'),
      ),
    );

    final usualWake =
        average(recent.map((n) => minutesAfterNoon(n.wakeTime)))!;
    final wakeDiff = (minutesAfterNoon(night.wakeTime) - usualWake).abs();
    parts.add(
      ScorePart(
        label: 'Wake time',
        score: _clamp(100 - wakeDiff / 90 * 100),
        weight: 0.10,
        detail: _offText(wakeDiff, 'wake time'),
      ),
    );
  }

  // Restfulness, only when a watch told us how long you were awake.
  final awake = night.awakeMinutes;
  if (awake != null && asleep + awake > 0) {
    final efficiency = asleep / (asleep + awake);
    parts.add(
      ScorePart(
        label: 'Restfulness',
        score: _clamp((efficiency - 0.75) / 0.20 * 100),
        weight: 0.10,
        detail: '${(efficiency * 100).round()}% of time in bed asleep, '
            '${formatMinutes(awake)} awake',
      ),
    );
  }

  // Stages.
  final stages = night.stages;
  if (stages != null && stages.total.inMinutes > 0) {
    final total = stages.total.inMinutes;
    final deepPct = stages.deep.inMinutes / total * 100;
    final remPct = stages.rem.inMinutes / total * 100;
    final off = (deepPct - 20).abs() + (remPct - 22).abs();
    parts.add(
      ScorePart(
        label: 'Sleep stages',
        score: _clamp(100 - off * 3),
        weight: 0.10,
        detail: 'Deep ${deepPct.round()}%, REM ${remPct.round()}% '
            '(aim ~20% and ~22%)',
      ),
    );
  }

  return parts;
}

/// Recovery =
///   40% sleep score
/// + 25% resting heart rate vs your average (each bpm lower = better)
/// + 20% HRV vs your average (higher = better)
/// + 15% morning check-in
/// Needs at least one thing besides the sleep score.
List<ScorePart> _recoveryParts(
  SleepNight night,
  List<SleepNight> previous,
  int sleepScore,
) {
  final parts = <ScorePart>[
    ScorePart(
      label: 'Sleep',
      score: sleepScore.toDouble(),
      weight: 0.40,
      detail: 'Sleep score $sleepScore',
    ),
  ];

  final rhr = night.restingHeartRate;
  final rhrBase = average(previous.map((n) => n.restingHeartRate).whereType<int>());
  if (rhr != null && rhrBase != null) {
    parts.add(
      ScorePart(
        label: 'Resting heart rate',
        score: _clamp(75 + (rhrBase - rhr) * 5),
        weight: 0.25,
        detail: '$rhr bpm (your usual ${rhrBase.round()})',
      ),
    );
  }

  final hrv = night.hrvMs;
  final hrvBase = average(previous.map((n) => n.hrvMs).whereType<int>());
  if (hrv != null && hrvBase != null && hrvBase > 0) {
    parts.add(
      ScorePart(
        label: 'HRV',
        score: _clamp(75 + (hrv - hrvBase) / hrvBase * 100),
        weight: 0.20,
        detail: '$hrv ms (your usual ${hrvBase.round()})',
      ),
    );
  }

  final mood = night.mood;
  if (mood != null) {
    parts.add(
      ScorePart(
        label: 'How you feel',
        score: (mood - 1) / 4 * 100,
        weight: 0.15,
        detail: 'You said $mood out of 5',
      ),
    );
  }

  return parts;
}

String _offText(double diffMinutes, String what) {
  final d = diffMinutes.round();
  if (d <= 10) return 'Right on your usual $what';
  return '${formatMinutes(d)} off your usual $what';
}

double _clamp(double v) => v.clamp(0, 100).toDouble();

double _weighted(List<ScorePart> parts) {
  var sum = 0.0;
  var weights = 0.0;
  for (final p in parts) {
    sum += p.score * p.weight;
    weights += p.weight;
  }
  return weights == 0 ? 0.0 : sum / weights;
}
