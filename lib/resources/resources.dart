import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors{
  static const Color color1 = Color(0xFF0B54FE);
  static const Color color2 = Color(0xFF8532DF);
  static const Color color3 = Color(0xFFFC0EC0);
}

class AppImages{
  static const String Screen1_image = 'assets/images/Screen1_crop.png';
}

class AppTextStyles{

  static TextStyle titleStyle(BuildContext context) => TextStyle(
    //fontSize: Theme.of(context).textTheme.headline3.fontSize,
    fontSize: 42,
    fontFamily: 'Limerick',
      letterSpacing: 2,
    foreground: Paint()
      ..shader = LinearGradient(
          colors: <Color>[
            AppColors.color1,
            AppColors.color2,
            AppColors.color3
          ]
      ).createShader(Rect.fromLTWH(0, 0, 300, 0)));

  static TextStyle subtitleStyle(BuildContext context) => TextStyle(
    //fontSize: Theme.of(context).textTheme.headline5.fontSize,
    fontSize: 25,
    fontFamily: 'Limerick',
    letterSpacing: 1.1,
    height: 1.12,
    foreground: Paint()
      ..shader = LinearGradient(
          colors: <Color>[
            AppColors.color1,
            AppColors.color2,
            AppColors.color3
          ]
      ).createShader(Rect.fromLTWH(0, 0, 300, 0)),);



}