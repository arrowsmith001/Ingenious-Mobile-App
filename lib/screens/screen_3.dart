import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/classes.dart';
import '../resources/widgets.dart';

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
              child: Text('Screen 3')
          ),
        ),
      ),
    );
  }
}
