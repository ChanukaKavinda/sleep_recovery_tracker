import 'package:flutter_test/flutter_test.dart';
import 'package:sleep_recovery_tracker/logic/time_math.dart';
import 'package:sleep_recovery_tracker/utils/formatters.dart';

void main() {
  test('durations', () {
    expect(formatDuration(const Duration(minutes: 444)), '7h 24m');
    expect(formatDuration(const Duration(minutes: 244)), '4h 04m');
    expect(formatDuration(const Duration(minutes: 45)), '45m');
    expect(formatMinutes(90), '1h 30m');
  });

  test('clock times', () {
    expect(formatClock(23, 12), '11:12 PM');
    expect(formatClock(0, 5), '12:05 AM');
    expect(formatClock(12, 0), '12:00 PM');
    expect(formatMinutesOfDay(1365), '10:45 PM');
  });

  test('minutes after noon keep midnight together', () {
    expect(minutesAfterNoon(DateTime(2026, 1, 1, 23)), 660);
    expect(minutesAfterNoon(DateTime(2026, 1, 1, 0, 30)), 750);
    expect(minutesOfDayFromNoon(720), 0);
  });
}
