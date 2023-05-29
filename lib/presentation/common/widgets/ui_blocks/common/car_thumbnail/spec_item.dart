import 'package:bid_for_cars/presentation/common/widgets/images/app_image.dart';
import 'package:bid_for_cars/presentation/common/widgets/sizes/index.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

class SpecItem extends StatelessWidget {
  const SpecItem({Key? key, required this.imagePath, required this.label}) : super(key: key);

  final String imagePath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImage(
          path: imagePath,
          label: imagePath,
          height: 10,
          width: 10,
          color: context.theme.colorScheme.primary,
        ),
        const WSB(2),
        Text(
          label,
          style: const TextStyle(color: AppColors.kTextSecondary, fontSize: 12),
        ),
      ],
    );
  }
}
