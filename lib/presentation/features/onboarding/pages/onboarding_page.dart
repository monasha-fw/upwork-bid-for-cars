import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/presentation/common/routes/router.gr.dart';
import 'package:bid_for_cars/presentation/common/theme/theme.dart';
import 'package:bid_for_cars/presentation/common/widgets/images/app_image.dart';
import 'package:bid_for_cars/presentation/common/widgets/sizes/index.dart';
import 'package:bid_for_cars/presentation/constants/assets/images.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_page.freezed.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 1;
  final children = [
    OnboardingData(
      id: 1,
      title: t.ui.onboarding.page1.title,
      description: t.ui.onboarding.page1.desc,
      illustration: AssetSvg.illOnboarding1,
    ),
    OnboardingData(
      id: 2,
      title: t.ui.onboarding.page2.title,
      description: t.ui.onboarding.page2.desc,
      illustration: AssetSvg.illOnboarding2,
    ),
    OnboardingData(
      id: 3,
      title: t.ui.onboarding.page3.title,
      description: t.ui.onboarding.page3.desc,
      illustration: AssetSvg.illOnboarding3,
    ),
  ];

  void _nextPage() {
    if (_currentPage < children.length) setState(() => _currentPage++);
  }

  void _previousPage() {
    if (_currentPage != 1) setState(() => _currentPage--);
  }

  void _onBack() => _previousPage();

  Widget actionButton() {
    final isLast = _currentPage == children.length;
    return ElevatedButton(
      onPressed: isLast ? _toLogin : _nextPage,
      child: Text(isLast ? t.ui.onboarding.actions.startNow : t.ui.onboarding.actions.next),
    );
  }

  void _toLogin() => context.router.replace(const LoginRoute());

  @override
  Widget build(BuildContext context) {
    // return PageView(
    //   physics: const NeverScrollableScrollPhysics(),
    //   controller: _controller,
    //   children: children.map((data) => OnboardingContent(data, currentPage: currentPage)).toList(),
    // );
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (details.primaryVelocity != null) {
                    if (details.primaryVelocity! > 0) {
                      _previousPage();
                    } else if (details.primaryVelocity! < 0) {
                      _nextPage();
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// header action buttons
                      SizedBox(
                        width: context.w * .90,
                        child: Row(
                          mainAxisAlignment: _currentPage == 1
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            if (_currentPage != 1)
                              InkWell(
                                onTap: _onBack,
                                child: SizedBox(
                                  width: context.w * 0.1,
                                  height: context.w * 0.1,
                                  child: const Icon(
                                    Icons.keyboard_backspace_rounded,
                                    color: AppColors.kIcon,
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: _toLogin,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  backgroundColor: context.theme.colorScheme.primaryContainer,
                                  foregroundColor: context.theme.colorScheme.onPrimaryContainer,
                                  textStyle: const TextStyle(fontSize: 18),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                child: Text(t.ui.onboarding.actions.skip),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// illustration
                      Stack(
                        children: children
                            .map(
                              (data) => SizedBox(
                                width: context.w * .85,
                                height: context.h * .5,
                                child: AnimatedOpacity(
                                  opacity: data.id == _currentPage ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: AppImage(
                                    path: data.illustration,
                                    label: data.illustration,
                                    width: double.infinity,
                                    height: context.h * .4,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),

                      /// Page indicator
                      DotsIndicator(
                        dotsCount: children.length,
                        position: _currentPage - 1,
                        decorator: DotsDecorator(
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),

                      HSB(context.h * .05),

                      /// Title and description
                      Stack(
                        children: children
                            .map(
                              (data) => AnimatedOpacity(
                                opacity: data.id == _currentPage ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 300),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.title,
                                      style: context.theme.textTheme.headlineMedium,
                                    ),
                                    const HSB(10),
                                    Text(
                                      data.description,
                                      style: context.theme.textTheme.titleLarge?.copyWith(
                                        color: AppColors.kTextSub,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4,
                                      ),
                                    ),
                                    const HSB(30),
                                    actionButton(),
                                    const HSB(20),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@freezed
class OnboardingData with _$OnboardingData {
  const factory OnboardingData({
    required int id,
    required String title,
    required String description,
    required String illustration,
  }) = _OnboardingData;
}
