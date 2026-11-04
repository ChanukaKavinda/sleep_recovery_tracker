import '../models/sleep_night.dart';

class NightScores {
  const NightScores({required this.sleepScore, this.recoveryPercent});

  /// 0 to 100.
  final int sleepScore;

  /// 0 to 100, or null when there is nothing beyond sleep to judge it by.
  final int? recoveryPercent;
}

/// Scoring v1: simple and easy to explain. We tune it in step 3.
///
/// [previous] = earlier nights, newest first (not including [night]).
NightScores scoreNight(
  SleepNight night, {
  required List<SleepNight> previous,
  required int goalMinutes,
}) {
  final sleep = _sleepScore(night, previous, goalMinutes);
  return NightScores(
    sleepScore: sleep,
    recoveryPercent: _recovery(night, previous, sleep),
  );
}

/// Scores the night at [index] in a list of nights sorted newest first,
/// using the older nights after it as history.
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

/// Sleep score =
///   60% duration (asleep / goal, capped at 100)
/// + 25% consistency (bedtime vs your last 7 bedtimes; 90+ min off = 0)
/// + 15% stages (deep near 20%, REM near 22%), only when stages exist.
/// Missing parts are left out and the weights re-balanced.
int _sleepScore(SleepNight night, List<SleepNight> previous, int goalMinutes) {
  final parts = <(double, double)>[];

  final goal = goalMinutes < 1 ? 1 : goalMinutes;
  parts.add((_clamp(night.totalAsleep.inMinutes / goal * 100), 0.60));

  if (previous.isNotEmpty) {
    final recent = previous.take(7).toList();
    final avgBed = recent
            .map((n) => _bedMinutes(n.bedtime))
            .reduce((a, b) => a + b) /
        recent.length;
    final diff = (_bedMinutes(night.bedtime) - avgBed).abs();
    parts.add((_clamp(100 - diff / 90 * 100), 0.25));
  }

  final stages = night.stages;
  if (stages != null && stages.total.inMinutes > 0) {
    final total = stages.total.inMinutes;
    final deepPct = stages.deep.inMinutes / total * 100;
    final remPct = stages.rem.inMinutes / total * 100;
    final off = (deepPct - 20).abs() + (remPct - 22).abs();
    parts.add((_clamp(100 - off * 3), 0.15));
  }

  return _weighted(parts).round();
}

/// Recovery =
///   40% sleep score
/// + 25% resting HR vs your average (each bpm lower = better)
/// + 20% HRV vs your average (higher = better)
/// + 15% morning check-in
/// Needs at least one thing besides the sleep score, else null.
int? _recovery(SleepNight night, List<SleepNight> previous, int sleepScore) {
  final parts = <(double, double)>[(sleepScore.toDouble(), 0.40)];

  final rhr = night.restingHeartRate;
  final rhrBase = _average(previous.map((n) => n.restingHeartRate));
  if (rhr != null && rhrBase != null) {
    parts.add((_clamp(75 + (rhrBase - rhr) * 5), 0.25));
  }

  final hrv = night.hrvMs;
  final hrvBase = _average(previous.map((n) => n.hrvMs));
  if (hrv != null && hrvBase != null && hrvBase > 0) {
    parts.add((_clamp(75 + (hrv - hrvBase) / hrvBase * 100), 0.20));
  }

  final mood = night.mood;
  if (mood != null) {
    parts.add(((mood - 1) / 4 * 100, 0.15));
  }

  if (parts.length == 1) return null;
  return _weighted(parts).round();
}

/// Minutes after noon, so 11 PM (660) and 12:30 AM (750) sit close together.
int _bedMinutes(DateTime t) => (t.hour * 60 + t.minute - 720) % 1440;

double? _average(Iterable<int?> values) {
  final list = values.whereType<int>().toList();
  if (list.isEmpty) return null;
  return list.reduce((a, b) => a + b) / list.length;
}

double _clamp(double v) => v.clamp(0, 100).toDouble();

double _weighted(List<(double, double)> parts) {
  var sum = 0.0;
  var weights = 0.0;
  for (final (score, weight) in parts) {
    sum += score * weight;
    weights += weight;
  }
  return weights == 0 ? 0.0 : sum / weights;
}
