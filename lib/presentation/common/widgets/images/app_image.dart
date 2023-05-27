import 'package:bid_for_cars/presentation/constants/assets/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    Key? key,
    required this.path,
    required this.label,
    required this.width,
    required this.height,
  }) : super(key: key);

  final String path;
  final String label;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (path.contains(AppAsset.svgBasePath)) {
      return SvgPicture.asset(path, semanticsLabel: label, height: height, width: width);
    } else if (path.contains(AppAsset.imagesBasePath)) {
      return Image.asset(path);
    }
    // TODO - network image

    return Image.asset(path);
  }
}
