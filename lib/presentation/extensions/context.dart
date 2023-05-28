import 'package:flutter/material.dart';

extension BC on BuildContext {
  /// Builtin getters

  double get w => MediaQuery.of(this).size.width;

  double get h => MediaQuery.of(this).size.height;

  MediaQueryData get mq => MediaQuery.of(this);

  RenderBox? get renderBox => findRenderObject() != null ? findRenderObject() as RenderBox : null;

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);
}
