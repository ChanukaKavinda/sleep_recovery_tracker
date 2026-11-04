import 'package:flutter/material.dart';

import '../app_scope.dart';
import '../data/database.dart';
import '../logic/scoring.dart';
import '../models/sleep_night.dart';
import '../theme/clay_theme.dart';
import '../utils/formatters.dart';
import '../widgets/clay.dart';
import 'log_sleep_screen.dart';

/// Deletes a night and shows a snack bar with "Undo".
Future<void> deleteNightWithUndo(BuildContext context, int id) async {
  final db = AppScope.of(context).db;
  final messenger = ScaffoldMessenger.of(context);
  final entry = await db.getEntry(id);
  if (entry == null) return;
  await db.deleteNight(id);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: const Text('Night deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => db.restoreEntry(entry),
        ),
      ),
    );
}

/// Every logged night (and nap), newest first, grouped by month.
/// Tap = edit, swipe left = delete (with undo).
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final Stream<List<SleepEntry>> _entries =
      AppScope.of(context).db.watchAllEntries();

  /// Rows swiped away but not yet gone from the database stream. A
  /// Dismissible must leave the tree right away, so we hide it here first.
  final Set<int> _hidden = {};

  void _delete(int id) {
    setState(() => _hidden.add(id));
    deleteNightWithUndo(context, id);
  }

  void _openLog([SleepNight? night]) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => LogSleepScreen(existing: night),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final settings = SettingsScope.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 8),
              child: ClayScreenHeader(
                title: 'Sleep history',
                action: ClayCircleButton(
                  onTap: _openLog,
                  semanticLabel: 'Log sleep',
                  child: Icon(Icons.add_rounded, color: c.accent, size: 26),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<SleepEntry>>(
                stream: _entries,
                builder: (context, snapshot) {
                  final entries = snapshot.data;
                  if (entries == null) {
                    return Center(
                      child: CircularProgressIndicator(color: c.accent),
                    );
                  }
                  if (entries.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          'No nights yet. Tap + to log your first one.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: c.textMuted,
                          ),
                        ),
                      ),
                    );
                  }
                  // Forget hidden ids once the delete reached the stream (so an
                  // "Undo" shows the row again).
                  _hidden.removeWhere(
                    (id) => !entries.any((e) => e.id == id),
                  );
                  return _HistoryList(
                    all: entries
                        .where((e) => !_hidden.contains(e.id))
                        .map((e) => e.toModel())
                        .toList(),
                    goalMinutes: settings.sleepGoalMinutes,
                    onOpen: _openLog,
                    onDelete: _delete,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryList extends StatelessWidget {
  const _HistoryList({
    required this.all,
    required this.goalMinutes,
    required this.onOpen,
    required this.onDelete,
  });

  /// Nights and naps, newest first.
  final List<SleepNight> all;
  final int goalMinutes;
  final ValueChanged<SleepNight> onOpen;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    // Scores are worked out among nights only (naps have no score).
    final nights = all.where((n) => !n.isNap).toList();
    final scoreById = <int, int>{};
    for (var i = 0; i < nights.length; i++) {
      final id = nights[i].id;
      if (id != null) {
        scoreById[id] =
            scoreAt(nights, i, goalMinutes: goalMinutes).sleepScore;
      }
    }

    // Flatten into month headers + rows.
    final items = <Object>[];
    String? lastMonth;
    for (final n in all) {
      final month = formatMonthYear(n.wakeTime);
      if (month != lastMonth) {
        items.add(month);
        lastMonth = month;
      }
      items.add(n);
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 32),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        if (item is String) {
          return Padding(
            padding: EdgeInsets.only(top: index == 0 ? 4 : 18),
            child: SectionHeader(item.toUpperCase()),
          );
        }
        final night = item as SleepNight;
        final id = night.id;
        final row = Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _NightRow(
            night: night,
            score: id == null ? null : scoreById[id],
            onTap: () => onOpen(night),
          ),
        );
        if (id == null) return row;
        return Dismissible(
          key: ValueKey<int>(id),
          direction: DismissDirection.endToStart,
          background: const _DeleteBackground(),
          onDismissed: (_) => onDelete(id),
          child: row,
        );
      },
    );
  }
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.only(right: 24),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: c.danger,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
    );
  }
}

class _NightRow extends StatelessWidget {
  const _NightRow({
    required this.night,
    required this.score,
    required this.onTap,
  });

  final SleepNight night;
  final int? score;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final s = score;
    final muted = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: c.textMuted,
    );
    return Semantics(
      button: true,
      label: '${formatLongDate(night.wakeTime)}. '
          '${formatDuration(night.totalAsleep)} asleep'
          '${s == null ? '' : ', score $s'}. Tap to edit.',
      onTap: onTap,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: ClayCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              SizedBox(
                width: 44,
                child: Column(
                  children: [
                    Text(
                      weekdayShort(night.wakeTime).toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: c.textMuted,
                      ),
                    ),
                    Text(
                      '${night.wakeTime.day}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${formatDuration(night.totalAsleep)} '
                      '${night.isNap ? 'nap' : 'asleep'}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${formatTime(night.bedtime)} – '
                      '${formatTime(night.wakeTime)}',
                      style: muted,
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 10,
                      runSpacing: 4,
                      children: [
                        if (night.isImported)
                          _Badge(icon: Icons.watch_rounded, text: 'Watch'),
                        if (night.stages != null)
                          _Badge(icon: Icons.layers_outlined, text: 'Stages'),
                        if (night.restingHeartRate != null)
                          _Badge(
                            icon: Icons.favorite_border_rounded,
                            text: '${night.restingHeartRate} bpm',
                          ),
                        if (night.mood != null)
                          _Badge(
                            icon: Icons.sentiment_satisfied_alt_rounded,
                            text: 'Mood ${night.mood}',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              if (night.isNap)
                _ScoreBubble(text: 'Nap', color: c.lightSleep)
              else if (s != null)
                _ScoreBubble(text: '$s', color: scoreColor(c, s)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Colour for a score: blue when good, orange when low.
Color scoreColor(ClayColors c, int score) {
  if (score >= 80) return c.remSleep;
  if (score >= 60) return c.accent;
  return c.vitals;
}

class _Badge extends StatelessWidget {
  const _Badge({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: c.textMuted),
        const SizedBox(width: 3),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: c.textMuted,
          ),
        ),
      ],
    );
  }
}

class _ScoreBubble extends StatelessWidget {
  const _ScoreBubble({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClayInset(
      width: 52,
      height: 52,
      radius: 26,
      depth: 3,
      child: Text(
        text,
        style: TextStyle(
          fontSize: text.length > 2 ? 13 : 18,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}
