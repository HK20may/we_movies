import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wework_movies_app/core/app_constants/app_assets.dart';

class WeWorkLogo extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final double? textWidth;
  const WeWorkLogo(
      {super.key,
      required this.bgColor,
      required this.textColor,
      this.textWidth});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2),
          child: SvgPicture.asset(
            AppAssets.weWorkLogo,
            color: textColor,
            width: textWidth ?? 32,
          ),
        ),
      ],
    );
  }
}
