import 'package:codeforces_assistant/services/AuthenticationService.dart';
import 'package:codeforces_assistant/utils/SizeUtil.dart';
import 'package:codeforces_assistant/utils/UserDataNotifier.dart';
import 'package:codeforces_assistant/widgets/custom_button.dart';
import 'package:codeforces_assistant/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneSignInPhoneNumberScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthenticationService _authenticationService = AuthenticationService();

  String phoneNo;
  bool isWeb = kIsWeb;

  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width;
    var heightPiece = MediaQuery.of(context).size.height;
    var size = SizeUtil(heightPiece, widthPiece);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In With Phone Number',
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
                  maxLength: 10,
                  hintText: 'Enter 10 digit mobile no.',
                  style: TextStyle(
                    fontSize: size.size(30),
                    height: 1.5,
                  ),
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
                SizedBox(height: size.size(20)),
                CustomButton(
                  child: Text(
                    'Send OTP',
                    style: TextStyle(
                      fontSize: size.size(30),
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
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
    var widthPiece = MediaQuery.of(context).size.width;
    var heightPiece = MediaQuery.of(context).size.height;
    var size = SizeUtil(heightPiece, widthPiece);
    final userDataNotifier = Provider.of<UserDataNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In With Phone Number',
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
                Text(
                  'Verify the OTP sent to this number',
                  style: TextStyle(fontSize: size.size(30)),
                ),
                SizedBox(height: size.size(10)),
                Text(
                  '$phoneNo',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: size.size(30),
                  ),
                ),
                SizedBox(height: size.size(20)),
                Text('Enter OTP'),
                SizedBox(height: size.size(20)),
                CustomTextField(
                  hintText: 'Your OTP here',
                  style: TextStyle(
                    fontSize: size.size(30),
                    height: 1.5,
                  ),
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
                SizedBox(height: size.size(20)),
                CustomButton(
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      fontSize: size.size(30),
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate())
                      await authenticationService.signInWithOTP(context,
                          smsOTP: _otp);

                    userDataNotifier.notifyChange();
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
