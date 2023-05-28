import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(page: SplashRoute.page, initial: true, maintainState: false),
        CustomRoute(page: OnboardingRoute.page),
        CustomRoute(page: LoginRoute.page),
        CustomRoute(page: RegisterRoute.page),
        CustomRoute(page: HomeRoute.page),
      ];
}
