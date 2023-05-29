import 'package:bid_for_cars/presentation/constants/assets/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    Key? key,
    required this.path,
    required this.label,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  final String path;
  final String label;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (path.contains(AppAsset.svgBasePath)) {
      return SvgPicture.asset(
        path,
        semanticsLabel: label,
        height: height,
        width: width,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      );
    } else if (path.contains(AppAsset.imagesBasePath)) {
      return Image.asset(path);
    } else if (path.contains("http://") || path.contains("https://")) {
      return Image.network(path);
    }
    // TODO - network image

    return Image.asset(path);
  }
}
