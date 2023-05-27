import 'package:flutter/material.dart';

/// Creates a fixed horizontal size box. The [width] parameter can't be null
/// ```dart
/// const WSB(200.0)
/// ```
class WSB extends StatelessWidget {
  const WSB(this.width, {Key? key}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
