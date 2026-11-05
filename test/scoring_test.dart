import 'package:flutter_test/flutter_test.dart';
import 'package:sleep_recovery_tracker/logic/scoring.dart';
import 'package:sleep_recovery_tracker/models/sleep_night.dart';

/// A night that ends at [wakeHour]:[wakeMinute] on 2026-10-[wakeDay] and
/// lasted [minutes].
SleepNight night({
  required int wakeDay,
  int minutes = 480,
  int wakeHour = 7,
  int wakeMinute = 0,
  int? rhr,
  int? hrv,
  int? mood,
}) {
  final wake = DateTime(2026, 10, wakeDay, wakeHour, wakeMinute);
  return SleepNight(
    bedtime: wake.subtract(Duration(minutes: minutes)),
    wakeTime: wake,
    restingHeartRate: rhr,
    hrvMs: hrv,
    mood: mood,
  );
}

void main() {
  group('sleep score', () {
    test('meeting the goal with no history scores 100', () {
      final s = scoreNight(night(wakeDay: 10), previous: [], goalMinutes: 480);
      expect(s.sleepScore, 100);
      expect(s.sleepParts.length, 1);
      expect(s.recoveryPercent, isNull);
    });

    test('6h of an 8h goal scores 65', () {
      final s = scoreNight(
        night(wakeDay: 10, minutes: 360),
        previous: [],
        goalMinutes: 480,
      );
      expect(s.sleepScore, 65);
    });

    test('a bedtime 90 min late loses the whole bedtime part', () {
      final history = [
        for (var d = 9; d >= 3; d--) night(wakeDay: d),
      ];
      // 00:30 -> 07:00 = 6h 30m, bedtime 90 min after the usual 23:00.
      final s = scoreNight(
        night(wakeDay: 10, minutes: 390),
        previous: history,
        goalMinutes: 480,
      );
      expect(s.sleepScore, 58);
      final bedtime = s.sleepParts.firstWhere((p) => p.label == 'Bedtime');
      expect(bedtime.score, 0);
    });

    test('labels', () {
      expect(scoreLabel(90), 'Excellent');
      expect(scoreLabel(75), 'Good');
      expect(scoreLabel(60), 'Fair');
      expect(scoreLabel(40), 'Poor');
    });
  });

  group('recovery', () {
    test('mood alone is enough for a recovery value', () {
      final fresh = scoreNight(
        night(wakeDay: 10, mood: 5),
        previous: [],
        goalMinutes: 480,
      );
      expect(fresh.recoveryPercent, 100);

      final drained = scoreNight(
        night(wakeDay: 10, mood: 1),
        previous: [],
        goalMinutes: 480,
      );
      expect(drained.recoveryPercent, 73);
    });

    test('resting heart rate below your usual raises recovery', () {
      final history = [
        for (var d = 9; d >= 7; d--) night(wakeDay: d, rhr: 60),
      ];
      final s = scoreNight(
        night(wakeDay: 10, rhr: 56),
        previous: history,
        goalMinutes: 480,
      );
      expect(s.sleepScore, 100);
      expect(s.recoveryPercent, 98);
    });
  });

  test('scoreAt uses the older nights as history', () {
    final nights = [
      night(wakeDay: 10, minutes: 480),
      night(wakeDay: 9, minutes: 480),
    ];
    final s = scoreAt(nights, 0, goalMinutes: 480);
    expect(s.sleepParts.map((p) => p.label), contains('Bedtime'));
  });
}
