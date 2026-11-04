import '../models/sleep_night.dart';
import 'scoring.dart';
import 'time_math.dart';

/// One calendar day on a trends chart (the morning you woke up).
class DayPoint {
  const DayPoint({required this.day, this.asleepMinutes, this.score});

  final DateTime day;

  /// Null = nothing logged that day.
  final int? asleepMinutes;
  final int? score;

  bool get hasData => asleepMinutes != null;
}

/// Average time in each stage over nights that have stages.
class StageAverages {
  const StageAverages({
    required this.deepMinutes,
    required this.remMinutes,
    required this.lightMinutes,
    required this.nights,
  });

  final double deepMinutes;
  final double remMinutes;
  final double lightMinutes;

  /// How many nights the average is based on.
  final int nights;

  double get total => deepMinutes + remMinutes + lightMinutes;
}

class TrendSummary {
  const TrendSummary({
    required this.days,
    required this.nightsLogged,
    required this.avgAsleepMinutes,
    required this.avgScore,
    required this.avgBedtimeMinutes,
    required this.avgWakeMinutes,
    required this.bedtimeSpreadMinutes,
    required this.sleepDebtMinutes,
    required this.nightsOnGoal,
    required this.stages,
    required this.avgRestingHeartRate,
    required this.avgHrv,
  });

  /// Oldest first, one entry per day in the range.
  final List<DayPoint> days;
  final int nightsLogged;
  final double? avgAsleepMinutes;
  final double? avgScore;

  /// Minutes after midnight.
  final int? avgBedtimeMinutes;
  final int? avgWakeMinutes;

  /// Standard deviation of bedtimes, in minutes ("± 40 min").
  final double? bedtimeSpreadMinutes;

  /// Sum of (goal - asleep) over the last 7 logged nights, never below 0.
  final int sleepDebtMinutes;
  final int nightsOnGoal;
  final StageAverages? stages;
  final double? avgRestingHeartRate;
  final double? avgHrv;

  bool get isEmpty => nightsLogged == 0;
}

/// Builds the numbers for the Trends screen.
///
/// [nightsNewestFirst]: nights only (no naps), newest first. Older nights
/// beyond the range are fine (they are used as score history).
TrendSummary buildTrends(
  List<SleepNight> nightsNewestFirst, {
  required int days,
  required int goalMinutes,
  DateTime? today,
}) {
  final end = _dateOnly(today ?? DateTime.now());
  final start = end.subtract(Duration(days: days - 1));

  // Score every night once, with its own history.
  final scoreByIndex = <int, int>{};
  for (var i = 0; i < nightsNewestFirst.length; i++) {
    final day = nightsNewestFirst[i].wakeDay;
    if (day.isBefore(start)) break;
    scoreByIndex[i] =
        scoreAt(nightsNewestFirst, i, goalMinutes: goalMinutes).sleepScore;
  }

  // Nights inside the range, and the best (longest) night per day.
  final inRange = <SleepNight>[];
  final scores = <int>[];
  final bestByDay = <DateTime, (int, int)>{}; // day -> (asleep, score)
  for (final entry in scoreByIndex.entries) {
    final night = nightsNewestFirst[entry.key];
    final day = night.wakeDay;
    if (day.isAfter(end)) continue;
    inRange.add(night);
    scores.add(entry.value);
    final asleep = night.totalAsleep.inMinutes;
    final current = bestByDay[day];
    if (current == null || asleep > current.$1) {
      bestByDay[day] = (asleep, entry.value);
    }
  }

  final points = <DayPoint>[];
  for (var i = 0; i < days; i++) {
    final day = DateTime(start.year, start.month, start.day + i);
    final best = bestByDay[day];
    points.add(
      DayPoint(day: day, asleepMinutes: best?.$1, score: best?.$2),
    );
  }

  final bedtimes = inRange.map((n) => minutesAfterNoon(n.bedtime)).toList();
  final wakes = inRange.map((n) => minutesAfterNoon(n.wakeTime)).toList();
  final avgBed = average(bedtimes);
  final avgWake = average(wakes);

  // Sleep debt over the last 7 logged nights (inside the range).
  final last7 = inRange.take(7);
  final debt = last7.fold<int>(
    0,
    (sum, n) => sum + (goalMinutes - n.totalAsleep.inMinutes),
  );

  final withStages = inRange.where((n) => n.stages != null).toList();
  StageAverages? stageAverages;
  if (withStages.isNotEmpty) {
    stageAverages = StageAverages(
      deepMinutes: average(withStages.map((n) => n.stages!.deep.inMinutes))!,
      remMinutes: average(withStages.map((n) => n.stages!.rem.inMinutes))!,
      lightMinutes: average(withStages.map((n) => n.stages!.light.inMinutes))!,
      nights: withStages.length,
    );
  }

  return TrendSummary(
    days: points,
    nightsLogged: inRange.length,
    avgAsleepMinutes: average(inRange.map((n) => n.totalAsleep.inMinutes)),
    avgScore: average(scores),
    avgBedtimeMinutes: avgBed == null ? null : minutesOfDayFromNoon(avgBed),
    avgWakeMinutes: avgWake == null ? null : minutesOfDayFromNoon(avgWake),
    bedtimeSpreadMinutes: standardDeviation(bedtimes),
    sleepDebtMinutes: debt < 0 ? 0 : debt,
    nightsOnGoal: inRange
        .where((n) => n.totalAsleep.inMinutes >= goalMinutes - 15)
        .length,
    stages: stageAverages,
    avgRestingHeartRate:
        average(inRange.map((n) => n.restingHeartRate).whereType<int>()),
    avgHrv: average(inRange.map((n) => n.hrvMs).whereType<int>()),
  );
}

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
