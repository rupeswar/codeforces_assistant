import 'package:codeforces_assistant/services/AuthenticationService.dart';
import 'package:codeforces_assistant/utils/UserDataNotifier.dart';
import 'package:codeforces_assistant/widgets/custom_button.dart';
import 'package:codeforces_assistant/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailLinkScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthenticationService _authenticationService = AuthenticationService();
  TextEditingController emailEditingController = TextEditingController(),
      passwordEditingController = TextEditingController(),
      confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width / 10;
    final userDataNotifier = Provider.of<UserDataNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Link Email',
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
                  text: 'Link',
                  textColor: Colors.white,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await _authenticationService.linkUserWithEmail(
                        email: emailEditingController.text,
                        password: passwordEditingController.text,
                        context: context,
                      );
                      userDataNotifier.notifyChange();
                    }
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
