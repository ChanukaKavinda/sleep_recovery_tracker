import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Two soft shadows (dark bottom-right, light top-left) that make a surface
/// look raised out of the background.
List<BoxShadow> clayShadows(double depth) {
  return [
    BoxShadow(
      color: AppColors.shadowDark,
      offset: Offset(depth, depth),
      blurRadius: depth * 2,
    ),
    BoxShadow(
      color: AppColors.shadowLight,
      offset: Offset(-depth, -depth),
      blurRadius: depth * 2,
    ),
  ];
}

/// Raised card.
class ClayCard extends StatelessWidget {
  const ClayCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 22,
    this.depth = 6,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final double depth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: clayShadows(depth),
      ),
      child: child,
    );
  }
}

/// Pressed-in surface (inner shadow). Flutter's BoxShadow cannot draw inside
/// a box, so this one is painted by hand.
class ClayInset extends StatelessWidget {
  const ClayInset({
    super.key,
    this.child,
    this.width,
    this.height,
    this.radius = 22,
    this.depth = 4,
  });

  final Widget? child;
  final double? width;
  final double? height;
  final double radius;
  final double depth;

  @override
  Widget build(BuildContext context) {
    final content = child;
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _InsetPainter(radius: radius, depth: depth),
        child: content == null ? null : Center(child: content),
      ),
    );
  }
}

class _InsetPainter extends CustomPainter {
  const _InsetPainter({required this.radius, required this.depth});

  final double radius;
  final double depth;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    canvas.drawRRect(rrect, Paint()..color = AppColors.background);

    canvas.save();
    canvas.clipRRect(rrect);
    _innerShadow(canvas, rrect, Offset(depth, depth), AppColors.shadowDark);
    _innerShadow(canvas, rrect, Offset(-depth, -depth), AppColors.shadowLight);
    canvas.restore();
  }

  /// Fills everything except the shifted shape, blurred. Clipped to the
  /// shape, that leaves a soft shadow along the inner edge.
  void _innerShadow(Canvas canvas, RRect rrect, Offset offset, Color color) {
    final frame = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(rrect.outerRect.inflate(depth * 6))
      ..addRRect(rrect.shift(offset));
    canvas.drawPath(
      frame,
      Paint()
        ..color = color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, depth),
    );
  }

  @override
  bool shouldRepaint(covariant _InsetPainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.depth != depth;
  }
}

/// Raised round button.
class ClayCircleButton extends StatelessWidget {
  const ClayCircleButton({
    super.key,
    required this.onTap,
    required this.semanticLabel,
    required this.child,
    this.size = 48,
    this.depth = 4,
    this.color = AppColors.background,
    this.selected = false,
  });

  final VoidCallback onTap;
  final String semanticLabel;
  final Widget child;
  final double size;
  final double depth;
  final Color color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: semanticLabel,
      onTap: onTap,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: clayShadows(depth),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// On/off switch in the clay style.
class ClaySwitch extends StatelessWidget {
  const ClaySwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.semanticLabel,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 180);
    return Semantics(
      label: semanticLabel,
      toggled: value,
      onTap: () => onChanged(!value),
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onChanged(!value),
        child: SizedBox(
          width: 56,
          height: 44,
          child: Center(
            child: AnimatedContainer(
              duration: duration,
              width: 56,
              height: 32,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: value ? AppColors.accent : AppColors.trackOff,
                borderRadius: BorderRadius.circular(16),
              ),
              child: AnimatedAlign(
                duration: duration,
                alignment:
                    value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
