import 'package:codeforces_assistant/services/AuthenticationService.dart';
import 'package:codeforces_assistant/utils/UserDataNotifier.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConnectivityResult connectivityResult =
        Provider.of<ConnectivityResult>(context);
    var widthPiece = MediaQuery.of(context).size.width / 10;

    return Consumer<UserDataNotifier>(builder: (context, userDataNotifier, _) {
      User currentUser = userDataNotifier.getCurrentUser();
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widthPiece,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Your registered number is: ${currentUser.phoneNumber}',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Your registered email is : ${currentUser.email}',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Email Verified? : ${currentUser.emailVerified}',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Display Name : ${currentUser.displayName}',
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: connectivityResult == ConnectivityResult.none
                    ? Colors.red
                    : Colors.green,
                height: 20,
                width: double.infinity,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                child: Text(
                  'Sign Out',
                ),
                color: Colors.blue,
                onPressed: () async {
                  await AuthenticationService().signOut();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
