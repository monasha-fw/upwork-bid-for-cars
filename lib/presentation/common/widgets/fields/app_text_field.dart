import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.hasLabel = false,
    this.onTap,
    this.keyboardType,
    this.inputFormatters,
    this.disabled = false,
    this.textCapitalization,
  }) : super(key: key);

  final String label;
  final bool hasLabel;
  final String hint;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool disabled;
  final TextCapitalization? textCapitalization;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscuring = false;

  @override
  void initState() {
    obscuring = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AbsorbPointer(
        absorbing: widget.onTap != null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.hasLabel)
              Text(
                widget.label,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: AppColors.kTextSub,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            TextFormField(
              textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,
              enabled: !widget.disabled,

              /// added bottom padding to avoid the bottom button from hiding the field when keyboard is focused
              scrollPadding: const EdgeInsets.only(bottom: 100),

              style: context.theme.textTheme.titleMedium,
              obscureText: obscuring,
              controller: widget.controller,
              focusNode: widget.focusNode,
              onChanged: widget.onChanged,
              validator: widget.validator,
              onFieldSubmitted: widget.onSubmitted,
              keyboardType: widget.obscureText && obscuring
                  ? TextInputType.visiblePassword
                  : widget.keyboardType ?? TextInputType.text,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                labelText: widget.label,
                hintText: widget.hint,
                errorMaxLines: 3,
                alignLabelWithHint: true,
                prefixText: widget.prefixText,
                prefixStyle: context.theme.textTheme.titleMedium,
                prefixIcon: widget.prefixIcon,
                suffixIconConstraints: const BoxConstraints(minWidth: 20),
                suffixIcon: widget.obscureText
                    ? GestureDetector(
                        onTap: () => setState(() => obscuring = !obscuring),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            obscuring ? Icons.visibility : Icons.visibility_off,
                            color: AppColors.kFieldIcon,
                          ),
                        ),
                      )
                    : widget.suffixIcon,
              ).applyDefaults(context.theme.inputDecorationTheme),
            ),
          ],
        ),
      ),
    );
  }
}
