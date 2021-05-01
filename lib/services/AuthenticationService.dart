import 'package:codeforces_assistant/services/FirestoreService.dart';
import 'package:codeforces_assistant/utils/Dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:codeforces_assistant/wrappers/html/html_stub.dart'
    if (dart.library.js) 'package:codeforces_assistant/wrappers/html/html_web.dart';

class AuthenticationService {
  String verificationId;
  String errorMessage = '';
  // For firebase auth
  final auth = FirebaseAuth.instance;
  bool isWeb = kIsWeb;

  Future<void> nativeVerifyPhone(BuildContext context, String phoneNo) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      // final res =
      await auth.signInWithCredential(phoneAuthCredential);
      // Todo After Verification Complete
      Navigator.of(context).pop();
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('Auth Exception is ${authException.message}');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
    };

    await auth.verifyPhoneNumber(
      // mobile no. with country code
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 30),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<void> signInWithOTP(context, {@required String smsOTP}) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      await auth.signInWithCredential(credential);

      if (isWeb) {
        var captcha = querySelector('#__ff-recaptcha-container');
        if (captcha != null) captcha.hidden = true;
      }

      // Todo After Verification Complete
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> webInitiatePhoneSignIn(
      BuildContext context, String phoneNo) async {
    ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
      phoneNo,
    );
    verificationId = confirmationResult.verificationId;
  }

  Future<void> createUserWithEmail({
    @required String email,
    @required String password,
    @required BuildContext context,
  }) async {
    try {
      // UserCredential userCredential =
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await auth.currentUser.sendEmailVerification();

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showUserAlreadyRegisteredDialog(context);
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInUserWithEmail({
    @required String email,
    @required String password,
    @required BuildContext context,
  }) async {
    try {
      // UserCredential userCredential =
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showUserNotRegisteredDialog(context);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else
        print('$e ${e.code}');
    }
  }

  void showUserAlreadyRegisteredDialog(BuildContext context) {
    showDialog(
        context: context, builder: (context) => EmailAlreadyRegistered());
  }

  void showUserNotRegisteredDialog(BuildContext context) {
    showDialog(
        context: context, builder: (context) => EmailNotRegisteredPopUp());
  }

  Future<void> webInitiateLinkPhoneWithUser(BuildContext context,
      {@required String phoneNo}) async {
    ConfirmationResult confirmationResult =
        await auth.currentUser.linkWithPhoneNumber(phoneNo);
    verificationId = confirmationResult.verificationId;
  }

  Future<void> linkWithOTP(
    context, {
    @required String smsOTP,
  }) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      await auth.currentUser.linkWithCredential(credential);

      // Todo After Verification Complete
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  Future<void> linkUserWithEmail({
    @required String email,
    @required String password,
    @required BuildContext context,
  }) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    await auth.currentUser.linkWithCredential(credential);
    await auth.currentUser.sendEmailVerification();

    Navigator.of(context).pop();
  }

  Future<void> setUserName({String userName, BuildContext context}) async {
    await FirestoreService.createUser(userName, context);
    Navigator.of(context).pop();
  }
}
