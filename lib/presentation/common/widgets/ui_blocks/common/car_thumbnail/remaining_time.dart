import 'dart:async';

import 'package:bid_for_cars/core/entities/car_thumbnail.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/features/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemainingTime extends StatefulWidget {
  const RemainingTime(this.car, {Key? key, required this.isLive}) : super(key: key);

  final CarThumbnail car;
  final bool isLive;

  @override
  State<RemainingTime> createState() => _RemainingTimeState();
}

class _RemainingTimeState extends State<RemainingTime> {
  late Timer countdownTimer;
  late Duration remaining;
  late bool expired;
  late bool moreThanADayRemaining;

  @override
  void initState() {
    expired = !widget.isLive;

    final remainingMills =
        widget.car.expiresIn.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;

    /// if the timer has more than 1 day, don't run the timer
    moreThanADayRemaining = remainingMills > Duration.millisecondsPerDay;
    remaining = Duration(
      milliseconds: moreThanADayRemaining ? 0 : remainingMills,
    );
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());

    super.initState();
  }

  @override
  void dispose() {
    if (countdownTimer.isActive) countdownTimer.cancel();
    super.dispose();
  }

  void stopTimer() => setState(() => countdownTimer.cancel());

  void setCountDown() {
    const reduceSecondsBy = 1;
    if (mounted && !expired) {
      setState(() {
        final seconds = remaining.inSeconds - reduceSecondsBy;
        if (seconds <= 0) {
          countdownTimer.cancel();

          /// if [moreThanADayRemaining] flag is true
          if (!moreThanADayRemaining) {
            expired = true;

            /// update as expired in the state management
            context.read<HomeCubit>().updateAsExpired(widget.car.id);
          }
        } else {
          remaining = Duration(seconds: seconds);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    late String timeRemainStr;
    if (moreThanADayRemaining) {
      final remainingMills =
          widget.car.expiresIn.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;

      timeRemainStr = t.home.carCard.expiresInDays(
        n: Duration(days: remainingMills ~/ Duration.millisecondsPerDay).inDays,
      );
    } else {
      String strDigits(int n) => n.toString().padLeft(2, '0');
      final hours = strDigits(remaining.inHours.remainder(24));
      final minutes = strDigits(remaining.inMinutes.remainder(60));
      final seconds = strDigits(remaining.inSeconds.remainder(60));
      timeRemainStr = '$hours:$minutes:$seconds';
    }

    return Text(
      timeRemainStr,
      style: TextStyle(
        color: widget.isLive && !expired ? context.theme.colorScheme.error : Colors.transparent,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
