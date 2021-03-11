import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/classes.dart';
import '../resources/widgets.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Center(
              child: Column(
                children: [

                  // (1) Upper quarter
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text('Sign In', style: Screen2Styles.titleStyle()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text('Just one step away to\nexpore who\'s around you', textAlign: TextAlign.center,),
                          )
                        ],
                      ),
                    ),
                  ),

                  // (2) Middle
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Flexible(
                            flex: 2,
                            child: Center(
                              child: CupertinoTextField( // TODO Remove underline
                                style: Screen2Styles.textFieldStyle(),
                                padding: EdgeInsets.all(16),
                                placeholderStyle: TextStyle(color: Color(0xff5f5f5f)),
                                placeholder: 'Email/Username',
                                decoration: BoxDecoration(
                                    color: Color(0xffeeeeee),
                                    borderRadius: BorderRadius.circular(5)),
                                prefix: Padding(
                                  padding: const EdgeInsets.fromLTRB(12,0,0,0),
                                  child: Icon(Icons.perm_identity, color: Color(0xff9e9e9e),),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Center(
                              child: CupertinoTextField(
                                style: Screen2Styles.textFieldStyle(),
                                obscureText: true,
                                padding: EdgeInsets.all(16),
                                placeholderStyle: TextStyle(color: Color(0xff5f5f5f)),
                                placeholder: 'Password',
                                decoration: BoxDecoration(
                                    color: Color(0xffeeeeee),
                                    borderRadius: BorderRadius.circular(5)),
                                prefix: Padding(
                                  padding: const EdgeInsets.fromLTRB(12,0,0,0),
                                  child: Icon(Icons.lock_outline, color: Color(0xff9e9e9e)),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                AppColors.gradient_color_1,
                                                AppColors.gradient_color_2,
                                                AppColors.gradient_color_3,
                                              ]
                                          ),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: CupertinoButton(
                                          onPressed: () {  },
                                          child: Text('Sign in',
                                              style: TextStyle( // TODO Fix font
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white))),
                                    ),
                                  )
                                ],
                              ),
                            )),
                          Flexible(
                            flex: 1,
                            child: Center(
                              child: Text('Forgot Password?'),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 3,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.transparent,
                                        Colors.black
                                      ])
                                    ),
                                  ),
                                  Text('OR'),
                                  Container(
                                    height: 3,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.black,
                                          Colors.transparent
                                        ])
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                                color: Colors.green
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),

                  // (3) Lower quarter
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Colors.red,
                    ),
                  ),

                ],
              )
          ),
        ),
      ),
    );
  }
}



