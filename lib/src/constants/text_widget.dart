import 'package:calender_range_picker/src/constants/ui_helpers.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    Key? key,
    this.color,
    this.weight,
    this.overflow,
    this.height,
    this.style,
    this.fontSize,
    this.decoration,
    this.textAlign,
    this.letterSpacing,
    this.maxLines,
    this.softWrap,
  }) : super(key: key);
  final Color? color;
  final bool? softWrap;
  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? weight;
  final double? letterSpacing;
  final int? maxLines;
  final double? height;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style == null
          ? kDefaultTextStyle.copyWith(
              color: color,
              fontSize: fontSize ?? 14,
              fontWeight: weight,
              height: height,
              decoration: decoration,
              letterSpacing: letterSpacing,
            )
          : style!.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: weight,
              height: height,
              decoration: decoration,
              letterSpacing: letterSpacing,
            ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }
}
