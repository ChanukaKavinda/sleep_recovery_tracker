import 'package:flutter/material.dart';

import '../theme/clay_theme.dart';
import 'clay.dart';

class ClayNavItem {
  const ClayNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Floating bottom bar. The active tab looks pressed in.
class ClayNavBar extends StatelessWidget {
  const ClayNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<ClayNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return ClayCard(
      padding: const EdgeInsets.all(8),
      radius: 28,
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: _NavButton(
                  item: items[i],
                  selected: i == currentIndex,
                  onTap: () => onTap(i),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final ClayNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final icon = Icon(
      item.icon,
      size: 24,
      color: selected ? c.accent : c.textMuted,
    );
    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      onTap: onTap,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: selected
            ? ClayInset(height: 48, radius: 22, child: icon)
            : SizedBox(height: 48, child: Center(child: icon)),
      ),
    );
  }
}
