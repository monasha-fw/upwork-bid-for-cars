import 'package:bid_for_cars/presentation/common/widgets/sizes/index.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

enum SnackbarType { error, success, info }

extension ShowSnack on ScaffoldMessengerState {
  /// clear all previous snackbars
  void clearSnacks() => _LBSnackbar.clearSnackbars(this);

  /// display a snackbar
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnack(
    String message,
    SnackbarType snackType, {
    Duration? duration,
  }) {
    /// clear previous, if any
    clearSnackBars();

    return showSnackBar(_LBSnackbar.getSnackbar(this, message, snackType, duration));
  }
}

class _LBSnackbar {
  static void clearSnackbars(ScaffoldMessengerState state) => state.clearSnackBars();

  static SnackBar getSnackbar(
    ScaffoldMessengerState state,
    String message,
    SnackbarType snackType,
    Duration? duration,
  ) {
    late SnackBar snack;
    switch (snackType) {
      case SnackbarType.error:
        snack = generateSnack(
          state,
          state.context,
          message,
          state.context.theme.colorScheme.error,
          duration: duration ?? const Duration(seconds: 30),
        );
        break;

      case SnackbarType.success:
        snack = generateSnack(
          state,
          state.context,
          message,
          AppColors.kSuccess,
          duration: duration ?? const Duration(seconds: 10),
        );
        break;

      /// Information
      case SnackbarType.info:
        snack = generateSnack(
          state,
          state.context,
          message,
          AppColors.kInfo,
          duration: duration ?? const Duration(seconds: 30),
        );
        break;

      default:
        snack = generateSnack(
          state,
          state.context,
          message,
          AppColors.kInfo,
          duration: duration ?? const Duration(seconds: 20),
        );
    }
    return snack;
  }

  static SnackBar generateSnack(ScaffoldMessengerState scaffoldState, BuildContext context,
      String message, Color backgroundColor,
      {IconData? icon, Duration? duration, String? action, VoidCallback? onAction}) {
    return SnackBar(
      // action: SnackBarAction(
      //   textColor: AppColors.kTextWhite,
      //   disabledTextColor: AppColors.kDisabled,
      //   label: action ?? t.common.dismiss,
      //   onPressed: onAction ?? () => scaffoldState.clearSnackBars(),
      // ),
      backgroundColor: backgroundColor,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Icon(icon ?? Icons.error, color: context.theme.colorScheme.onPrimary),
            const WSB(10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontSize: 16, color: context.theme.colorScheme.onPrimary),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
      duration: duration ?? const Duration(seconds: 30),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
