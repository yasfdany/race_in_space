import 'dart:ui' show FontWeight;

import 'package:flutter/painting.dart' show TextStyle;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static double get xl => 24.sp;
  static double get large => 20.sp;
  static double get medium => 16.sp;
  static double get small => 14.sp;
  static double get xs => 12.sp;
  static double get x2s => 10.sp;
  static double get x3s => 8.sp;

  static FontWeight get regular => FontWeight.w400;
  static FontWeight get bold => FontWeight.w700;

  static TextStyle get lanaPixel => TextStyle(
        fontFamily: 'lana_pixel',
        height: 1,
      );

  static TextStyle get regularXL => lanaPixel.copyWith(
        fontSize: xl,
        fontWeight: regular,
      );

  static TextStyle get regularL => lanaPixel.copyWith(
        fontSize: large,
        fontWeight: regular,
      );

  static TextStyle get regularM => lanaPixel.copyWith(
        fontSize: medium,
        fontWeight: regular,
      );

  static TextStyle get regularS => lanaPixel.copyWith(
        fontSize: small,
        fontWeight: regular,
      );

  static TextStyle get regularXS => lanaPixel.copyWith(
        fontSize: xs,
        fontWeight: regular,
      );

  static TextStyle get boldXL => lanaPixel.copyWith(
        fontSize: xl,
        fontWeight: bold,
      );

  static TextStyle get boldL => lanaPixel.copyWith(
        fontSize: large,
        fontWeight: bold,
      );

  static TextStyle get boldM => lanaPixel.copyWith(
        fontSize: medium,
        fontWeight: bold,
      );

  static TextStyle get boldS => lanaPixel.copyWith(
        fontSize: small,
        fontWeight: bold,
      );

  static TextStyle get boldXS => lanaPixel.copyWith(
        fontSize: xs,
        fontWeight: bold,
      );

  static TextStyle get boldX3S => lanaPixel.copyWith(
        fontSize: x3s,
        fontWeight: bold,
      );
}
