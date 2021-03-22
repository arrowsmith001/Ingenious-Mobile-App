import 'package:flutter/cupertino.dart';

// Some modifiers for Widgets just to tidy up the code
extension WidgetModifier on Widget {

  // Wraps widget in a Padding widget
  Widget Padded([EdgeInsetsGeometry value = const EdgeInsets.all(16)]) {
    return Padding(
      padding: value,
      child: this,
    );
  }

  // Wraps widget in an Align widget
  Widget Aligned([Alignment alignment = Alignment.center]) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  // Wraps widget in a Flexible widget
  Widget MakeFlexible([int flex = 1]) {
    return Flexible(
      flex: flex,
      child: this,
    );
  }
  // Wraps widget in an Expanded widget
  Widget MakeExpanded() {
    return Expanded(
      child: this,
    );
  }


}