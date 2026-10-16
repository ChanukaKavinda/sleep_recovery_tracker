import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/sleep_night.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import 'clay.dart';

/// The big dial on the home screen. The ring is the whole night, split into
/// deep / REM / light sleep (three blues). The number in the middle is the
/// sleep score.
class SleepStageRing extends StatelessWidget {
  const SleepStageRing({super.key, required this.night, this.size = 196});

  final SleepNight night;
  final double size;

  @override
  Widget build(BuildContext context) {
    final innerSize = size - 52;
    return Semantics(
      label: 'Sleep score ${night.sleepScore}. '
          'Deep ${formatDuration(night.deep)}, '
          'REM ${formatDuration(night.rem)}, '
          'Light ${formatDuration(night.light)}.',
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
            // Stage segments.
            Positioned.fill(
              child: CustomPaint(
                painter: _StageRingPainter(
                  values: [
                    night.deep.inMinutes.toDouble(),
                    night.rem.inMinutes.toDouble(),
                    night.light.inMinutes.toDouble(),
                  ],
                  colors: const [
                    AppColors.deepSleep,
                    AppColors.remSleep,
                    AppColors.lightSleep,
                  ],
                ),
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
                    '${night.sleepScore}',
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

class _StageRingPainter extends CustomPainter {
  const _StageRingPainter({required this.values, required this.colors});

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
    // shortened by (stroke + gap) to leave a clean gap between stages.
    final trim = (_strokeWidth + _gap) / radius;

    var start = -math.pi / 2; // 12 o'clock
    for (var i = 0; i < values.length; i++) {
      final sweep = values[i] / total * 2 * math.pi;
      if (sweep > trim) {
        paint.color = colors[i];
        canvas.drawArc(rect, start + trim / 2, sweep - trim, false, paint);
      }
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _StageRingPainter oldDelegate) {
    if (oldDelegate.values.length != values.length) return true;
    for (var i = 0; i < values.length; i++) {
      if (oldDelegate.values[i] != values[i]) return true;
    }
    return false;
  }
}
