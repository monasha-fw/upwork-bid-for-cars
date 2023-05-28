import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';

class ReturnToLoginLink extends StatelessWidget {
  const ReturnToLoginLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.router.popUntilRouteWithName(LoginRoute.name),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.chevron_left),
          Text(
            t.auth.common.returnToLogin,
            style: context.theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
