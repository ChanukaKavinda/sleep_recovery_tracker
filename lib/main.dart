import 'package:flutter/material.dart';

import 'app.dart';
import 'data/database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // One database for the whole app.
  final db = AppDatabase();
  runApp(SleepRecoveryApp(db: db));
}
