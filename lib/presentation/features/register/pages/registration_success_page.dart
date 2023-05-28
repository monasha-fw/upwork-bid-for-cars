import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/presentation/common/widgets/sizes/index.dart';
import 'package:bid_for_cars/presentation/common/widgets/ui_blocks/auth/return_to_login_link.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RegistrationSuccessPage extends StatelessWidget {
  const RegistrationSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        /// unfocus when tapped outside
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t.auth.emailVerifySent.title,
                        style: context.theme.textTheme.headlineMedium,
                      ),
                      const HSB(10),
                      Text(
                        t.auth.emailVerifySent.subtitle,
                        style: context.theme.textTheme.titleLarge?.copyWith(
                          color: AppColors.kTextSub,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                      const HSB(40),
                      const ReturnToLoginLink(),
                      const HSB(30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
