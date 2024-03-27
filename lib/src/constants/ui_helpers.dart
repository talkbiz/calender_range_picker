import 'package:calender_range_picker/src/constants/app_colors.dart';
import 'package:flutter/material.dart';

const SizedBox sizedBox3 = SizedBox(height: 3);

const SizedBox sizedBox5 = SizedBox(height: 5);

const SizedBox sizedBox8 = SizedBox(height: 8);

const SizedBox sizedBox10 = SizedBox(height: 10);

const SizedBox sizedBox12 = SizedBox(height: 12);

const SizedBox sizedBox15 = SizedBox(height: 15);

const SizedBox sizedBox20 = SizedBox(height: 20);

const SizedBox sizedBox30 = SizedBox(height: 30);

const SizedBox sizedBox40 = SizedBox(height: 40);

const SizedBox sizedBoxHor5 = SizedBox(width: 5);

const SizedBox sizedBoxHor10 = SizedBox(width: 10);

const SizedBox sizedBoxHor15 = SizedBox(width: 15);

const SizedBox sizedBoxHor20 = SizedBox(width: 20);

const SizedBox sizedBoxHor30 = SizedBox(width: 30);

const SizedBox sizedBoxHor40 = SizedBox(width: 40);

const EdgeInsets paddingAll3 = EdgeInsets.all(3);

const EdgeInsets paddingAll4 = EdgeInsets.all(4);

const EdgeInsets paddingAll5 = EdgeInsets.all(5);

const EdgeInsets paddingAll8 = EdgeInsets.all(8);

const EdgeInsets paddingAll10 = EdgeInsets.all(10);

const EdgeInsets paddingAll12 = EdgeInsets.all(12);

const EdgeInsets paddingAll16 = EdgeInsets.all(16);

const EdgeInsets paddingAll20 = EdgeInsets.all(20);

const EdgeInsets paddingAll32 = EdgeInsets.all(32);

const EdgeInsets paddingVer5 = EdgeInsets.symmetric(vertical: 5);

const EdgeInsets paddingVer8 = EdgeInsets.symmetric(vertical: 8);

const EdgeInsets paddingVer12 = EdgeInsets.symmetric(vertical: 12);

const EdgeInsets paddingVer16 = EdgeInsets.symmetric(vertical: 16);

const EdgeInsets paddingHor4 = EdgeInsets.symmetric(horizontal: 4);

const EdgeInsets paddingHor5 = EdgeInsets.symmetric(horizontal: 5);

const EdgeInsets paddingHor8 = EdgeInsets.symmetric(horizontal: 8);

const EdgeInsets paddingHor12 = EdgeInsets.symmetric(horizontal: 12);

const EdgeInsets paddingHor16 = EdgeInsets.symmetric(horizontal: 16);

const EdgeInsets paddingHor18 = EdgeInsets.symmetric(horizontal: 18);

const EdgeInsets paddingStackBottom =
    EdgeInsets.only(bottom: 24, left: 12, right: 12, top: 10);

EdgeInsets paddingSymmetric(double hor, double ver) =>
    EdgeInsets.symmetric(horizontal: hor, vertical: ver);

RoundedRectangleBorder cardShape(double radius) =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));

var kDefaultTextStyle = const TextStyle(
  fontSize: 14.18,
  color: AppColors.text,
  fontFamily: "Inter",
  fontWeight: FontWeight.w400,
);
