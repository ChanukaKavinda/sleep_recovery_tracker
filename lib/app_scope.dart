import 'package:flutter/widgets.dart';

import 'data/database.dart';

/// Gives every screen access to the app's single database (and, in later
/// days, the services) without passing them through every constructor.
///
///   final db = AppScope.of(context).db;
class AppScope extends InheritedWidget {
  const AppScope({super.key, required this.db, required super.child});

  final AppDatabase db;

  /// Safe to call anywhere, including button callbacks and initState.
  static AppScope of(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope is missing above this widget.');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) => db != oldWidget.db;
}

/// The current settings row. Widgets that call [SettingsScope.of] rebuild
/// automatically whenever a setting changes.
class SettingsScope extends InheritedWidget {
  const SettingsScope({
    super.key,
    required this.settings,
    required super.child,
  });

  final SettingsRow settings;

  static SettingsRow of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SettingsScope>();
    assert(scope != null, 'SettingsScope is missing above this widget.');
    return scope!.settings;
  }

  @override
  bool updateShouldNotify(SettingsScope oldWidget) =>
      settings != oldWidget.settings;
}
