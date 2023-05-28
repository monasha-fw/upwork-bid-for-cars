import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccountLink extends StatelessWidget {
  const AlreadyHaveAccountLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: t.auth.register.alreadyHas,
            style: context.theme.textTheme.bodyMedium,
            children: <TextSpan>[
              TextSpan(
                text: t.auth.register.login,
                style: context.theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()..onTap = () => context.router.pop(),
              ),
            ],
          ),
        )
      ],
    );
    ;
  }
}
