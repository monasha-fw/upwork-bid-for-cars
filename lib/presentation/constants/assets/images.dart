abstract class AppAsset {
  static const String imagesBasePath = 'assets/images';
  static const String svgBasePath = 'assets/svgs';
}

abstract class AssetImage {}

abstract class AssetSvg {
  /// illustrations
  static String illOnboarding1 = '${AppAsset.svgBasePath}/illustrations/onboarding_1.svg';
  static String illOnboarding2 = '${AppAsset.svgBasePath}/illustrations/onboarding_2.svg';
  static String illOnboarding3 = '${AppAsset.svgBasePath}/illustrations/onboarding_3.svg';

  /// icons
  static String iconHomeNavBids = '${AppAsset.svgBasePath}/icons/home/navi_bar/bids.svg';
  static String iconHomeNavCar = '${AppAsset.svgBasePath}/icons/home/navi_bar/car.svg';
  static String iconHomeNavAccount = '${AppAsset.svgBasePath}/icons/home/navi_bar/account.svg';
  // Car Card
  static String iconHomeCarCardRoad = '${AppAsset.svgBasePath}/icons/home/car_card/road.svg';
  static String iconHomeCarCardUserId = '${AppAsset.svgBasePath}/icons/home/car_card/user_id.svg';
  static String iconHomeCarCardEngine = '${AppAsset.svgBasePath}/icons/home/car_card/engine.svg';
}
