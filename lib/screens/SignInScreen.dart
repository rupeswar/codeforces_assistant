import 'package:codeforces_assistant/screens/auth/EmailSignInScreen.dart';
import 'package:codeforces_assistant/screens/auth/PhoneSignInScreen.dart';
import 'package:codeforces_assistant/utils/SizeUtil.dart';
import 'package:codeforces_assistant/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  SizeUtil size;

  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width;
    var heightPiece = MediaQuery.of(context).size.height;
    size = SizeUtil(heightPiece, widthPiece);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.widthPercent(10),
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
          child: Text(
            'Sign In/Sign Up With Phone Number and OTP',
            style: TextStyle(
              fontSize: size.size(30),
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => PhoneSignInPhoneNumberScreen(),
            ));
          },
        ),
        SizedBox(height: size.size(20)),
        CustomButton(
          child: Text(
            'Sign In With Email',
            style: TextStyle(
              fontSize: size.size(30),
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => EmailSignInScreen(),
            ));
          },
        ),
        SizedBox(height: size.size(20)),
        CustomButton(
          child: Text(
            'Sign Up With Email',
            style: TextStyle(
              fontSize: size.size(30),
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => EmailSignUpScreen(),
            ));
          },
        ),
        SizedBox(height: size.size(20)),
        CustomButton(
          child: Text(
            'Sign In With Username and OTP',
            style: TextStyle(
              fontSize: size.size(30),
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => PhoneSignInUserNameScreen(),
            ));
          },
        ),
        SizedBox(height: size.size(20)),
        CustomButton(
          child: Text(
            'Sign In With Username and Password',
            style: TextStyle(
              fontSize: size.size(30),
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => EmailSignInWithUserNameScreen(),
            ));
          },
        ),
      ],
    );
  }
}
