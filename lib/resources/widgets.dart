import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'classes.dart';


class MyRRect extends StatelessWidget{
  MyRRect(this.color);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 16,
        height: 6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color
        ),
      ),
    );
  }
}


class MyCupertinoTextField extends StatelessWidget {
  MyCupertinoTextField({@required this.controller, @required this.textEntryType, bool valid}){

    if(valid != null) this.valid = valid;

    switch(textEntryType){
      case TextEntryType.email:
        placeholderText = "Email/Username";
        iconData = Icons.perm_identity;
        break;
      case TextEntryType.password:
        placeholderText = "Password";
        iconData = Icons.lock_outline;
        obscureText = true;

        break;
      case TextEntryType.username:

        placeholderText = "Username";
        iconData = Icons.alternate_email;
        break;
    }

  }

  final TextEditingController controller;
  final TextEntryType textEntryType;

  bool valid = true;
  IconData iconData;
  String placeholderText;
  bool obscureText = false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoTextField(
      controller: controller,
      style: Screen2Styles.textFieldStyle(),
      padding: EdgeInsets.all(20),
      placeholderStyle: TextStyle(color: Color(0xff5f5f5f)),
      placeholder: placeholderText,
      obscureText: obscureText,
      cursorColor: AppColors.gradient_color_blue,
      decoration: BoxDecoration(
          border: Border.all(color: valid ? Colors.transparent : Color(
              0xffffa2a2), width: 1),
          color: AppColors.cupertino_textfield_background,
          borderRadius: BorderRadius.circular(5)),
      prefix: Padding(
        padding: const EdgeInsets.fromLTRB(12,0,0,0),
        child: Icon(iconData, color: Color(0xff9e9e9e),),
      ),
    );
  }
}





class DividerLine extends StatelessWidget {

  @override
  Widget build(BuildContext context){

    return Container(
      height: 2.5,
      width: 230,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.transparent,
            Colors.black,
            Colors.transparent,
          ])
      ),
    );

  }
}


class SocialMediaButton extends StatelessWidget {
  SocialMediaButton(this.imagePath, this.borderColor);
  final String imagePath;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      child:  Center(
        child: Container(width: 20, height: 20, child: Image.asset(imagePath)),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor)
      ),
    );
  }
}


class GradientIcon extends StatelessWidget {
  GradientIcon(
      this.icon,
      this.size,
      this.gradient,
      );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}


enum AnimationMode{scale, spin, jump, orbit}

class Screen3AtSymbol extends StatefulWidget {
  Screen3AtSymbol(this.animationValue, this.animationMode, {@required this.radius, @required this.thickness, @required this.iconSize});

  final double animationValue;
  final AnimationMode animationMode;

  final double radius;
  final double thickness;
  final double iconSize;

  @override
  _Screen3AtSymbolState createState() => _Screen3AtSymbolState();
}

class _Screen3AtSymbolState extends State<Screen3AtSymbol> {

  Interpolator overshootInterp = new OvershootInterpolator(T: 1);
  Interpolator anticipateOvershootInterp = new AnticipateOvershootInterpolator(T: 5);

  @override
  Widget build(BuildContext context) {

    // The "@" icon alone
    Widget icon = GradientIcon(Icons.alternate_email, widget.iconSize,
        LinearGradient(
            begin:Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gradient_color_pink,
              AppColors.gradient_color_purple,
              AppColors.gradient_color_blue,
            ],
            stops: [
              0.2,
              0.6,
              0.8
            ]
        ));

    switch(widget.animationMode){

      case AnimationMode.scale:
        // Scale animation
        icon = Transform.scale(
          scale: overshootInterp.getValue(widget.animationValue),
          child: icon,);
        break;
      case AnimationMode.spin:
        // Rotate animation
        icon = Transform.rotate(
          angle: -pi*2*anticipateOvershootInterp.getValue(widget.animationValue),
          child: icon,);
        break;
      case AnimationMode.jump:
        throw UnimplementedError();
        break;
      case AnimationMode.orbit:
        throw UnimplementedError();
        break;
    }

    // Containing circle
    return CircleAvatar(
      radius: widget.radius + widget.thickness/2,
      backgroundColor: Colors.black12,
      child: CircleAvatar(
        radius: widget.radius - widget.thickness/2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: icon,
      ),
    );
  }
}
