import 'package:flutter/cupertino.dart';

extension WidgetModifier on Widget {
  Widget Padded([EdgeInsetsGeometry value = const EdgeInsets.all(16)]) {
    return Padding(
      padding: value,
      child: this,
    );
  }
  Widget MakeFlexible([int flex = 1]) {
    return Flexible(
      flex: flex,
      child: this,
    );
  }
  Widget MakeExpanded() {
    return Expanded(
      child: this,
    );
  }
}