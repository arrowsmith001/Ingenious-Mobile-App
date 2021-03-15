import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/classes.dart';
import '../resources/widgets.dart';


// Open to modification if more specific validation is required
String UsernameValidation<T>(T value){
  if(value.toString() == "") return "This field must not be empty";
  return null;
}

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {

  TextEditingController _controller = new TextEditingController();
  String usernameValidation;

  void onPreviousPressed(){
    Navigator.of(context).pop();
  }

  void onNextPressed(){

    // Sets text field borders red if user entry is invalid
    setState(() {
      usernameValidation = UsernameValidation(_controller.value.text);
    });

    if(usernameValidation != null){
      // Could give user feedback here on the nature of the error
      print('Username entry error: ' + usernameValidation);
      return;
    }

    // My class that will manage the credentials across the app
    UserCredentialsManager ucm = UserCredentialsManager.getInstance();
    ucm.setUsername(_controller.value.text);

    // Print info to console
    print(ucm.getString());
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [

                    // (1) Top half
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            // "@" symbol, with circle, at top of screen
                            Screen3AtSymbol(radius: 45, thickness: 4, iconSize: 37),

                            // "Username" title and subtitle
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 25),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text('Username', style: Screen3Styles.titleStyle()),
                                  ),
                                  Text('Choose your @username')
                                ],
                              ),
                            ),

                            // Username text field
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: MyCupertinoTextField(
                                controller: _controller,
                                textEntryType: TextEntryType.username,
                                valid: usernameValidation == null,
                              ),
                            )

                          ],
                        )
                      ),


                    // (2) Bottom half
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,50),
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    // "Previous" button
                                    CupertinoButton(
                                        onPressed: () { onPreviousPressed(); },
                                        child: Text('Previous', style: TextStyle(color: Colors.black))
                                    ),

                                    // "Next" button with arrow
                                    CupertinoButton(
                                        onPressed: () { onNextPressed(); },
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
                              ),
                                ),

                        ],
                      ))

                  ]
                ),
              )
          ),
        ),
      ),
    );
  }
}
