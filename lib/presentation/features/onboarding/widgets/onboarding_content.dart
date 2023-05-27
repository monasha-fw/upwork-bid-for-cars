import 'package:bid_for_cars/presentation/features/onboarding/pages/onboarding_page.dart';
import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent(this.data, {Key? key, required this.currentPage}) : super(key: key);

  final OnboardingData data;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              // const HSB(20),
              // SizedBox(
              //   width: context.w * .90,
              //   child: Row(
              //     mainAxisAlignment:
              //         data.onBack != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
              //     children: [
              //       if (data.onBack != null)
              //         InkWell(
              //           onTap: data.onBack,
              //           child: SizedBox(
              //             width: context.w * 0.1,
              //             height: context.w * 0.1,
              //             child: const Icon(
              //               Icons.keyboard_backspace_rounded,
              //               color: AppColors.kIcon,
              //             ),
              //           ),
              //         ),
              //       SizedBox(
              //         width: 100,
              //         child: ElevatedButton(
              //           onPressed: data.onSkip,
              //           style: ElevatedButton.styleFrom(
              //             minimumSize: const Size(double.infinity, 50),
              //             backgroundColor: context.theme.colorScheme.primaryContainer,
              //             foregroundColor: context.theme.colorScheme.onPrimaryContainer,
              //             textStyle: const TextStyle(fontSize: 18),
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              //           ),
              //           child: Text(t.ui.onboarding.actions.skip),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   width: context.w * .85,
              //   child: AppImage(
              //     path: data.illustration,
              //     label: data.illustration,
              //     width: double.infinity,
              //     height: context.h * .4,
              //   ),
              // ),
              // DotsIndicator(
              //   dotsCount: 3,
              //   position: currentPage,
              //   decorator: DotsDecorator(
              //     size: const Size.square(9.0),
              //     activeSize: const Size(18.0, 9.0),
              //     activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              //   ),
              // ),
              // SizedBox(
              //   width: context.w * .85,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         data.title,
              //         style: context.theme.textTheme.headlineMedium,
              //       ),
              //       const HSB(10),
              //       Text(
              //         data.description,
              //         style: context.theme.textTheme.titleLarge?.copyWith(
              //           color: AppColors.kTextSub,
              //           fontWeight: FontWeight.w400,
              //           height: 1.4,
              //         ),
              //       ),
              //       const HSB(30),
              //       data.action,
              //       const HSB(40),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
