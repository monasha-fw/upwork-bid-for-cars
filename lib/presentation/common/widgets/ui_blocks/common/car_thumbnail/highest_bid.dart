import 'package:bid_for_cars/core/entities/car_thumbnail.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HighestBid extends StatelessWidget {
  const HighestBid(this.car, {Key? key}) : super(key: key);

  final CarThumbnail car;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "${NumberFormat.decimalPattern('en_us').format(car.highestBid)} ${car.currency}",
          style: TextStyle(
            color: context.theme.colorScheme.primary,
            // fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          t.home.carCard.highestBid,
          style: const TextStyle(color: AppColors.kTextSecondary, fontSize: 12),
        ),
      ],
    );
  }
}
