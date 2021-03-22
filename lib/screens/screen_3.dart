import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/extensions.dart';
import '../resources/classes.dart';
import '../resources/widgets.dart';

enum AnimationMode{scale, spin, jump, orbit}

// The "@" symbol and surrounding circle, including some animations
class Screen3AtSymbol extends StatefulWidget {
  Screen3AtSymbol(this.animationValue, this.animationMode, {@required this.radius, @required this.thickness, @required this.iconSize});

  final double animationValue;
  final AnimationMode animationMode;

  final double radius;
  final double thickness;
  final double iconSize;

  // Some interpolators to use for animations
  final Interpolator overshootInterp = new OvershootInterpolator(T: 1);
  final Interpolator anticipateOvershootInterp = new AnticipateOvershootInterpolator(T: 5);
  final Interpolator bounceInterp = new BounceInterpolator();
  final Interpolator jumpThenBounceInterp = new JumpThenBounceInterpolator();

  @override
  _Screen3AtSymbolState createState() => _Screen3AtSymbolState();
}

class _Screen3AtSymbolState extends State<Screen3AtSymbol> {

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

    // Containing circle
    Widget circle = CircleAvatar(
      radius: widget.radius + widget.thickness/2,
      backgroundColor: Color(0xFFDCDCDC),
      child: CircleAvatar(
        radius: widget.radius - widget.thickness/2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );

    switch(widget.animationMode){

      case AnimationMode.scale:
      // Scale animation
        icon = Transform.scale(
          scale: widget.overshootInterp.getValue(widget.animationValue),
          child: icon,);
        break;
      case AnimationMode.spin:
      // Rotate animation
        icon = Transform.rotate(
          angle: -pi*2*widget.anticipateOvershootInterp.getValue(widget.animationValue),
          child: icon,);
        break;
      case AnimationMode.jump:

        icon = Transform.translate(
          offset: Offset(0, -50*widget.jumpThenBounceInterp.getValue(widget.animationValue)),
          child: icon,);
        break;
      case AnimationMode.orbit:

        double t = sin(widget.animationValue*2*pi);

        icon = Transform.translate(
          offset: Offset(t*75, t*-75),
          child: icon,);

        // If in middle half of the animation...
        if(widget.animationValue > 0.25 && widget.animationValue < 0.75){

          // Return reversed stack ("@" behind circle)
          return Stack(
              children: [
                Positioned.fill(child: Align(alignment: Alignment.center, child: icon)),
                Align(alignment: Alignment.center, child: circle),
              ]
          );
        }
        break;
    }

    return Stack(
        children: [
          Align(alignment: Alignment.center, child: circle),
          Positioned.fill(child: Align(alignment: Alignment.center, child: icon)),
        ]
    );

  }
}

// Title for Screen3
class Screen3_Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Username', style: Screen3Styles.titleStyle()).Padded(const EdgeInsets.all(6.0)),
        Text('Choose your @username')
      ],
    );
  }
}

class Screen3_NavigationPanel extends StatelessWidget {

  Screen3_NavigationPanel(this.onPreviousPressed, this.onNextPressed);
  void Function() onPreviousPressed;
  void Function() onNextPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        // "Previous" button
        CupertinoButton(
            onPressed: onPreviousPressed,
            child: Text('Previous', style: TextStyle(color: Colors.black))
        ),

        // "Next" button with arrow
        CupertinoButton(
            onPressed: onNextPressed,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,4,1),
                  child: Text('Next', style: TextStyle(color: Colors.black)),
                ),
                Icon(Icons.arrow_forward, color: Colors.black, size: 15)
              ],
            )
        ),

      ],
    );
  }
}


// SCREEN 3
class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> with SingleTickerProviderStateMixin{

  TextEditingController _textEditingController = new TextEditingController();
  String usernameValidation;

  AnimationController _animController;
  AnimationMode animationMode = AnimationMode.scale;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animController.addListener(() {setState(() {
    });});

    Future.delayed(const Duration(milliseconds: 500), () {
      _animController.forward(from: 0);
    });
  }

  void onPreviousPressed() => Navigator.of(context).pop();

  void onNextPressed(){

    // Sets text field borders red if user entry is invalid
    setState(() {
      usernameValidation = Validators.UsernameValidation(_textEditingController.value.text);
    });

    if(usernameValidation != null){

      // Could give user feedback here on the nature of the error
      print('Username entry error: ' + usernameValidation);
      return;
    }

    // My class that will manage the credentials across the app
    UserCredentialsManager ucm = UserCredentialsManager.getInstance();
    ucm.setUsername(_textEditingController.value.text);

    // Print info to console
    print(ucm.getString());

    // Do a lil animation
    _animController.forward(from: 0);

    setState(() {
      // Cycle to next animation
      animationMode = AnimationMode.values[(animationMode.index + 1) % AnimationMode.values.length];
    });

  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
            children: [

              // (1) Main screen features
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    children: [

                      // (1-1) Top half
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              // "@" symbol, with circle, at top of screen
                              Screen3AtSymbol(_animController.value, animationMode, radius: 45, thickness: 4, iconSize: 37).Padded(const EdgeInsets.fromLTRB(0,25,0,0)),

                              // "Username" title and subtitle
                              Screen3_Title().Padded(const EdgeInsets.fromLTRB(0, 15, 0, 25)),

                              // Username text field
                              MyCupertinoTextField(
                                  controller: _textEditingController,
                                  textEntryType: TextEntryType.username,
                                  valid: usernameValidation == null,
                                ).Padded(const EdgeInsets.symmetric(vertical: 8.0)).MakeFlexible()

                            ],
                          )
                      ),


                      // (1-2) Bottom half - padding
                      Expanded(
                          child: Container()
                      )

                    ]
                ),
              ),


              // (2) Navigation buttons
              Screen3_NavigationPanel(onPreviousPressed, onNextPressed)
                  .Padded(const EdgeInsets.fromLTRB(15,0,15,25))
                  .Aligned(Alignment.bottomCenter)
            ]
        ),
      ),
    );
  }
}
