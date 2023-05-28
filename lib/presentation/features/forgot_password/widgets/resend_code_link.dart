import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/features/forgot_password/bloc/actions/forgot_password_actions_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResendCodeLink extends StatelessWidget {
  const ResendCodeLink(this.email, {Key? key}) : super(key: key);

  final EmailAddress email;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: t.auth.resetPassword.noCode,
            style: context.theme.textTheme.bodyMedium,
            children: <TextSpan>[
              TextSpan(
                text: t.auth.resetPassword.resendCode,
                style: context.theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () =>
                      context.read<ForgotPasswordActionsCubit>().resendVerificationCode(email),
              ),
            ],
          ),
        )
      ],
    );
  }
}
