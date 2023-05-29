import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(page: SplashRoute.page, maintainState: false),
        CustomRoute(page: OnboardingRoute.page),
        CustomRoute(page: LoginRoute.page),
        CustomRoute(page: RequestResetPasswordRoute.page),
        CustomRoute(page: ResetPasswordRoute.page),
        CustomRoute(page: RegisterRoute.page),
        CustomRoute(page: RegistrationSuccessRoute.page),
        CustomRoute(page: HomeRoute.page, initial: true),
      ];
}
