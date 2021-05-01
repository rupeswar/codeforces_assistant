import 'package:codeforces_assistant/services/AuthenticationService.dart';
import 'package:codeforces_assistant/utils/SizeUtil.dart';
import 'package:codeforces_assistant/utils/UserDataNotifier.dart';
import 'package:codeforces_assistant/widgets/custom_button.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConnectivityResult connectivityResult =
        Provider.of<ConnectivityResult>(context);
    var widthPiece = MediaQuery.of(context).size.width;
    var heightPiece = MediaQuery.of(context).size.height;
    var size = SizeUtil(heightPiece, widthPiece);

    return Consumer<UserDataNotifier>(builder: (context, userDataNotifier, _) {
      User currentUser = userDataNotifier.getCurrentUser();
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.widthPercent(10),
        ),
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(fontSize: size.size(30), color: Colors.black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                ),
                SizedBox(
                  height: size.size(10),
                ),
                Text(
                  'Your registered number is: ${currentUser.phoneNumber ?? 'Not Set'}',
                ),
                SizedBox(
                  height: size.size(10),
                ),
                Text(
                  'Your registered email is : ${currentUser.email ?? 'Not Set'}',
                ),
                SizedBox(
                  height: size.size(10),
                ),
                Text(
                  'Email Verified? : ${currentUser.emailVerified}',
                ),
                SizedBox(
                  height: size.size(10),
                ),
                Text(
                  'Display Name : ${currentUser.displayName ?? 'Not Set'}',
                ),
                SizedBox(
                  height: size.size(10),
                ),
                Text(
                  'Username : ${userDataNotifier.userName ?? 'Not Set'}',
                ),
                SizedBox(
                  height: size.size(10),
                ),
                Container(
                  color: connectivityResult == ConnectivityResult.none
                      ? Colors.red
                      : Colors.green,
                  height: size.size(30),
                  width: double.infinity,
                ),
                SizedBox(
                  height: size.size(10),
                ),
                CustomButton(
                  child: Padding(
                    padding: EdgeInsets.all(size.size(20)),
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                        fontSize: size.size(30),
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  buttonColor: Colors.blue,
                  autoSize: true,
                  onPressed: () async {
                    await AuthenticationService().signOut();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
