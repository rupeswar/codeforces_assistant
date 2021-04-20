import 'package:codeforces_assistant/services/AuthenticationService.dart';
import 'package:codeforces_assistant/widgets/custom_button.dart';
import 'package:codeforces_assistant/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PhoneSignInPhoneNumberScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthenticationService _authenticationService = AuthenticationService();

  String phoneNo;
  bool isWeb = kIsWeb;

  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width / 10;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In With Phone Number',
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
                  maxLength: 10,
                  hintText: 'Enter 10 digit mobile no.',
                  inputType: TextInputType.phone,
                  onSaved: (value) => phoneNo = '+91$value',
                  validator: (value) {
                    if (value.length < 10 || value.length > 10)
                      return 'Invalid';
                    else {
                      _formKey.currentState.save();
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Send OTP',
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (isWeb)
                        await _authenticationService.webInitiatePhoneSignIn(
                            context, phoneNo);
                      else
                        await _authenticationService.nativeVerifyPhone(
                            context, phoneNo);
                      Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => PhoneSignInOTPScreen(
                          phoneNo: phoneNo,
                          authenticationService: _authenticationService,
                        ),
                      ));
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
}

class PhoneSignInOTPScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthenticationService authenticationService;

  String phoneNo, _otp;
  bool isWeb = kIsWeb;

  PhoneSignInOTPScreen(
      {Key key, @required this.phoneNo, @required this.authenticationService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width / 10;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In With Phone Number',
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
                Text(
                  'Verify the OTP sent to this number',
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 10),
                Text(
                  '$phoneNo',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 20),
                Text('Enter OTP'),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Your OTP here',
                  maxLength: 6,
                  inputType: TextInputType.number,
                  onSaved: (otp) => _otp = otp,
                  validator: (value) {
                    if (value.length != 6)
                      return 'Invalid';
                    else {
                      _formKey.currentState.save();
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Proceed',
                  onPressed: () async {
                    if (_formKey.currentState.validate())
                      await authenticationService.signInWithOTP(context,
                          smsOTP: _otp);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
