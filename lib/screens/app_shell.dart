import 'package:flutter/material.dart';

import '../widgets/clay_nav_bar.dart';
import 'coming_soon_screen.dart';
import 'home_screen.dart';

/// Holds the bottom bar and switches between the four tabs.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  static const _tabs = [
    ClayNavItem(icon: Icons.home_rounded, label: 'Home'),
    ClayNavItem(icon: Icons.show_chart_rounded, label: 'Trends'),
    ClayNavItem(icon: Icons.lightbulb_outline_rounded, label: 'Insights'),
    ClayNavItem(icon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          HomeScreen(),
          ComingSoonScreen(title: 'Trends'),
          ComingSoonScreen(title: 'Insights'),
          ComingSoonScreen(title: 'Profile'),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(22, 10, 22, 16),
        child: ClayNavBar(
          items: _tabs,
          currentIndex: _index,
          onTap: (index) => setState(() => _index = index),
        ),
      ),
    );
  }
}
