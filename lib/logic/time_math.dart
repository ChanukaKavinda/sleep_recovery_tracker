import 'dart:math' as math;

/// Minutes after noon (0–1439), so times around midnight sit close
/// together: 11 PM = 660, 12:30 AM = 750, 7 AM = 1140.
/// Use this to average or compare bedtimes and wake times.
int minutesAfterNoon(DateTime t) => (t.hour * 60 + t.minute - 720) % 1440;

/// Inverse of [minutesAfterNoon]: minutes after noon -> minutes after
/// midnight (0–1439).
int minutesOfDayFromNoon(num minutesAfterNoon) =>
    (minutesAfterNoon.round() + 720) % 1440;

/// Minutes after midnight (0–1439).
int minutesOfDay(DateTime t) => t.hour * 60 + t.minute;

double? average(Iterable<num> values) {
  final list = values.toList();
  if (list.isEmpty) return null;
  return list.fold<double>(0, (sum, v) => sum + v) / list.length;
}

/// Population standard deviation; null for fewer than 2 values.
double? standardDeviation(Iterable<num> values) {
  final list = values.toList();
  if (list.length < 2) return null;
  final mean = average(list)!;
  final variance =
      list.fold<double>(0, (sum, v) => sum + (v - mean) * (v - mean)) /
          list.length;
  return math.sqrt(variance);
}
