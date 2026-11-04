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

/// One night of sleep (or a nap), as the UI and the logic code see it.
/// The database row is `SleepEntry` (see data/database.dart).
class SleepNight {
  const SleepNight({
    this.id,
    required this.bedtime,
    required this.wakeTime,
    this.stages,
    this.awakeMinutes,
    this.restingHeartRate,
    this.hrvMs,
    this.mood,
    this.tags = const {},
    this.note,
    this.isNap = false,
    this.source = sourceManual,
    this.externalId,
  });

  static const sourceManual = 'manual';
  static const sourceHealthConnect = 'health_connect';

  final int? id;
  final DateTime bedtime;
  final DateTime wakeTime;
  final SleepStages? stages;

  /// Minutes awake during the session (from a watch). Null when unknown.
  final int? awakeMinutes;

  /// Beats per minute.
  final int? restingHeartRate;

  /// Heart rate variability (RMSSD) in milliseconds.
  final int? hrvMs;

  /// Morning check-in, 1 (drained) to 5 (fresh).
  final int? mood;

  /// Habit tag keys, see logic/habits.dart.
  final Set<String> tags;

  final String? note;
  final bool isNap;

  /// [sourceManual] or [sourceHealthConnect].
  final String source;

  /// Health Connect session id, used to avoid importing a night twice.
  final String? externalId;

  Duration get timeInBed => wakeTime.difference(bedtime);

  /// With stages: the sum of the stages. Without: time in bed minus any
  /// known awake time.
  Duration get totalAsleep {
    final s = stages;
    if (s != null) return s.total;
    final awake = awakeMinutes ?? 0;
    final asleep = timeInBed - Duration(minutes: awake);
    return asleep.isNegative ? Duration.zero : asleep;
  }

  /// The calendar day this night "belongs" to = the morning you woke up.
  DateTime get wakeDay => DateTime(wakeTime.year, wakeTime.month, wakeTime.day);

  bool get isImported => source == sourceHealthConnect;
}
