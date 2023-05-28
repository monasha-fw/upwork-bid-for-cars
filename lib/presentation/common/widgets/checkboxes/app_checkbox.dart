import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_checkbox.freezed.dart';

@freezed
class AppCheckboxTextSection with _$AppCheckboxTextSection {
  const factory AppCheckboxTextSection({
    required String text,
    @Default(null) GestureRecognizer? onTap,
  }) = _AppCheckboxTextSection;
}

class AppCheckbox extends StatelessWidget {
  const AppCheckbox(
      {Key? key,
      required this.onChanged,
      required this.labelSections,
      required this.value,
      this.validator})
      : super(key: key);

  final ValueChanged<bool?> onChanged;
  final bool value;
  final List<AppCheckboxTextSection> labelSections;
  final FormFieldValidator<bool>? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: value,
      builder: (FormFieldState<bool> state) {
        return Container(
          transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
          child: Stack(
            children: [
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                contentPadding: EdgeInsets.only(bottom: state.errorText != null ? 10 : 0),
                title: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: RichText(
                    text: TextSpan(
                      text: labelSections.isNotEmpty ? labelSections[0].text : '',
                      style: context.theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                      children: <TextSpan>[
                        /// only generate the TextSpans, if count exceeds 1
                        if (labelSections.length > 1)
                          ...labelSections.sublist(1).map(
                                (e) => TextSpan(
                                  text: e.text,
                                  style: e.onTap == null
                                      ? null
                                      : context.theme.textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                  recognizer: e.onTap,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                value: value,
                onChanged: onChanged,
              ),
              if (state.errorText != null)
                Positioned.fill(
                  left: 10,
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(color: AppColors.kError, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      validator: validator != null ? (v) => validator!(v) : null,
    );
  }
}
