/// Small text helpers, so the app needs no extra date package yet.
library;

const _weekdays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

const _months = [
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
  return '${_weekdays[d.weekday - 1]}, ${d.day} ${_months[d.month - 1]}';
}

/// Tue 6 Oct
String formatShortDate(DateTime d) {
  final weekday = _weekdays[d.weekday - 1].substring(0, 3);
  final month = _months[d.month - 1].substring(0, 3);
  return '$weekday ${d.day} $month';
}
