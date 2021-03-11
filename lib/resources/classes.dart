import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors{
  static const Color gradient_color_1 = Color(0xFF0B54FE);
  static const Color gradient_color_2 = Color(0xFF8532DF);
  static const Color gradient_color_3 = Color(0xFFFC0EC0);
}

class AppImages{
  static const String Screen1_image = 'assets/images/Screen1_crop.png';
}

class Screen1Styles{

  static TextStyle titleStyleAnimated(double t) => TextStyle(
    fontSize: 42,
    fontFamily: 'Limerick',
      letterSpacing: 2,
    foreground: Paint()
      ..shader = LinearGradient(
          colors: <Color>[
            AppColors.gradient_color_1,
            AppColors.gradient_color_2,
            AppColors.gradient_color_3,
            AppColors.gradient_color_1,
            AppColors.gradient_color_2,
            AppColors.gradient_color_3
          ],
        stops: [
          0,
          6*t > 4 ? 0.5 * ((t-(4/6)) / (2/6)) : 0,
          6*t > 2 ? (t-(2/6)) / (4/6) : 0,
          6*t < 4 ? (3/2)*t : 1,
          6*t < 2 ? 0.5 + 0.5*(3*t) : 1,
          1
        ]
      ).createShader(Rect.fromLTWH(0, 0, 300, 0)));

  static TextStyle subtitleStyle() => TextStyle(
    fontSize: 25,
    fontFamily: 'Limerick',
    letterSpacing: 1.1,
    height: 1.12,
    foreground: Paint()
      ..shader = LinearGradient(
          colors: <Color>[
            AppColors.gradient_color_1,
            AppColors.gradient_color_2,
            AppColors.gradient_color_3
          ]
      ).createShader(Rect.fromLTWH(0, 0, 300, 0)),);

}

class Screen2Styles {
  static TextStyle titleStyle() => TextStyle(
    fontFamily: 'Limerick',
      fontSize: 32,
      color: AppColors.gradient_color_2
  );

  static TextStyle textFieldStyle() => TextStyle(color: Colors.black, decoration: TextDecoration.none);
}

class EnterExitRoute extends PageRouteBuilder {

  final Widget enterPage;
  final Widget exitPage;

  EnterExitRoute({this.exitPage, this.enterPage})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(-1.0, 0.0),
                ).animate(animation),
                child: exitPage,
              ),
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: enterPage,
              )
            ],
          ),
        );
}