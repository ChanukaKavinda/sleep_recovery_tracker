import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_scope.dart';
import 'data/database.dart';
import 'screens/app_shell.dart';
import 'theme/app_theme.dart';
import 'theme/clay_theme.dart';

class SleepRecoveryApp extends StatefulWidget {
  const SleepRecoveryApp({super.key, required this.db});

  final AppDatabase db;

  @override
  State<SleepRecoveryApp> createState() => _SleepRecoveryAppState();
}

class _SleepRecoveryAppState extends State<SleepRecoveryApp> {
  late final Stream<SettingsRow> _settings = widget.db.watchSettings();

  @override
  Widget build(BuildContext context) {
    return AppScope(
      db: widget.db,
      child: StreamBuilder<SettingsRow>(
        stream: _settings,
        builder: (context, snapshot) {
          final settings = snapshot.data;
          if (settings == null) {
            // First frame, before the database answers.
            return ColoredBox(color: ClayColors.light.background);
          }
          return SettingsScope(
            settings: settings,
            child: MaterialApp(
              title: 'Sleep & Recovery',
              debugShowCheckedModeBanner: false,
              theme: buildAppTheme(ClayColors.light, Brightness.light),
              builder: (context, child) {
                return AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.dark.copyWith(
                    statusBarColor: Colors.transparent,
                  ),
                  child: child ?? const SizedBox.shrink(),
                );
              },
              home: const AppShell(),
            ),
          );
        },
      ),
    );
  }
}
