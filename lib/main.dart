import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'resources/classes.dart';
import 'screens/screen_1.dart';
import 'screens/screen_2.dart';

  void main() {
      runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return CupertinoApp(
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
                fontFamily: 'NanumGothic')) ,
      ),
      home: Screen1()
    );
  }
}





