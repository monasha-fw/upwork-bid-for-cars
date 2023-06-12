import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/presentation/features/forgot_password/pages/request_reset_password_page.dart';
import 'package:bid_for_cars/presentation/features/home/pages/home_page.dart';
import 'package:bid_for_cars/presentation/features/login/pages/login_page.dart';
import 'package:bid_for_cars/presentation/features/onboarding/pages/onboarding_page.dart';
import 'package:bid_for_cars/presentation/features/register/pages/register_page.dart';
import 'package:bid_for_cars/presentation/features/splash/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(page: SplashRoute.page, initial: true, maintainState: false),
        CustomRoute(page: OnboardingRoute.page),
        CustomRoute(page: LoginRoute.page),
        CustomRoute(page: RequestResetPasswordRoute.page),
        CustomRoute(page: ResetPasswordRoute.page),
        CustomRoute(page: RegisterRoute.page),
        CustomRoute(page: RegistrationSuccessRoute.page),
        CustomRoute(page: HomeRoute.page),
      ];
}

/// GoRouter
enum Routes {
  splashPage("/"),
  onboardingPage("/onboarding"),
  loginPage("/login"),
  requestResetPasswordPage("/requestResetPassword"),
  registerPage("/register"),
  homePage("/home"),
  ;

  const Routes(this.path);

  final String path;
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.splashPage.path,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.onboardingPage.path,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: Routes.loginPage.path,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: Routes.requestResetPasswordPage.path,
      builder: (context, state) => const RequestResetPasswordPage(),
    ),
    GoRoute(
      path: Routes.registerPage.path,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: Routes.homePage.path,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
