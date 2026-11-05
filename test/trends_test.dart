import 'package:flutter_test/flutter_test.dart';
import 'package:sleep_recovery_tracker/logic/trends.dart';
import 'package:sleep_recovery_tracker/models/sleep_night.dart';

SleepNight night(int wakeDay, int minutes) {
  final wake = DateTime(2026, 10, wakeDay, 7);
  return SleepNight(
    bedtime: wake.subtract(Duration(minutes: minutes)),
    wakeTime: wake,
  );
}

void main() {
  test('7-day trends', () {
    // Newest first.
    final nights = [night(10, 420), night(9, 480), night(7, 360)];
    final t = buildTrends(
      nights,
      days: 7,
      goalMinutes: 480,
      today: DateTime(2026, 10, 10, 20),
    );

    expect(t.days.length, 7);
    expect(t.days.first.day, DateTime(2026, 10, 4));
    expect(t.days[6].asleepMinutes, 420);
    expect(t.days[5].asleepMinutes, 480);
    expect(t.days[4].asleepMinutes, isNull);
    expect(t.days[3].asleepMinutes, 360);

    expect(t.nightsLogged, 3);
    expect(t.avgAsleepMinutes, 420);
    expect(t.sleepDebtMinutes, 180);
    expect(t.nightsOnGoal, 1);
    // Bedtimes 00:00, 23:00 and 01:00 average to midnight.
    expect(t.avgBedtimeMinutes, 0);
    expect(t.avgWakeMinutes, 7 * 60);
  });

  test('empty when nothing is in range', () {
    final t = buildTrends(
      [night(1, 480)],
      days: 7,
      goalMinutes: 480,
      today: DateTime(2026, 10, 20),
    );
    expect(t.isEmpty, isTrue);
  });
}
