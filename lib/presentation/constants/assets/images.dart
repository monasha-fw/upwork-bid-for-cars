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
}
