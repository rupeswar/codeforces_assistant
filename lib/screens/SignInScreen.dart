import 'package:codeforces_assistant/screens/auth/EmailSignInScreen.dart';
import 'package:codeforces_assistant/screens/auth/PhoneSignInScreen.dart';
import 'package:codeforces_assistant/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width / 10;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widthPiece,
        ),
        child: Center(
          child: buildChooseLogInFragment(context),
        ),
      ),
    );
  }

  Widget buildChooseLogInFragment(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          text: 'Sign In/Sign Up With Phone Number and OTP',
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => PhoneSignInPhoneNumberScreen(),
            ));
          },
        ),
        SizedBox(height: 20),
        CustomButton(
          text: 'Sign In With Email',
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => EmailSignInScreen(),
            ));
          },
        ),
        SizedBox(height: 20),
        CustomButton(
          text: 'Sign Up With Email',
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => EmailSignUpScreen(),
            ));
          },
        )
      ],
    );
  }
}
