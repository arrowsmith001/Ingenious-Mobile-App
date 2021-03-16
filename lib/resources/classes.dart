import 'dart:ui';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// These methods are open to modification if more specific validation is required
class Validators{

  static String EmailValidation<T>(T value){
    if(value.toString() == "") return "This field must not be empty";
    return null;
  }

  static String PasswordValidation<T>(T value){
    if(value.toString() == "") return "This field must not be empty";
    return null;
  }

  // Open to modification if more specific validation is required
  static String UsernameValidation<T>(T value){
    if(value.toString() == "") return "This field must not be empty";
    return null;
  }
}


// Singleton class for managing user credentials
class UserCredentialsManager {
  String _email;
  String _password;
  String _username;

  static UserCredentialsManager _instance;
  static getInstance(){
    if(_instance == null){
      _instance = UserCredentialsManager._internal();
    }
    return _instance;
  }

  UserCredentialsManager._internal();

  void setEmailAndPassword(String email, String password) {
    this._email = email;
    this._password = password;
  }

  void setUsername(String username) {
    this._username = username;
  }

  String getString(){
    String out = 'USER CREDENTIALS:\n';
    out += '\t' + 'Email: ' + (this._email ?? "<unknown>") + '\n';
    out += '\t' + 'Password: ' + (this._password ?? "<unknown>") + '\n';
    out += '\t' + 'Username: ' + (this._username ?? "<unknown>");
    return out;
  }
}

enum TextEntryType{
  email, password, username
}

class AppColors{
  static const Color gradient_color_blue = Color(0xFF0B54FE);
  static const Color gradient_color_purple = Color(0xFF8532DF);
  static const Color gradient_color_pink = Color(0xFFFC0EC0);

  static const Color cupertino_textfield_background = Color(0xffeeeeee);
}

class AppImages{
  static const String Screen1_image = 'assets/images/Screen1_crop.png';
  static const String apple_icon = 'assets/images/apple_icon.png';
  static const String google_icon = 'assets/images/google_icon.png';
  static const String facebook_icon = 'assets/images/facebook_icon.png';
}

class Screen1Styles{

  static TextStyle titleStyleAnimated(double t) => TextStyle(
    fontSize: 42,
    fontFamily: 'Limerick',
      letterSpacing: 2,
    foreground: Paint()
      ..shader = LinearGradient(
          colors: <Color>[
            AppColors.gradient_color_blue,
            AppColors.gradient_color_purple,
            AppColors.gradient_color_pink,
            AppColors.gradient_color_blue,
            AppColors.gradient_color_purple,
            AppColors.gradient_color_pink
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
            AppColors.gradient_color_blue,
            AppColors.gradient_color_purple,
            AppColors.gradient_color_pink
          ]
      ).createShader(Rect.fromLTWH(0, 0, 300, 0)),);

}

class Screen2Styles {
  static TextStyle titleStyle() => TextStyle(
      fontSize: 36,
      color: AppColors.gradient_color_purple,
      fontWeight: FontWeight.w600
  );

  static TextStyle textFieldStyle() => TextStyle(color: Colors.black, decoration: TextDecoration.none);
}

class Screen3Styles {
  static TextStyle titleStyle() => TextStyle(
      fontSize: 30,
      color: AppColors.gradient_color_purple,
      fontWeight: FontWeight.w500
  );

  static TextStyle textFieldStyle() => TextStyle(color: Colors.black, decoration: TextDecoration.none);
}

abstract class Interpolator{
  double getValue(double t);
}

class OvershootInterpolator extends Interpolator{
  OvershootInterpolator({this.T});
  double T = 1;

  @override
  double getValue(double t) {
    return (T+1) * pow(t-1,3) + T * pow(t-1,2) + 1;
  }
}

class AnticipateInterpolator extends Interpolator{
  AnticipateInterpolator({this.T});
  double T = 1;

  @override
  double getValue(double t) {
    return (T+1) * pow(t,3) - T * pow(t,2);
  }
}
class AnticipateOvershootInterpolator extends Interpolator{
  AnticipateOvershootInterpolator({this.T});
  double T = 1;

  @override
  double getValue(double t) {
    if(t<0.5) return 0.5*((T+1)*pow(2*t,3)-T*(pow(2*t,2)));
    return 0.5*((T+1)*pow(2*t-2,3)+T*(pow(2*t-2,2))) + 1;
  }
}

