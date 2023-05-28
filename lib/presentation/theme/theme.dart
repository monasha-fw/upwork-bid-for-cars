import 'package:flutter/material.dart';

part 'app_colors.dart';

/// AppTheme Colors
///
/// [Primary] - base color
/// [OnPrimary] - is applied to content (icons, text, etc.) that sits on top of primary
/// [PrimaryContainer] - is applied to elements needing less emphasis than primary
/// [OnPrimaryContainer] - is applied to content (icons, text, etc.) that sits on top of primary container
///
/// [Neutral] roles are used for surfaces and backgrounds, as well as high emphasis text and icons.
/// https://m3.material.io/styles/color/the-color-system/color-roles

abstract class AppTheme {
  static ThemeData get light {
    return _lightThemeData;
  }

  static ThemeData get dark {
    return _darkThemeData;
  }
}

/// Light theme
final _lightThemeData = ThemeData.light().copyWith(
  colorScheme: const ColorScheme.light(
    /* primary */
    primary: AppColors.kPrimary,
    onPrimary: AppColors.kOnPrimary,
    primaryContainer: AppColors.kPrimaryContainer,
    onPrimaryContainer: AppColors.kOnPrimaryContainer,

    /* primary */
    secondary: AppColors.kSecondary,
    onSecondary: AppColors.kOnSecondary,

    /* tertiary */
    tertiary: AppColors.kTertiary,
    onTertiary: AppColors.kOnTertiary,

    /* background colors */
    background: AppColors.kBg,

    /* statuses */
    error: AppColors.kError,
  ),
  /* Widget colors */
  scaffoldBackgroundColor: AppColors.kBg,

  /* status colors */
  disabledColor: AppColors.kDisabled,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(color: AppColors.kText, fontWeight: FontWeight.bold, fontSize: 28),
    headlineSmall: TextStyle(color: AppColors.kText, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(color: AppColors.kText, fontSize: 18),
    titleMedium: TextStyle(color: AppColors.kText),
    bodyLarge: TextStyle(color: AppColors.kText),
    labelLarge: TextStyle(color: AppColors.kText),
    labelMedium: TextStyle(color: AppColors.kText),
    bodyMedium: TextStyle(color: AppColors.kText),
    bodySmall: TextStyle(color: AppColors.kText),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.all(AppColors.kIcon),
    ),
  ),
  iconTheme: const IconThemeData(color: AppColors.kIcon),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(color: AppColors.kTextHint),
    hintStyle: const TextStyle(color: AppColors.kTextHint),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.kBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.kBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.kDisabled),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.kBorderFocused),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.kError),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.kError),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      minimumSize: const Size(double.infinity, 50),
      backgroundColor: AppColors.kPrimary,
      textStyle: const TextStyle(
        color: AppColors.kOnPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      minimumSize: const Size(double.infinity, 50),
      foregroundColor: AppColors.kPrimary,
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      side: const BorderSide(color: AppColors.kPrimary, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    horizontalTitleGap: 0,
    dense: true,
    contentPadding: EdgeInsets.zero,
  ),
);

/// TODO Dark theme
final _darkThemeData = ThemeData.dark();
