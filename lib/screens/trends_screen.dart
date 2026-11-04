import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../app_scope.dart';
import '../data/database.dart';
import '../logic/trends.dart';
import '../theme/clay_theme.dart';
import '../utils/formatters.dart';
import '../widgets/clay.dart';
import 'history_screen.dart';
import 'home_screen.dart' show StageLegendItem;

/// Trends tab: last 7 or 30 days of sleep, score, bedtime and stages.
class TrendsScreen extends StatefulWidget {
  const TrendsScreen({super.key});

  @override
  State<TrendsScreen> createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen> {
  late final Stream<List<SleepEntry>> _nights =
      AppScope.of(context).db.watchNights(limit: 120);
  int _range = 7;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final settings = SettingsScope.of(context);
    return SafeArea(
      bottom: false,
      child: StreamBuilder<List<SleepEntry>>(
        stream: _nights,
        builder: (context, snapshot) {
          final entries = snapshot.data;
          if (entries == null) {
            return Center(child: CircularProgressIndicator(color: c.accent));
          }
          final nights = entries.map((e) => e.toModel()).toList();
          final trends = buildTrends(
            nights,
            days: _range,
            goalMinutes: settings.sleepGoalMinutes,
          );
          return ListView(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
            children: [
              const Text(
                'Trends',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              ClaySegmented<int>(
                segments: const [
                  ClaySegment(value: 7, label: '7 days'),
                  ClaySegment(value: 30, label: '30 days'),
                ],
                selected: _range,
                onChanged: (value) => setState(() => _range = value),
              ),
              const SizedBox(height: 20),
              if (trends.isEmpty)
                _EmptyTrends(range: _range)
              else
                ..._content(context, trends, settings.sleepGoalMinutes),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _content(
    BuildContext context,
    TrendSummary t,
    int goalMinutes,
  ) {
    final c = context.clay;
    final avgAsleep = t.avgAsleepMinutes;
    final avgScore = t.avgScore;
    final avgBed = t.avgBedtimeMinutes;
    final avgWake = t.avgWakeMinutes;
    final spread = t.bedtimeSpreadMinutes;
    final stages = t.stages;
    final rhr = t.avgRestingHeartRate;
    final hrv = t.avgHrv;

    return [
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.55,
        // Room for the clay shadows.
        padding: const EdgeInsets.all(2),
        children: [
          _StatTile(
            label: 'Avg sleep',
            value: avgAsleep == null ? '—' : formatMinutes(avgAsleep),
            caption: '${t.nightsOnGoal} of ${t.nightsLogged} on goal',
          ),
          _StatTile(
            label: 'Avg score',
            value: avgScore == null ? '—' : '${avgScore.round()}',
            caption: '${t.nightsLogged} nights logged',
          ),
          _StatTile(
            label: 'Avg bedtime',
            value: avgBed == null ? '—' : formatMinutesOfDay(avgBed),
            caption: avgWake == null
                ? ''
                : 'Wake ${formatMinutesOfDay(avgWake)}',
          ),
          _StatTile(
            label: 'Sleep debt',
            value: formatMinutes(t.sleepDebtMinutes),
            caption: 'Last 7 nights',
            valueColor: t.sleepDebtMinutes > 120 ? c.vitals : null,
          ),
        ],
      ),
      const SizedBox(height: 22),
      const SectionHeader('SLEEP DURATION'),
      ClayCard(
        padding: const EdgeInsets.fromLTRB(8, 20, 16, 12),
        child: SizedBox(
          height: 200,
          child: _DurationChart(points: t.days, goalMinutes: goalMinutes),
        ),
      ),
      const SizedBox(height: 22),
      const SectionHeader('SLEEP SCORE'),
      ClayCard(
        padding: const EdgeInsets.fromLTRB(8, 20, 16, 12),
        child: SizedBox(height: 180, child: _ScoreChart(points: t.days)),
      ),
      const SizedBox(height: 22),
      const SectionHeader('CONSISTENCY'),
      ClayCard(
        child: Row(
          children: [
            Icon(Icons.schedule_rounded, color: c.accent, size: 28),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                spread == null
                    ? 'Log a few more nights to see how steady your '
                        'bedtime is.'
                    : 'Your bedtime varies by about '
                        '±${spread.round()} min. '
                        '${spread <= 30 ? 'Nice and steady.' : 'A steadier bedtime usually means better sleep.'}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
      if (stages != null) ...[
        const SizedBox(height: 22),
        const SectionHeader('SLEEP STAGES (AVERAGE)'),
        ClayCard(child: _StageBar(stages: stages)),
      ],
      if (rhr != null || hrv != null) ...[
        const SizedBox(height: 22),
        const SectionHeader('HEART'),
        Row(
          children: [
            Expanded(
              child: _StatTile(
                label: 'Resting HR',
                value: rhr == null ? '—' : '${rhr.round()} bpm',
                caption: 'Average',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StatTile(
                label: 'HRV',
                value: hrv == null ? '—' : '${hrv.round()} ms',
                caption: 'Average',
              ),
            ),
          ],
        ),
      ],
      const SizedBox(height: 22),
      ClayPillButton(
        label: 'See all nights',
        icon: Icons.history_rounded,
        filled: false,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const HistoryScreen()),
        ),
      ),
    ];
  }
}

class _EmptyTrends extends StatelessWidget {
  const _EmptyTrends({required this.range});

  final int range;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    return ClayCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Icon(Icons.insights_rounded, size: 40, color: c.remSleep),
          const SizedBox(height: 12),
          Text(
            'No nights in the last $range days',
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'Log a few nights and your trends will show up here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: c.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.caption,
    this.valueColor,
  });

  final String label;
  final String value;
  final String caption;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    return ClayCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: c.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: valueColor ?? c.text,
              ),
            ),
          ),
          if (caption.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: c.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Bottom axis label: weekday letter for 7 days, day number every 5 days
/// for 30 days.
Widget _bottomLabel(
  BuildContext context,
  List<DayPoint> points,
  double value,
  TitleMeta meta,
) {
  final c = context.clay;
  final i = value.round();
  if (i < 0 || i >= points.length || (value - i).abs() > 0.01) {
    return const SizedBox.shrink();
  }
  final day = points[i].day;
  final String text;
  if (points.length <= 7) {
    text = weekdayLetter(day);
  } else if (i % 5 == 4 || i == points.length - 1) {
    text = '${day.day}';
  } else {
    return const SizedBox.shrink();
  }
  return SideTitleWidget(
    meta: meta,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: c.textMuted,
      ),
    ),
  );
}

class _DurationChart extends StatelessWidget {
  const _DurationChart({required this.points, required this.goalMinutes});

  final List<DayPoint> points;
  final int goalMinutes;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final goalHours = goalMinutes / 60;
    var maxHours = goalHours + 2;
    for (final p in points) {
      final hours = (p.asleepMinutes ?? 0) / 60;
      if (hours + 1 > maxHours) maxHours = hours + 1;
    }
    final maxY = (maxHours / 2).ceil() * 2.0;
    final barWidth = points.length <= 7 ? 18.0 : 6.0;
    final axisStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: c.textMuted,
    );

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        minY: 0,
        maxY: maxY,
        barGroups: [
          for (var i = 0; i < points.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: (points[i].asleepMinutes ?? 0) / 60,
                  width: barWidth,
                  color: (points[i].asleepMinutes ?? 0) >= goalMinutes - 15
                      ? c.remSleep
                      : c.lightSleep,
                  borderRadius: BorderRadius.circular(barWidth / 2),
                ),
              ],
            ),
        ],
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 2,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: c.trackOff, strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: goalHours,
              color: c.accent,
              strokeWidth: 1.5,
              dashArray: const [6, 4],
            ),
          ],
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 2,
              getTitlesWidget: (value, meta) => SideTitleWidget(
                meta: meta,
                child: Text('${value.round()}h', style: axisStyle),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 26,
              getTitlesWidget: (value, meta) =>
                  _bottomLabel(context, points, value, meta),
            ),
          ),
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => c.text,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final p = points[group.x];
              final minutes = p.asleepMinutes;
              return BarTooltipItem(
                '${formatShortDate(p.day)}\n'
                '${minutes == null ? 'No data' : formatMinutes(minutes)}',
                TextStyle(
                  color: c.background,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ScoreChart extends StatelessWidget {
  const _ScoreChart({required this.points});

  final List<DayPoint> points;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final spots = <FlSpot>[
      for (var i = 0; i < points.length; i++)
        if (points[i].score != null)
          FlSpot(i.toDouble(), points[i].score!.toDouble()),
    ];
    final axisStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: c.textMuted,
    );

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (points.length - 1).toDouble(),
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            preventCurveOverShooting: true,
            color: c.accent,
            barWidth: 3,
            dotData: FlDotData(show: points.length <= 7),
            belowBarData: BarAreaData(
              show: true,
              color: c.accent.withValues(alpha: 0.12),
            ),
          ),
        ],
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 25,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: c.trackOff, strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 25,
              getTitlesWidget: (value, meta) => SideTitleWidget(
                meta: meta,
                child: Text('${value.round()}', style: axisStyle),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 26,
              interval: 1,
              getTitlesWidget: (value, meta) =>
                  _bottomLabel(context, points, value, meta),
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (spot) => c.text,
            getTooltipItems: (touchedSpots) => touchedSpots
                .map(
                  (s) => LineTooltipItem(
                    '${formatShortDate(points[s.x.round()].day)}\n'
                    'Score ${s.y.round()}',
                    TextStyle(
                      color: c.background,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _StageBar extends StatelessWidget {
  const _StageBar({required this.stages});

  final StageAverages stages;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final total = stages.total <= 0 ? 1 : stages.total;
    int pct(double v) => (v / total * 100).round();
    int flex(double v) => v <= 0 ? 1 : v.round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 16,
            child: Row(
              children: [
                Expanded(
                  flex: flex(stages.deepMinutes),
                  child: ColoredBox(color: c.deepSleep),
                ),
                const SizedBox(width: 3),
                Expanded(
                  flex: flex(stages.remMinutes),
                  child: ColoredBox(color: c.remSleep),
                ),
                const SizedBox(width: 3),
                Expanded(
                  flex: flex(stages.lightMinutes),
                  child: ColoredBox(color: c.lightSleep),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: StageLegendItem(
                color: c.deepSleep,
                label: 'Deep ${pct(stages.deepMinutes)}%',
                value: formatMinutes(stages.deepMinutes),
              ),
            ),
            Expanded(
              child: StageLegendItem(
                color: c.remSleep,
                label: 'REM ${pct(stages.remMinutes)}%',
                value: formatMinutes(stages.remMinutes),
              ),
            ),
            Expanded(
              child: StageLegendItem(
                color: c.lightSleep,
                label: 'Light ${pct(stages.lightMinutes)}%',
                value: formatMinutes(stages.lightMinutes),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Based on ${stages.nights} '
          '${stages.nights == 1 ? 'night' : 'nights'} with watch data.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: c.textMuted,
          ),
        ),
      ],
    );
  }
}
