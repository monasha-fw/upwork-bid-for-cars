import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/routes/router.gr.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GetStartedLink extends StatelessWidget {
  const GetStartedLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: t.auth.login.noAccount,
        style: context.theme.textTheme.bodyMedium,
        children: <TextSpan>[
          TextSpan(
            text: t.auth.login.getStarted,
            style: context.theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.router.push(const RegisterRoute()),
          ),
        ],
      ),
    );
  }
}
