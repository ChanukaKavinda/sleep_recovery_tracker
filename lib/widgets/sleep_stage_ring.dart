import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/sleep_night.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import 'clay.dart';

/// The big dial on the home screen.
/// - With stages: the ring is the whole night, split into deep / REM / light
///   (three blues).
/// - Without stages (manual log): one blue arc showing time asleep vs the
///   sleep goal.
/// The number in the middle is the sleep score.
class SleepStageRing extends StatelessWidget {
  const SleepStageRing({
    super.key,
    required this.night,
    required this.score,
    required this.goalMinutes,
    this.size = 196,
  });

  final SleepNight night;
  final int score;
  final int goalMinutes;
  final double size;

  @override
  Widget build(BuildContext context) {
    final innerSize = size - 52;
    final stages = night.stages;

    final List<double> values;
    final List<Color> colors;
    final String description;
    if (stages != null) {
      values = [
        stages.deep.inMinutes.toDouble(),
        stages.rem.inMinutes.toDouble(),
        stages.light.inMinutes.toDouble(),
      ];
      colors = const [
        AppColors.deepSleep,
        AppColors.remSleep,
        AppColors.lightSleep,
      ];
      description = 'Deep ${formatDuration(stages.deep)}, '
          'REM ${formatDuration(stages.rem)}, '
          'Light ${formatDuration(stages.light)}.';
    } else {
      final asleep = night.totalAsleep.inMinutes.toDouble();
      final rest = asleep >= goalMinutes ? 0.0 : goalMinutes - asleep;
      values = [asleep, rest];
      colors = const [AppColors.remSleep, Colors.transparent];
      description = '${formatDuration(night.totalAsleep)} asleep.';
    }

    return Semantics(
      label: 'Sleep score $score. $description',
      excludeSemantics: true,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Raised disc.
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                  boxShadow: clayShadows(10),
                ),
              ),
            ),
            // Coloured segments.
            Positioned.fill(
              child: CustomPaint(
                painter: _RingPainter(values: values, colors: colors),
              ),
            ),
            // Pressed-in centre with the score.
            ClayInset(
              width: innerSize,
              height: innerSize,
              radius: innerSize / 2,
              depth: 6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$score',
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                  const Text(
                    'Sleep score',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.values, required this.colors});

  final List<double> values;
  final List<Color> colors;

  static const double _strokeWidth = 10;
  static const double _edgeInset = 14;
  static const double _gap = 6;

  @override
  void paint(Canvas canvas, Size size) {
    final total = values.fold<double>(0, (sum, v) => sum + v);
    if (total <= 0) return;

    final radius = size.shortestSide / 2 - _edgeInset;
    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: radius,
    );
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;

    // Round caps stick out by half the stroke on each end, so every arc is
    // shortened by (stroke + gap) to leave a clean gap between segments.
    final trim = (_strokeWidth + _gap) / radius;

    var start = -math.pi / 2; // 12 o'clock
    for (var i = 0; i < values.length; i++) {
      final sweep = values[i] / total * 2 * math.pi;
      if (sweep > trim && colors[i] != Colors.transparent) {
        paint.color = colors[i];
        canvas.drawArc(rect, start + trim / 2, sweep - trim, false, paint);
      }
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    if (oldDelegate.values.length != values.length) return true;
    for (var i = 0; i < values.length; i++) {
      if (oldDelegate.values[i] != values[i] ||
          oldDelegate.colors[i] != colors[i]) {
        return true;
      }
    }
    return false;
  }
}
