import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgAssets {
  static final SvgData circleArrowLeft = SvgData(
      "packages/calender_range_picker/lib/assets/svgs/circle-arrow-left.svg");
  static final SvgData circleArrowRight = SvgData(
      "packages/calender_range_picker/lib/assets/svgs/circle-arrow-right.svg");
}

class SvgData {
  final String data;
  SvgData(this.data);
}

///Use SvgAsset.iconName to specify the svg icon
class SvgIcon extends StatelessWidget {
  final SvgData svgIcon;
  final Color? color;
  final double? size;
  final bool? noColor;

  const SvgIcon({
    Key? key,
    required this.svgIcon,
    this.color,
    this.noColor,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgIcon.data,
      theme: noColor == true
          ? null
          : SvgTheme(
              currentColor: color ?? Theme.of(context).primaryColor,
            ),
      height: size,
    );
  }
}
