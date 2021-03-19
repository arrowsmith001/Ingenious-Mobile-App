import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/classes.dart';
import '../resources/widgets.dart';
import '../resources/extensions.dart';
import 'screen_2.dart';


class Screen1_Title extends StatelessWidget {
  Screen1_Title(this.animationValue);
  final double animationValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Hubwork', style: Screen1Styles.titleStyleAnimated(animationValue), textAlign: TextAlign.center),
        Text('Reconnecting People', style: TextStyle(fontSize: 17.5)),
      ],
    );
  }
}


class Screen1_Image extends StatelessWidget {
  Screen1_Image({this.height});
  double height = 150;

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImages.Screen1_image, height: height, fit: BoxFit.fitHeight,);
  }
}


class Screen1_SubtitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Message freelancers\ndirectly or post a job that\nneeds doing',
              style: Screen1Styles.subtitleStyle(),
              textAlign: TextAlign.center)
        ]
    );
  }
}


class Screen1_FindOutMore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Find out more',
        style: TextStyle(
            color: Colors.grey,
            fontSize: 13));
  }
}


class Screen1_NavigationPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // (1) Left: Page indicator? (not functional)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyRRect(Colors.black12),
                  MyRRect(AppColors.gradient_color_blue),
                  MyRRect(Colors.black12),
                ],
              ),

              // (2) Right: "Next" button
              CupertinoButton(
                child: Icon(Icons.arrow_forward, color: AppColors.gradient_color_blue,),
                onPressed: () {
                  //Navigator.push(context, EnterExitRoute(exitPage: this.widget, enterPage: Screen2()));
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => Screen2()));

                },)
            ],
          )
    );
  }
}



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
    _controller.addListener(() {  setState(() {});  });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

  // Structure: The bottom edge of the image is the vertical center, and other widgets are spaced vertically around this
    return SafeArea(
      child: Scaffold(
        body: Stack(
            children: [

              // (1) Main screen features
              Center(
                child: Column(
                    children: [

                      // (1-1) Upper half
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Screen1_Title(_controller.value).MakeFlexible(),

                            Screen1_Image(height: SizeConfig.blockSizeVertical*20).Padded(const EdgeInsets.fromLTRB(0,0,0, 0)).MakeFlexible(),

                          ],),
                      ),

                      // (1-2) Lower half
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Screen1_SubtitleText().Padded(const EdgeInsets.fromLTRB(12, 45, 12, 28)),

                            Screen1_FindOutMore().MakeFlexible(),

                          ],),
                      )
                    ]
                ),
              ),

              // (2) Navigation panel
              Screen1_NavigationPanel().Padded(const EdgeInsets.fromLTRB(25, 0, 25, 25))

            ]
        ),
      ),
    );
  }
}