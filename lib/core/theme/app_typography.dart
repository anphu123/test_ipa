import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTypography {
static TextStyle get s7 => TextStyle(
    fontSize: 7.sp,
    height: 10.h / 7.h,
  );
  static TextStyle get s8 => TextStyle(
    fontSize: 8.sp,
    height: 12.h / 8.h,
  );
  static TextStyle get s9 => TextStyle(
    fontSize: 9.sp,
    height: 14.h / 9.h,
  );
  static TextStyle get s10 => TextStyle(
    fontSize: 10.sp,
    height: 16.h / 10.h,
  );
  static TextStyle get s32 => TextStyle(
    fontSize: 32.sp,
    height: 40.h / 32.h,
  );

  static TextStyle get s30 => TextStyle(
    fontSize: 30.sp,
    height: 38.h / 30.h,
  );

  static TextStyle get s28 => TextStyle(
    fontSize: 28.sp,
    height: 36.h / 28.h,
  );

  static TextStyle get s26 => TextStyle(
    fontSize: 26.sp,
    height: 34.h / 26.h,
  );

  static TextStyle get s24 => TextStyle(
    fontSize: 24.sp,
    height: 32.h / 24.h,
  );

  static TextStyle get s22 => TextStyle(
    fontSize: 22.sp,
    height: 28.h / 22.h,
  );

  static TextStyle get s20 => TextStyle(
    fontSize: 20.sp,
    height: 28.h / 20.h,
  );

  static TextStyle get s18 => TextStyle(
    fontSize: 18.sp,
    height: 28.h / 18.h,
  );

  static TextStyle get s17 => TextStyle(
    fontSize: 17.sp,
    height: 24.h / 17.h,
  );

  static TextStyle get s16 => TextStyle(
    fontSize: 16.sp,
    height: 24.h / 16.h,
  );

  static TextStyle get s15 => TextStyle(
    fontSize: 15.sp,
    height: 22.h / 15.h,
  );

  static TextStyle get s14 => TextStyle(
    fontSize: 14.sp,
    height: 20.h / 14.h,
  );

  static TextStyle get s13 => TextStyle(
    fontSize: 13.sp,
    height: 18.h / 13.h,
  );

  static TextStyle get s12 => TextStyle(
    fontSize: 12.sp,
    height: 16.h / 12.h,
  );
  static TextStyle get s11 => TextStyle(
    fontSize: 11.sp,
    height: 16.h / 11.h,
  );
  static TextStyle get s43 => TextStyle(
    fontSize: 43.sp,
    height: 50.h / 43.h,
  );
}

extension TextStyleX on TextStyle {
  TextStyle get thin => withFontWeight(FontWeight.w100);
  TextStyle get extraLight => withFontWeight(FontWeight.w200);
  TextStyle get light => withFontWeight(FontWeight.w300);
  TextStyle get regular => withFontWeight(FontWeight.w400);
  TextStyle get medium => withFontWeight(FontWeight.w500);
  TextStyle get semibold => withFontWeight(FontWeight.w600);
  TextStyle get bold => withFontWeight(FontWeight.w700);
  TextStyle get extraBold => withFontWeight(FontWeight.w800);
  TextStyle get black => withFontWeight(FontWeight.w900);

  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle withFontWeight(FontWeight fontWeight) => copyWith(fontWeight: fontWeight);
}
