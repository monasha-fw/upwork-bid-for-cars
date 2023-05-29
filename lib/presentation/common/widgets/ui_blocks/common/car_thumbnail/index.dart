import 'package:bid_for_cars/core/entities/car_thumbnail.dart';
import 'package:bid_for_cars/core/enums/car.dart';
import 'package:bid_for_cars/presentation/common/widgets/images/app_image.dart';
import 'package:bid_for_cars/presentation/common/widgets/sizes/index.dart';
import 'package:bid_for_cars/presentation/constants/assets/images.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:flutter/material.dart';

import 'add_bid.dart';
import 'highest_bid.dart';
import 'remaining_time.dart';
import 'spec_item.dart';
import 'status_tag.dart';

class CarThumbnailItem extends StatelessWidget {
  const CarThumbnailItem(this.car, {Key? key}) : super(key: key);

  final CarThumbnail car;

  @override
  Widget build(BuildContext context) {
    final isLive = car.status == CarStatusEnum.live;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AppImage(
                  path: car.image,
                  label: car.name,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 13,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          car.name,
                          maxLines: 2,
                          style: context.textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: RemainingTime(car, isLive: isLive),
                      ),
                    ],
                  ),
                  const HSB(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SpecItem(
                        imagePath: AssetSvg.iconHomeCarCardRoad,
                        label: car.mileage,
                      ),
                      SpecItem(
                        imagePath: AssetSvg.iconHomeCarCardUserId,
                        label: car.location,
                      ),
                      SpecItem(
                        imagePath: AssetSvg.iconHomeCarCardEngine,
                        label: car.engineCapacity,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      StatusTag(isLive),
                      AddBid(car),
                      HighestBid(car),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
