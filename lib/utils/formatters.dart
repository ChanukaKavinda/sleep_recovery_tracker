/// Small text helpers, so the app needs no extra date package.

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

/// 7h 24m, 4h 04m, 45m
String formatDuration(Duration d) {
  final negative = d.isNegative;
  final abs = negative ? -d : d;
  final hours = abs.inHours;
  final minutes = abs.inMinutes.remainder(60);
  final text = hours == 0
      ? '${minutes}m'
      : '${hours}h ${minutes.toString().padLeft(2, '0')}m';
  return negative ? '-$text' : text;
}

/// Same as [formatDuration] for a number of minutes.
String formatMinutes(num minutes) =>
    formatDuration(Duration(minutes: minutes.round()));

/// 11:12 PM, 6:36 AM
String formatClock(int hour, int minute) {
  final hour12 = hour % 12 == 0 ? 12 : hour % 12;
  final mm = minute.toString().padLeft(2, '0');
  final period = hour < 12 ? 'AM' : 'PM';
  return '$hour12:$mm $period';
}

String formatTime(DateTime t) => formatClock(t.hour, t.minute);

/// Minutes after midnight (0–1439) -> 10:45 PM
String formatMinutesOfDay(int minutes) {
  final m = minutes % 1440;
  return formatClock(m ~/ 60, m % 60);
}

/// Tuesday, 6 October
String formatLongDate(DateTime d) {
  return '${_weekdays[d.weekday - 1]}, ${d.day} ${_months[d.month - 1]}';
}

/// Tue 6 Oct
String formatShortDate(DateTime d) {
  return '${weekdayShort(d)} ${d.day} ${monthShort(d)}';
}

/// 6 Oct 2026
String formatDayMonthYear(DateTime d) {
  return '${d.day} ${monthShort(d)} ${d.year}';
}

/// October 2026
String formatMonthYear(DateTime d) => '${_months[d.month - 1]} ${d.year}';

/// Tue
String weekdayShort(DateTime d) => _weekdays[d.weekday - 1].substring(0, 3);

/// T (one letter, for chart labels)
String weekdayLetter(DateTime d) => _weekdays[d.weekday - 1].substring(0, 1);

/// Oct
String monthShort(DateTime d) => _months[d.month - 1].substring(0, 3);

/// "Today", "Yesterday", or "Tue 6 Oct".
String formatRelativeDay(DateTime day, {DateTime? now}) {
  final today = dateOnly(now ?? DateTime.now());
  final d = dateOnly(day);
  final diff = today.difference(d).inDays;
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  return formatShortDate(d);
}

/// Midnight at the start of [d]'s day.
DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// "2 hours ago", "just now"...
String formatAgo(DateTime time, {DateTime? now}) {
  final diff = (now ?? DateTime.now()).difference(time);
  if (diff.inMinutes < 1) return 'just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
  if (diff.inHours < 24) {
    return diff.inHours == 1 ? '1 hour ago' : '${diff.inHours} hours ago';
  }
  if (diff.inDays == 1) return 'yesterday';
  return '${diff.inDays} days ago';
}
