import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.underlined = true,
    this.color,
  }) : super(key: key);

  final String label;
  final VoidCallback? onPressed;
  final bool underlined;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: color ?? AppColors.kPrimary,
          decoration: underlined ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}
