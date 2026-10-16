/// Small text helpers, so the app needs no extra date package yet.

/// 7h 24m, 4h 04m
String formatDuration(Duration d) {
  final hours = d.inHours;
  final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  return '${hours}h ${minutes}m';
}

/// 11:12 PM, 6:36 AM
String formatClock(int hour, int minute) {
  final hour12 = hour % 12 == 0 ? 12 : hour % 12;
  final mm = minute.toString().padLeft(2, '0');
  final period = hour < 12 ? 'AM' : 'PM';
  return '$hour12:$mm $period';
}

String formatTime(DateTime t) => formatClock(t.hour, t.minute);

/// Tuesday, 6 October
String formatLongDate(DateTime d) {
  const weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return '${weekdays[d.weekday - 1]}, ${d.day} ${months[d.month - 1]}';
}
