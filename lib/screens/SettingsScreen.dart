import 'package:codeforces_assistant/screens/auth/EmailLinkScreen.dart';
import 'package:codeforces_assistant/screens/auth/PhoneLinkScreen.dart';
import 'package:codeforces_assistant/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width / 10;
    User currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widthPiece,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                child: Text(
                  'Link Phone Number',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (currentUser.phoneNumber == null)
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => PhoneLinkPhoneNumberScreen(),
                      ),
                    );
                  else
                    print('Already Linked');
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                child: Text(
                  'Link Email',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (currentUser.email == null)
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => EmailLinkScreen(),
                      ),
                    );
                  else
                    print('Already Linked');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
