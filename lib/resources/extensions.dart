import 'package:flutter/cupertino.dart';

extension WidgetModifier on Widget {
  Widget Padded([EdgeInsetsGeometry value = const EdgeInsets.all(16)]) {
    return Padding(
      padding: value,
      child: this,
    );
  }
}