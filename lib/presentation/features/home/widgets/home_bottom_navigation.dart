import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/presentation/common/widgets/images/app_image.dart';
import 'package:bid_for_cars/presentation/common/widgets/sizes/index.dart';
import 'package:bid_for_cars/presentation/constants/assets/images.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({Key? key, required this.activePage, required this.onTap})
      : super(key: key);

  final int activePage;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.kShadow,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () => onTap(0),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppImage(
                      path: AssetSvg.iconHomeNavBids,
                      label: t.home.navBar.bids,
                      width: context.w * .07,
                      height: context.w * .07,
                      color: activePage == 0 ? context.theme.colorScheme.primary : null,
                    ),
                    const HSB(6),
                    Text(
                      t.home.navBar.bids,
                      style: TextStyle(
                        color: activePage == 0
                            ? context.theme.colorScheme.primary
                            : AppColors.kTextHint,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () => onTap(1),
              child: CircleAvatar(
                backgroundColor: context.theme.colorScheme.primary,
                radius: context.h * .035,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: AppImage(
                    path: AssetSvg.iconHomeNavCar,
                    label: t.home.navBar.cars,
                    width: context.w * .08,
                    height: context.w * .08,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () => onTap(2),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppImage(
                      path: AssetSvg.iconHomeNavAccount,
                      label: t.home.navBar.account,
                      width: context.w * .07,
                      height: context.w * .07,
                      color: activePage == 2 ? context.theme.colorScheme.primary : null,
                    ),
                    const HSB(6),
                    Text(
                      t.home.navBar.bids,
                      style: TextStyle(
                        color: activePage == 2
                            ? context.theme.colorScheme.primary
                            : AppColors.kTextHint,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
