import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/presentation/common/routes/router.gr.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      context.router.replace(const OnboardingRoute());
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
