import 'package:flutter/material.dart';

import '../theme/clay_theme.dart';

/// Raised card.
class ClayCard extends StatelessWidget {
  const ClayCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 22,
    this.depth = 6,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final double depth;

  /// Defaults to the clay background.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? c.background,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: c.raised(depth),
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
    final c = context.clay;
    final content = child;
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _InsetPainter(
          radius: radius,
          depth: depth,
          background: c.background,
          dark: c.shadowDark,
          light: c.shadowLight,
        ),
        child: content == null ? null : Center(child: content),
      ),
    );
  }
}

class _InsetPainter extends CustomPainter {
  const _InsetPainter({
    required this.radius,
    required this.depth,
    required this.background,
    required this.dark,
    required this.light,
  });

  final double radius;
  final double depth;
  final Color background;
  final Color dark;
  final Color light;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    canvas.drawRRect(rrect, Paint()..color = background);

    canvas.save();
    canvas.clipRRect(rrect);
    _innerShadow(canvas, rrect, Offset(depth, depth), dark);
    _innerShadow(canvas, rrect, Offset(-depth, -depth), light);
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
    return oldDelegate.radius != radius ||
        oldDelegate.depth != depth ||
        oldDelegate.background != background ||
        oldDelegate.dark != dark ||
        oldDelegate.light != light;
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
    this.color,
    this.selected = false,
  });

  final VoidCallback? onTap;
  final String semanticLabel;
  final Widget child;
  final double size;
  final double depth;

  /// Defaults to the clay background.
  final Color? color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    return Semantics(
      button: true,
      selected: selected,
      enabled: onTap != null,
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
            color: color ?? c.background,
            shape: BoxShape.circle,
            boxShadow: c.raised(depth),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Wide pill button. [filled] = accent colour (main action).
/// Pass onTap: null to show it disabled.
class ClayPillButton extends StatelessWidget {
  const ClayPillButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.filled = true,
    this.danger = false,
    this.height = 52,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool filled;

  /// Red text, for destructive actions (only when not filled).
  final bool danger;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final foreground = filled ? c.onAccent : (danger ? c.danger : c.text);
    final buttonIcon = icon;
    return Semantics(
      button: true,
      enabled: onTap != null,
      label: label,
      onTap: onTap,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: onTap == null ? 0.5 : 1,
          child: Container(
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: filled ? c.accent : c.background,
              borderRadius: BorderRadius.circular(height / 2),
              boxShadow: c.raised(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (buttonIcon != null) ...[
                  Icon(buttonIcon, size: 20, color: foreground),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: foreground,
                    ),
                  ),
                ),
              ],
            ),
          ),
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

  /// Null = disabled.
  final ValueChanged<bool>? onChanged;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    const duration = Duration(milliseconds: 180);
    final onChanged = this.onChanged;
    void toggle() => onChanged?.call(!value);
    return Semantics(
      label: semanticLabel,
      toggled: value,
      enabled: onChanged != null,
      onTap: onChanged == null ? null : toggle,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onChanged == null ? null : toggle,
        child: Opacity(
          opacity: onChanged == null ? 0.5 : 1,
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
                  color: value ? c.accent : c.trackOff,
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
      ),
    );
  }
}

/// Small selectable pill (habit tags, filters).
class ClayChip extends StatelessWidget {
  const ClayChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final foreground = selected ? c.onAccent : c.text;
    final chipIcon = icon;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      onTap: onTap,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          constraints: const BoxConstraints(minHeight: 40),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? c.accent : c.background,
            borderRadius: BorderRadius.circular(20),
            boxShadow: c.raised(3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (chipIcon != null) ...[
                Icon(chipIcon, size: 18, color: foreground),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClaySegment<T> {
  const ClaySegment({required this.value, required this.label});

  final T value;
  final String label;
}

/// Segmented control: a pressed-in track with the selected option raised.
class ClaySegmented<T> extends StatelessWidget {
  const ClaySegmented({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
  });

  final List<ClaySegment<T>> segments;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    return ClayInset(
      height: 48,
      radius: 24,
      depth: 3,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            for (final segment in segments)
              Expanded(
                child: Semantics(
                  button: true,
                  selected: segment.value == selected,
                  label: segment.label,
                  onTap: () => onChanged(segment.value),
                  excludeSemantics: true,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onChanged(segment.value),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: segment.value == selected
                            ? c.background
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: segment.value == selected
                            ? c.raised(2)
                            : const <BoxShadow>[],
                      ),
                      child: Text(
                        segment.label,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: segment.value == selected
                              ? c.accent
                              : c.textMuted,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// A row inside a ClayCard: icon, title, optional subtitle, trailing widget.
class ClayListTile extends StatelessWidget {
  const ClayListTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.titleColor,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final sub = subtitle;
    final tail = trailing;
    final row = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 22, color: iconColor ?? c.accent),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: titleColor ?? c.text,
                  ),
                ),
                if (sub != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    sub,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: c.textMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (tail != null) ...[const SizedBox(width: 8), tail],
          if (tail == null && onTap != null)
            Icon(Icons.chevron_right_rounded, color: c.textMuted),
        ],
      ),
    );
    final tap = onTap;
    if (tap == null) return row;
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: tap,
        child: row,
      ),
    );
  }
}

/// Bold section title used above groups of cards.
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final trailing = action;
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
                color: c.textMuted,
              ),
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}

/// Thin pressed-in progress bar.
class ClayProgressBar extends StatelessWidget {
  const ClayProgressBar({
    super.key,
    required this.value,
    required this.color,
    this.height = 8,
  });

  /// 0 to 1.
  final double value;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClayInset(radius: height / 2, depth: 2),
          ),
          FractionallySizedBox(
            widthFactor: value.clamp(0.0, 1.0).toDouble(),
            heightFactor: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Round back button + big title, used at the top of pushed screens.
class ClayScreenHeader extends StatelessWidget {
  const ClayScreenHeader({super.key, required this.title, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final trailing = action;
    return Row(
      children: [
        ClayCircleButton(
          onTap: () => Navigator.of(context).maybePop(),
          semanticLabel: 'Back',
          child: Icon(Icons.arrow_back_rounded, color: c.text),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }
}

/// Shows a snack bar, replacing any one already visible.
void showClaySnack(
  BuildContext context,
  String message, {
  String? actionLabel,
  VoidCallback? onAction,
}) {
  final label = actionLabel;
  final action = onAction;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        action: (label != null && action != null)
            ? SnackBarAction(label: label, onPressed: action)
            : null,
      ),
    );
}

/// Yes / no dialog. Returns true when confirmed.
Future<bool> confirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool danger = false,
}) async {
  final c = context.clay;
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: c.background,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            confirmLabel,
            style: TextStyle(
              color: danger ? c.danger : c.accent,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    ),
  );
  return result ?? false;
}
