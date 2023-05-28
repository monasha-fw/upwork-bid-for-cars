import 'dart:async';

import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppCodeField extends StatelessWidget {
  const AppCodeField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.errorController,
    required this.onCompleted,
    required this.onChanged,
    this.initialValue,
    this.inputFormatters,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  final ValueChanged<String> onCompleted;
  final FocusNode? focusNode;
  final Function(String) onChanged;
  final String? initialValue;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final StreamController<ErrorAnimationType>? errorController;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: initialValue,
      builder: (FormFieldState<String> state) {
        return PinCodeTextField(
          appContext: context,
          length: 6,
          animationType: AnimationType.fade,
          useHapticFeedback: true,
          autoFocus: true,
          focusNode: focusNode,
          autoDismissKeyboard: true,
          keyboardType: keyboardType ?? TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(15),
            fieldHeight: 50,
            fieldWidth: 50,
            activeFillColor: Colors.white,
            activeColor: AppColors.kBorder,
            inactiveColor: AppColors.kBorder,
            selectedColor: AppColors.kPrimary,
            errorBorderColor: AppColors.kError,
          ),
          animationDuration: const Duration(milliseconds: 300),
          controller: controller,
          inputFormatters: inputFormatters ??
              [
                /// default numbers only formatter
                FilteringTextInputFormatter.allow(RegExp(r'\d'))
              ],
          onCompleted: onCompleted,
          onSubmitted: onCompleted,
          onChanged: onChanged,
          validator: validator,
          errorAnimationController: errorController,
          errorTextSpace: 20,
        );
      },
      validator: validator != null ? (v) => validator!(v) : null,
    );
  }
}
