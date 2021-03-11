import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/classes.dart';
import '../resources/widgets.dart';
import 'screen_2.dart';


class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> with SingleTickerProviderStateMixin {

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _controller.addListener(() {
      setState(() {

      });
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                // (1) Upper quarter
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Column(
                        children: [
                          Text('Hubwork', style: Screen1Styles.titleStyleAnimated(_controller.value), textAlign: TextAlign.center),
                          Text('Reconnecting People', style: TextStyle(fontSize: 17.5)),
                        ],
                      ),

                    ],),),

                // (2) Upper-middle quarter
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Flexible(
                          flex: 1,
                          child: Container()
                      ),

                      Flexible(
                          flex: 3,
                          child: Image.asset(AppImages.Screen1_image)),
                    ],),),

                // (3) Lower-middle quarter
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Flexible(
                            flex: 9,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),

                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Message freelancers\ndirectly or post a job that\nneeds doing',
                                        style: Screen1Styles.subtitleStyle(),
                                        textAlign: TextAlign.center)
                                  ]
                              ),

                            )),
                        Flexible(
                            flex: 4,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Find out more',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13))
                                ]
                            )
                        )

                      ],
                    )
                ),

                // (4) Lower quarter
                Expanded(
                  child: Column(
                    children: [

                      Expanded(child: Container()),

                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        MyRRect(Colors.black12),
                                        MyRRect(AppColors.gradient_color_1),
                                        MyRRect(Colors.black12),
                                      ],
                                    ),

                                    CupertinoButton(
                                      child: Icon(Icons.arrow_forward, color: AppColors.gradient_color_1,),
                                      onPressed: () {
                                        //Navigator.push(context, EnterExitRoute(exitPage: this.widget, enterPage: Screen2()));
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => Screen2()));

                                      },)
                                  ],
                                ),
                              )
                            ],

                          ))
                    ],),),

              ]
          ),
        ),
      ),
    );
  }
}