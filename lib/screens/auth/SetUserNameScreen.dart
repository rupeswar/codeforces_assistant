import 'package:codeforces_assistant/services/AuthenticationService.dart';
import 'package:codeforces_assistant/utils/SizeUtil.dart';
import 'package:codeforces_assistant/utils/UserDataNotifier.dart';
import 'package:codeforces_assistant/widgets/custom_button.dart';
import 'package:codeforces_assistant/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetUserNameScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthenticationService _authenticationService = AuthenticationService();
  TextEditingController userNameEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width;
    var heightPiece = MediaQuery.of(context).size.height;
    var size = SizeUtil(heightPiece, widthPiece);
    final userDataNotifier = Provider.of<UserDataNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set Username',
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
                  inputType: TextInputType.visiblePassword,
                ),
                SizedBox(height: size.size(20)),
                CustomButton(
                  child: Text(
                    'Set',
                    style: TextStyle(
                      fontSize: size.size(30),
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  textColor: Colors.white,
                  onPressed: () async {
                    final userName = userNameEditingController.text;
                    await _authenticationService.setUserName(
                        userName: userName, context: context);
                    userDataNotifier.setUserName(userName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
