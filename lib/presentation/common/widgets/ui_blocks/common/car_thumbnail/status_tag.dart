import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/presentation/common/widgets/sizes/index.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

class StatusTag extends StatelessWidget {
  const StatusTag(this.isLive, {Key? key}) : super(key: key);
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color: isLive ? AppColors.kSuccess : context.theme.colorScheme.error,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Row(
        children: [
          if (isLive) const CircleAvatar(radius: 4, backgroundColor: Colors.white),
          if (isLive) const WSB(4),
          Text(
            isLive ? t.home.carCard.status.live : t.home.carCard.status.expired,
            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
