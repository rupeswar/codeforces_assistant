import 'package:codeforces_assistant/services/AuthenticationService.dart';
import 'package:codeforces_assistant/widgets/custom_button.dart';
import 'package:codeforces_assistant/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class EmailSignInScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthenticationService _authenticationService = AuthenticationService();
  TextEditingController emailEditingController = TextEditingController(),
      passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width / 10;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In With Email',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widthPiece,
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
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: passwordEditingController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: validator,
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Login',
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
    var widthPiece = MediaQuery.of(context).size.width / 10;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widthPiece,
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
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: passwordEditingController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: validator,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: confirmPasswordEditingController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  validator: validator,
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Login',
                  textColor: Colors.white,
                  onPressed: () async {
                    if (_formKey.currentState.validate())
                      await _authenticationService.createUserWithEmail(
                        email: emailEditingController.text,
                        password: passwordEditingController.text,
                        context: context,
                      );
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
