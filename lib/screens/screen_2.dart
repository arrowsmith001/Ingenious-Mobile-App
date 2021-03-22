import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/classes.dart';
import '../resources/widgets.dart';
import '../resources/extensions.dart';
import 'screen_3.dart';

// Title for Screen2
class Screen2_Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sign In', style: Screen2Styles.titleStyle()).Padded(const EdgeInsets.fromLTRB(0,0,0,4)),
        Text('Just one step away to\nexpore who\'s around you', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)).Padded(const EdgeInsets.fromLTRB(0,4,0,0))
      ],
    );
  }
}


// Sign-in button for Screen2
class Screen2_SignInButton extends StatelessWidget {

  Screen2_SignInButton(this.validateForm);
  void Function(BuildContext context) validateForm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        AppColors.gradient_color_blue,
                        AppColors.gradient_color_purple,
                        AppColors.gradient_color_pink,
                      ]
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: CupertinoButton(
                  onPressed: () {
                    validateForm(context);
                  },
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text('Sign in',
                      style: Screen2Styles.signInButtonStyle()),
            ),
        ),
        )
      ],
    );

  }
}

// "Forgot password" prompt for Screen2
class Screen2_ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Forgot Password?', style: TextStyle(fontSize: 14, color: Colors.black38));
  }
}

// "OR" prompt with horizontal divider line for Screen2
class Screen2_OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        DividerLine(),

        Container(
            width: 30,
            child: Text('OR', style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
            color: Theme.of(context).scaffoldBackgroundColor)
      ],
    );
  }
}


// Social media button panel for Screen2 (has no button functionality)
class Screen2_SocialMediaButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SocialMediaButton(
            AppImagePaths.google_icon,
            Colors.red),

        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 25.0),

          child: SocialMediaButton(
              AppImagePaths.apple_icon,
              Colors.black),
        ),

        SocialMediaButton(
            AppImagePaths.facebook_icon,
            Color(0xff0074bf)),
      ],
    );
  }
}

// Terms of service text prompt for Screen2
class Screen2_TermsOfServiceText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'By signing in to Hubwork, you agree to our Terms of Service. Learn how we process your data in our privacy policy.',
      textAlign: TextAlign.center,);
  }
}



// SCREEN 2
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
      emailValidation = Validators.EmailValidation(_emailUsernameController.text);
      passwordValidation = Validators.PasswordValidation(_passwordController.text);
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
    super.dispose();
    _emailUsernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column (
                children: [

                  // (1) Upper "half"
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Screen2_Title()
                            .Padded(const EdgeInsets.fromLTRB(0, 24, 0, 24)),

                        // TEXT FIELD 1 for Email/Username
                        MyCupertinoTextField(controller: _emailUsernameController, textEntryType: TextEntryType.email, valid: emailValidation == null)
                          .Padded(const EdgeInsets.symmetric(vertical: 6)).MakeFlexible(),

                        // TEXT FIELD 2 for Password
                        MyCupertinoTextField(controller: _passwordController, textEntryType: TextEntryType.password, valid: passwordValidation == null)
                            .Padded(const EdgeInsets.symmetric(vertical: 6)).MakeFlexible(),

                      ],
                    ),
                  ),

                  // (2) Button positioned in center
                  Screen2_SignInButton(validateForm)
                      .Padded(const EdgeInsets.symmetric(vertical: 18.0)),

                  // (3) Lower "half"
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Screen2_ForgotPassword()
                            .Padded(const EdgeInsets.symmetric(vertical: 8.0)).MakeFlexible(),

                        Screen2_OrDivider()
                            .Padded(const EdgeInsets.symmetric(vertical: 12.0)).MakeFlexible(),

                        Screen2_SocialMediaButtons()
                            .Padded(const EdgeInsets.symmetric(vertical: 12.0)).MakeFlexible(),

                        Screen2_TermsOfServiceText()
                            .Padded(const EdgeInsets.symmetric(vertical: 12.0)),


                      ],
                    ),
                  ),

                ],
              ),
            )
        ),
      ),
    );
  }
}






