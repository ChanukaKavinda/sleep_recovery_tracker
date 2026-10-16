/// One night of sleep plus the recovery numbers shown on the home screen.
class SleepNight {
  const SleepNight({
    required this.bedtime,
    required this.wakeTime,
    required this.deep,
    required this.rem,
    required this.light,
    required this.sleepScore,
    required this.recoveryPercent,
    required this.restingHeartRate,
    required this.hrvMs,
  });

  final DateTime bedtime;
  final DateTime wakeTime;

  /// Time spent in each sleep stage.
  final Duration deep;
  final Duration rem;
  final Duration light;

  /// 0 to 100.
  final int sleepScore;

  /// 0 to 100.
  final int recoveryPercent;

  /// Beats per minute.
  final int restingHeartRate;

  /// Heart rate variability in milliseconds.
  final int hrvMs;

  Duration get totalAsleep => deep + rem + light;

  /// Sample night used until real data (Health Connect / HealthKit) is wired in.
  factory SleepNight.sample() {
    return SleepNight(
      bedtime: DateTime(2026, 10, 5, 23, 12),
      wakeTime: DateTime(2026, 10, 6, 6, 36),
      deep: const Duration(hours: 1, minutes: 32),
      rem: const Duration(hours: 1, minutes: 48),
      light: const Duration(hours: 4, minutes: 4),
      sleepScore: 82,
      recoveryPercent: 74,
      restingHeartRate: 58,
      hrvMs: 62,
    );
  }
}
