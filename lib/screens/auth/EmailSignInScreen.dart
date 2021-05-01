import 'package:codeforces_assistant/services/AuthenticationService.dart';
import 'package:codeforces_assistant/services/FirestoreService.dart';
import 'package:codeforces_assistant/utils/SizeUtil.dart';
import 'package:codeforces_assistant/utils/UserDataNotifier.dart';
import 'package:codeforces_assistant/widgets/custom_button.dart';
import 'package:codeforces_assistant/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailSignInScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthenticationService _authenticationService = AuthenticationService();
  TextEditingController emailEditingController = TextEditingController(),
      passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width;
    var heightPiece = MediaQuery.of(context).size.height;
    var size = SizeUtil(heightPiece, widthPiece);
    final userDataNotifier = Provider.of<UserDataNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In With Email',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.widthPercent(10),
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: emailEditingController,
                  hintText: 'Email',
                  style: TextStyle(
                    fontSize: size.size(30),
                    height: 1.5,
                  ),
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: size.size(20)),
                CustomTextField(
                  controller: passwordEditingController,
                  hintText: 'Password',
                  style: TextStyle(
                    fontSize: size.size(30),
                    height: 1.5,
                  ),
                  obscureText: true,
                  validator: validator,
                ),
                SizedBox(height: size.size(20)),
                CustomButton(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: size.size(30),
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  textColor: Colors.white,
                  onPressed: () async {
                    if (_formKey.currentState.validate())
                      await _authenticationService.signInUserWithEmail(
                        email: emailEditingController.text,
                        password: passwordEditingController.text,
                        context: context,
                      );
                    else
                      print('Failed Validation');

                    userDataNotifier.notifyChange();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validator(String value) {
    if (passwordEditingController.text != '') {
      print('Passed');
      return null;
    } else {
      print('Not Passed');
      return 'Passwords do not match.';
    }
  }
}

class EmailSignInWithUserNameScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthenticationService _authenticationService = AuthenticationService();
  TextEditingController userNameEditingController = TextEditingController(),
      passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width;
    var heightPiece = MediaQuery.of(context).size.height;
    var size = SizeUtil(heightPiece, widthPiece);
    final userDataNotifier = Provider.of<UserDataNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In With Username and Password',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.widthPercent(10),
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: userNameEditingController,
                  hintText: 'Username',
                  style: TextStyle(
                    fontSize: size.size(30),
                    height: 1.5,
                  ),
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: size.size(20)),
                CustomTextField(
                  controller: passwordEditingController,
                  hintText: 'Password',
                  style: TextStyle(
                    fontSize: size.size(30),
                    height: 1.5,
                  ),
                  obscureText: true,
                  validator: validator,
                ),
                SizedBox(height: size.size(20)),
                CustomButton(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: size.size(30),
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  textColor: Colors.white,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      String email = await FirestoreService.getEmailByUserName(
                          userNameEditingController.text);
                      await _authenticationService.signInUserWithEmail(
                        email: email,
                        password: passwordEditingController.text,
                        context: context,
                      );
                    } else
                      print('Failed Validation');

                    userDataNotifier.notifyChange();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validator(String value) {
    if (passwordEditingController.text != '') {
      print('Passed');
      return null;
    } else {
      print('Not Passed');
      return 'Passwords do not match.';
    }
  }
}

class EmailSignUpScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthenticationService _authenticationService = AuthenticationService();
  TextEditingController emailEditingController = TextEditingController(),
      passwordEditingController = TextEditingController(),
      confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width;
    var heightPiece = MediaQuery.of(context).size.height;
    var size = SizeUtil(heightPiece, widthPiece);
    final userDataNotifier = Provider.of<UserDataNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.widthPercent(10),
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: emailEditingController,
                  hintText: 'Email',
                  style: TextStyle(
                    fontSize: size.size(30),
                    height: 1.5,
                  ),
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: size.size(20)),
                CustomTextField(
                  controller: passwordEditingController,
                  hintText: 'Password',
                  style: TextStyle(
                    fontSize: size.size(30),
                    height: 1.5,
                  ),
                  obscureText: true,
                  validator: validator,
                ),
                SizedBox(height: size.size(20)),
                CustomTextField(
                  controller: confirmPasswordEditingController,
                  hintText: 'Confirm Password',
                  style: TextStyle(
                    fontSize: size.size(30),
                    height: 1.5,
                  ),
                  obscureText: true,
                  validator: validator,
                ),
                SizedBox(height: size.size(20)),
                CustomButton(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: size.size(30),
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  textColor: Colors.white,
                  onPressed: () async {
                    if (_formKey.currentState.validate())
                      await _authenticationService.createUserWithEmail(
                        email: emailEditingController.text,
                        password: passwordEditingController.text,
                        context: context,
                      );

                    userDataNotifier.notifyChange();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validator(String value) {
    if (passwordEditingController.text !=
            confirmPasswordEditingController.text &&
        passwordEditingController.text != '' &&
        confirmPasswordEditingController.text != '')
      return 'Passwords do not match';
    else if (passwordEditingController.text ==
            confirmPasswordEditingController.text &&
        passwordEditingController.text != '')
      return null;
    else
      return 'Passwords do not match.';
  }
}
