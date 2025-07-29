import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, 
    String fontfamily, FontStyle fontStyle, Color? color, {TextDecoration? decoration, double? height}) {
  return TextStyle(
      fontSize: fontSize,
      color: color, // اللون يتم تعيينه فقط إذا تم تمريره
      fontWeight: fontWeight,
      fontFamily: fontfamily,
      fontStyle: fontStyle,
      decoration: decoration,
      height: height);
}

TextStyle getRegularStyle(
    {double fontSize = FontSize.size12,
    Color? color, // اللون كمعامل اختياري
    required String fontFamily,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? height}) {
  return _getTextStyle(fontSize, FontWeightManger.regular, fontFamily,
      fontStyle ?? FontStyle.normal, color, decoration: decoration, height: height);
}

// Medium style
TextStyle getMediumStyle(
    {double fontSize = FontSize.size12,
    Color? color, // اللون كمعامل اختياري
    required String fontFamily,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? height}) {
  return _getTextStyle(fontSize, FontWeightManger.medium, fontFamily,
      fontStyle ?? FontStyle.normal, color, decoration: decoration, height: height);
}

// Light style
TextStyle getLightStyle(
    {double fontSize = FontSize.size12,
    Color? color, // اللون كمعامل اختياري
    required String fontFamily,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? height}) {
  return _getTextStyle(fontSize, FontWeightManger.light, fontFamily,
      fontStyle ?? FontStyle.normal, color, decoration: decoration, height: height);
}

// Bold style
TextStyle getBoldStyle(
    {double fontSize = FontSize.size12,
    Color? color, // اللون كمعامل اختياري
    required String fontFamily,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? height}) {
  return _getTextStyle(fontSize, FontWeightManger.bold, fontFamily,
      fontStyle ?? FontStyle.normal, color, decoration: decoration, height: height);
}

// SemiBold style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.size12,
    Color? color, // اللون كمعامل اختياري
    required String fontFamily,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? height}) {
  return _getTextStyle(fontSize, FontWeightManger.semiBold, fontFamily,
      fontStyle ?? FontStyle.normal, color, decoration: decoration, height: height);
}
