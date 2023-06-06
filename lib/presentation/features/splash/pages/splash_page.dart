import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/presentation/common/bloc/auth/auth_cubit.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        print("State $state");
        if (state is Authenticated) {
          context.router.replace(const HomeRoute());
        } else if (state is Unauthenticated) {
          context.router.replace(const OnboardingRoute());
        }
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: context.w * .8,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: LinearProgressIndicator(
                minHeight: 10,
                backgroundColor: context.theme.colorScheme.tertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
