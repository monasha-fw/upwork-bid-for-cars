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
  colorScheme: const ColorScheme.dark(
    /* primary */
    primary: _AppColors.kPrimary,
    onPrimary: _AppColors.kOnPrimary,
    primaryContainer: _AppColors.kPrimaryContainer,

    /* secondary */
    secondary: _AppColors.kSecondary,
    onSecondary: _AppColors.kOnSecondary,
    secondaryContainer: _AppColors.kSecondaryContainer,

    /* tertiary */
    tertiary: _AppColors.kTertiary,
    onTertiary: _AppColors.kOnTertiary,

    /* background colors */
    background: _AppColors.kBg,

    /* statuses */
    error: _AppColors.kError,
  ),

  /* status colors */
  disabledColor: _AppColors.kDisabled,
  textTheme: const TextTheme(
    // headlineMedium: TextStyle(color: _AppColors.kHeaderText, fontWeight: FontWeight.bold), // fontSize: 28
    // titleLarge: TextStyle(fontSize: 26, color: _AppColors.kHeaderText, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: _AppColors.kText, fontSize: 18),
    bodyLarge: TextStyle(color: _AppColors.kText, fontSize: 20),

    labelLarge: TextStyle(color: _AppColors.kText, fontSize: 16),
    labelMedium: TextStyle(color: _AppColors.kText, fontSize: 14),

    bodyMedium: TextStyle(color: _AppColors.kText, fontSize: 16, height: 1.5),
    bodySmall: TextStyle(color: _AppColors.kText, fontSize: 14),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(10),
    isDense: true,
    isCollapsed: true,
    labelStyle: const TextStyle(color: _AppColors.kTextDarkGray),
    hintStyle: const TextStyle(color: _AppColors.kTextDarkGray),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      minimumSize: const Size(double.infinity, 50),
      backgroundColor: _AppColors.kPrimary,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      minimumSize: const Size(double.infinity, 50),
      foregroundColor: _AppColors.kPrimary,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      side: const BorderSide(color: _AppColors.kPrimary, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
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
