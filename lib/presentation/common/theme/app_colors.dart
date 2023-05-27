part of 'theme.dart';

/// Notes on Colors
///
/// [Primary] - base color
/// [OnPrimary] - is applied to content (icons, text, etc.) that sits on top of primary
/// [PrimaryContainer] - is applied to elements needing less emphasis than primary
/// [OnPrimaryContainer] - is applied to content (icons, text, etc.) that sits on top of primary container
///
/// [Neutral] roles are used for surfaces and backgrounds, as well as high emphasis text and icons.
/// https://m3.material.io/styles/color/the-color-system/color-roles

abstract class _AppColors {
  /* primary */
  static const kPrimary = Color.fromRGBO(85, 135, 162, 1); // #5587A2
  static const kOnPrimary = Color.fromRGBO(8, 66, 92, 1); // #08425C
  static const kPrimaryContainer = Color.fromRGBO(13, 2, 33, 1); // #0D0221

  /* secondary */
  static const kSecondary = Color.fromRGBO(243, 121, 48, 1);
  static const kOnSecondary = Color.fromRGBO(243, 121, 48, 1);
  static const kSecondaryContainer = Color.fromRGBO(243, 121, 48, 1);

  /* tertiary */
  static const kTertiary = Color.fromRGBO(50, 85, 100, 1);
  static const kOnTertiary = Color.fromRGBO(85, 135, 162, 1);

  static const kError = Color.fromRGBO(244, 124, 124, 1);
  static const kInfo = Color.fromRGBO(56, 193, 225, 1.0);
  static const kSuccess = Color.fromRGBO(86, 198, 170, 1);
  static const kDisabled = Colors.grey;

  /* background colors */
  static const kBg = Color.fromRGBO(13, 2, 33, 1); // #0D0221

  /* Text colors */
  static const kText = Color.fromRGBO(7, 54, 77, 1); // #07364D
  static const kTextDarkGray = Color.fromRGBO(121, 121, 121, 1); // #797979
}
