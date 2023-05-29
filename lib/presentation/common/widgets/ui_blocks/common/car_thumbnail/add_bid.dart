import 'package:bid_for_cars/core/entities/car_thumbnail.dart';
import 'package:bid_for_cars/core/enums/car.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:flutter/material.dart';

class AddBid extends StatelessWidget {
  const AddBid(this.car, {Key? key}) : super(key: key);

  final CarThumbnail car;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Text(
        car.status == CarStatusEnum.live
            ? t.home.carCard.actions.addBid
            : t.home.carCard.actions.addOffer,
        style: TextStyle(color: context.theme.colorScheme.onPrimary),
      ),
    );
  }
}
