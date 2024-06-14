import 'package:flutter/material.dart';

class FontStyleComponents{
  static const heading2 = TextStyle(fontFamily: 'Wulkan Display Black', fontSize: 24, color: ColorComponents.blackColor);

  static const bodyLarge = TextStyle(fontFamily: 'Wulkan Display Medium', fontSize: 16, color: ColorComponents.blackColor);
  static const interBodyLarge = TextStyle(fontFamily: 'Inter Bold', fontSize: 16, color: ColorComponents.blackColor);
  static const body = TextStyle(fontFamily: 'Inter Regular', fontSize: 14, color: ColorComponents.blackColor);
  static const bodyBold = TextStyle(fontFamily: 'Inter Bold', fontSize: 14, color: ColorComponents.blackColor);

  static const bodySmall = TextStyle(fontFamily: 'Inter Regular' ,fontSize: 12, color: ColorComponents.black20LightColor);
  static const bodySmallBold = TextStyle(fontFamily: 'Inter Bold', fontSize: 14, color: ColorComponents.primaryColor);

  static const String indianRupee = '\u{20B9}';
}

class ColorComponents{
  static const whiteColor = Color(0xffffffff);
  static const white10DarkColor = Color(0xffE6E6E6);
  static const white40DarkColor = Color(0xff999999);
  static const whiteForInputField = Color(0xffD3D0CC);
  static const primaryColor = Color(0xffF4F1ED);

  static const blackColor = Color(0xff1C1C1C);
  static const black20LightColor = Color(0xff404040);
  static const black40LightColor = Color(0xff707070);

  static const errorColor = Color(0xffCD4248);
  static const successColor = Color(0xff43A116);
}