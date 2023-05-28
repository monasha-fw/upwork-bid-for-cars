import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.postFixWidget,
    this.disabled = false,
    this.loading = false,
    this.color,
    this.textColor,
    this.labelWidget,
    this.padding,
  }) : super(key: key);

  final String label;
  final Widget? labelWidget;
  final VoidCallback? onPressed;
  final Widget? postFixWidget;
  final bool disabled;
  final bool loading;
  final Color? color;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;

  Color getBackgroundColor(BuildContext context, Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    const Set<MaterialState> disabledStates = <MaterialState>{MaterialState.disabled};

    if (states.any(disabledStates.contains) || loading) return context.theme.disabledColor;

    var bgColor = color ?? context.theme.colorScheme.primary;
    if (states.any(interactiveStates.contains)) return bgColor;
    return bgColor;
  }

  @override
  Widget build(BuildContext context) {
    // TODO disabled UI

    final tColor = textColor ?? context.theme.colorScheme.onPrimary;
    final txtStyle = context.theme.textTheme.labelLarge?.copyWith(color: tColor);

    return ElevatedButton(
      onPressed: disabled || loading ? null : onPressed,
      style: context.theme.elevatedButtonTheme.style?.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => getBackgroundColor(context, states),
        ),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            loading
                ? Center(child: CircularProgressIndicator(color: tColor))
                : Container(
                    alignment: Alignment.center,
                    child: labelWidget ?? Text(label, style: txtStyle),
                  ),
            if (postFixWidget != null)
              Container(alignment: Alignment.centerRight, child: postFixWidget!),
          ],
        ),
      ),
    );
  }
}
