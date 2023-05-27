import 'package:flutter/material.dart';

/// Creates a fixed vertical size box. The [height] parameter can't be null
/// ```dart
/// const HSB(200.0)
/// ```
class HSB extends StatelessWidget {
  const HSB(this.height, {Key? key}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
