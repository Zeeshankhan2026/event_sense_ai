import 'package:flutter/material.dart';

import '../utils/app_colors.dart';


class AppTextStyles {
  static TextStyle get xlNormal =>
      TextStyle(fontSize: 32, fontWeight: FontWeight.normal);

  static TextStyle get xlSuperBold =>
      TextStyle(fontSize: 32, fontWeight: FontWeight.w900);

  static TextStyle get heading1 =>
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static TextStyle get heading1Normal =>
      TextStyle(fontSize: 24, fontWeight: FontWeight.normal);

  static TextStyle get heading2 =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  static TextStyle get heading3 =>
      TextStyle(fontSize: 17, fontWeight: FontWeight.w700);

  static TextStyle get heading4 =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
  static TextStyle get bodyText =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.normal,color: AppColors.black);

  static TextStyle get bodyTextBold =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: AppColors.white);

  static TextStyle get caption => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.grey,

  );

  static TextStyle get captionDark => TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle get captionPrimary => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle get micro => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );

  static TextStyle get microDark => TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle get microPrimary => TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );

  static TextStyle get buttonText => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle get appBarTitle =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700);

  static TextStyle get inputText =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle get inputHint => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}