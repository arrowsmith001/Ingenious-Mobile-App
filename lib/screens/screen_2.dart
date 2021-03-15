import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/classes.dart';
import '../resources/widgets.dart';
import 'screen_3.dart';

// Open to modification if more specific validation is required
String EmailValidation<T>(T value){
  if(value.toString() == "") return "This field must not be empty";
  return null;
}

// Open to modification if more specific validation is required
String PasswordValidation<T>(T value){
  if(value.toString() == "") return "This field must not be empty";
  return null;
}

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {

  final TextEditingController _emailUsernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String emailValidation;
  String passwordValidation;

  // To be called when "Sign In" button is pressed
  void validateForm(BuildContext context){

    // Sets text field borders red if user entry is invalid
    setState(() {
      emailValidation = EmailValidation(_emailUsernameController.text);
      passwordValidation = PasswordValidation(_passwordController.text);
    });

    if(emailValidation != null || passwordValidation != null){

      // Could give user feedback here on the nature of the error
      if(emailValidation != null) print('Username entry error: ' + emailValidation);
      if(passwordValidation != null) print('Password entry error: ' + passwordValidation);

      return;
    }

    // My class that will manage the credentials across the app
    UserCredentialsManager ucm = UserCredentialsManager.getInstance();
    ucm.setEmailAndPassword(_emailUsernameController.value.text,_passwordController.value.text);

    // Navigate to Screen 3
    Navigator.push(context, CupertinoPageRoute(builder: (context) => Screen3()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailUsernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Flex values for managing the space
    int titleFlex = 3;
    int textField1Flex = 2;
    int textField2Flex = 2;
    int signInButtonFlex = 2;
    int forgotPasswordFlex = 1;
    int orDividerFlex = 1;
    int socialMediaButtonsFlex = 3;
    int smallprintFlex = 2;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column (
                    children: [

                    Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // TITLE: Sign in, ...
                        Flexible(
                          flex: titleFlex,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('Sign In', style: Screen2Styles.titleStyle()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                      'Just one step away to\nexpore who\'s around you',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18)),
                                )
                              ],
                            ),
                          ),
                        ),

                        // TEXT FIELD 1 for Email/Username
                        Flexible(
                          flex: textField1Flex,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: MyCupertinoTextField(
                                controller: _emailUsernameController,
                                textEntryType: TextEntryType.email,
                                valid: emailValidation == null),
                          ),
                        ),

                        // TEXT FIELD 2 for Password
                        Flexible(
                          flex: textField2Flex,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: MyCupertinoTextField(
                                controller: _passwordController,
                                textEntryType: TextEntryType.password,
                                valid: passwordValidation == null
                            ),
                          ),
                        ),

                        // SIGN IN BUTTON
                        Flexible(
                            flex: signInButtonFlex,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                children: [
                                  Screen2SignInButton(validateForm)
                                ],
                              ),
                            )),

                        // FORGOT PASSWORD PROMPT
                        Flexible(
                          flex: forgotPasswordFlex,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text('Forgot Password?', style: TextStyle(fontSize: 14, color: Colors.black38)),
                          ),
                        ),

                        // OR DIVIDER
                        Flexible(
                          flex: orDividerFlex,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Stack(
                              children: [
                                Center(child: DividerLine()),
                                Center(
                                    child: Container(
                                        width: 30,
                                        child: Text('OR', style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
                                        color: Theme.of(context).scaffoldBackgroundColor))
                              ],
                            ),
                          ),
                        ),

                        // SOCIAL MEDIA SIGN-IN BUTTONS
                        Flexible(
                          flex: socialMediaButtonsFlex,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                SocialMediaButton(
                                    AppImages.google_icon,
                                    Colors.red),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),

                                  child: SocialMediaButton(
                                      AppImages.apple_icon,
                                      Colors.black),
                                ),

                                SocialMediaButton(
                                    AppImages.facebook_icon,
                                    Color(0xff0074bf)),
                              ],
                            ),
                          ),
                        ),

                        // TERMS OF SERVICE SMALLPRINT
                        Flexible(
                          flex: smallprintFlex,
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                child: Text(
                                  'By signing in to Hubwork, you agree to our Terms of\nService. Learn how we process your data in our privacy\npolicy.',
                                  textAlign: TextAlign.center,),
                              )
                          ),
                        )


                      ],
                    ),
        ),

        ],
      ),
              )
          ),
        ),
      ),
    );
  }
}






