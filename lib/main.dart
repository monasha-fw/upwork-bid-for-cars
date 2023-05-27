import 'package:flutter/material.dart';

import 'injection.dart';
import 'presentation/common/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// injectable initialization
  configureDependencies();

  runApp(const App());
}
