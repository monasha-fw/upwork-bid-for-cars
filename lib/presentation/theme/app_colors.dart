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

abstract class AppColors {
  /* primary */
  static const kPrimary = Color.fromRGBO(97, 167, 212, 1); // #61A7D4
  static const kOnPrimary = Color.fromRGBO(255, 255, 255, 1); // #FFFFFF
  static const kPrimaryContainer = Color.fromRGBO(244, 246, 248, 1); // #F4F6F8
  static const kOnPrimaryContainer = Color.fromRGBO(99, 115, 129, 1); // #637381

  static const kSecondary = Color.fromRGBO(18, 123, 191, 1); // #127BBF
  static const kOnSecondary = Color.fromRGBO(255, 255, 255, 1); // #FFFFFF

  static const kTertiary = Color.fromRGBO(196, 205, 213, 1); // #C4CDD5
  static const kOnTertiary = Color.fromRGBO(97, 167, 212, 1); // #61A7D4

  static const kError = Color.fromRGBO(244, 124, 124, 1);
  static const kInfo = Color.fromRGBO(56, 193, 225, 1);
  static const kSuccess = Color.fromRGBO(86, 198, 170, 1);
  static const kDisabled = Colors.grey;

  /* background colors */
  static const kBg = Color.fromRGBO(249, 250, 251, 1); // #F9FAFB
  static const kBgInactive = Color.fromRGBO(196, 205, 213, 1); // #C4CDD5

  /* border colors */
  static const kBorder = Color.fromRGBO(196, 205, 213, 1); // #C4CDD5
  static const kBorderFocused = Color.fromRGBO(190, 199, 208, 1); // #C4CDD5

  /* Text colors */
  static const kText = Color.fromRGBO(29, 28, 28, 1); // #1D1C1C
  static const kTextPrimary = Color.fromRGBO(18, 123, 191, 1); // #127BBF
  static const kTextSecondary = Color.fromRGBO(145, 158, 171, 1); // #919EAB
  static const kTextSuccess = Color.fromRGBO(31, 214, 60, 1); // #1FD63C
  static const kTextSub = Color.fromRGBO(99, 115, 129, 1); // #637381
  static const kTextHint = Color.fromRGBO(196, 205, 213, 1); // #C4CDD5

/* Icon colors */
  static const kIcon = Color.fromRGBO(80, 84, 93, 1); // #50545D
  static const kIconPrimary = Color.fromRGBO(97, 167, 212, 1); // #61A7D4
  static const kFieldIcon = Color.fromRGBO(196, 205, 213, 1); // #C4CDD5

/* Shadow */
  static const kShadow = Color.fromRGBO(33, 43, 54, 0.1);
}
