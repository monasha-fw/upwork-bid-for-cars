import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.disabled = false,
    this.loading = false,
    this.color,
  }) : super(key: key);

  final String label;
  final VoidCallback? onPressed;
  final bool disabled;
  final bool loading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var borderColor = color ?? AppColors.kPrimary;

    if (disabled || loading) {
      borderColor = AppColors.kDisabled;
    }

    return OutlinedButton(
      style: OutlinedButton.styleFrom(side: BorderSide(color: borderColor)),
      onPressed: disabled || loading ? null : onPressed,
      child: Text(label),
    );
  }
}
