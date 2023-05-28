import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';

class ForgotPassLink extends StatelessWidget {
  const ForgotPassLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => context.router.push(const ForgotPasswordRoute()),
          child: Text(
            t.auth.login.forgotPass,
            style: const TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
