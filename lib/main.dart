import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/database.dart';
import 'screens/home_screen.dart';
import 'theme/app_colors.dart';
import 'widgets/clay_nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // One database for the whole app, passed down to the screens.
  final db = AppDatabase();
  runApp(SleepRecoveryApp(db: db));
}

class SleepRecoveryApp extends StatelessWidget {
  const SleepRecoveryApp({super.key, required this.db});

  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accent),
    );
    return MaterialApp(
      title: 'Sleep & Recovery',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        textTheme: GoogleFonts.nunitoTextTheme(base.textTheme).apply(
          bodyColor: AppColors.text,
          displayColor: AppColors.text,
        ),
      ),
      home: AppShell(db: db),
    );
  }
}

/// Holds the bottom bar and switches between the four tabs.
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.db});

  final AppDatabase db;

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: [
            HomeScreen(db: widget.db),
            const _ComingSoon(title: 'Trends'),
            const _ComingSoon(title: 'Insights'),
            const _ComingSoon(title: 'Profile'),
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
      ),
    );
  }
}

class _ComingSoon extends StatelessWidget {
  const _ComingSoon({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Coming soon',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
