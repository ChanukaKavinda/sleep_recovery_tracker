/// Time spent in each sleep stage. Only available when a watch / Health
/// Connect provides it; a manual log has no stages.
class SleepStages {
  const SleepStages({
    required this.deep,
    required this.rem,
    required this.light,
  });

  final Duration deep;
  final Duration rem;
  final Duration light;

  Duration get total => deep + rem + light;
}

/// One night of sleep, as the UI and the scoring code see it.
/// (The database row is `SleepEntry`; see `data/database.dart`.)
class SleepNight {
  const SleepNight({
    this.id,
    required this.bedtime,
    required this.wakeTime,
    this.stages,
    this.restingHeartRate,
    this.hrvMs,
    this.mood,
  });

  final int? id;
  final DateTime bedtime;
  final DateTime wakeTime;
  final SleepStages? stages;

  /// Beats per minute.
  final int? restingHeartRate;

  /// Heart rate variability in milliseconds.
  final int? hrvMs;

  /// Morning check-in, 1 (drained) to 5 (fresh).
  final int? mood;

  Duration get timeInBed => wakeTime.difference(bedtime);

  /// With stages: the sum of the stages. Without: the whole time in bed.
  Duration get totalAsleep => stages?.total ?? timeInBed;
}
