import 'package:codeforces_assistant/screens/HomeScreen.dart';
import 'package:codeforces_assistant/screens/SignInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RouteBasedOnAuth extends StatelessWidget {
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  const RouteBasedOnAuth({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data != null)
            return builder(context, snapshot);
          else
            return builder(context, snapshot);
        }

        return CircularProgressIndicator();
      },
    );
  }
}

class RouteWidget extends StatelessWidget {
  final AsyncSnapshot<User> currentUserSnapshot;
  const RouteWidget({Key key, this.currentUserSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (currentUserSnapshot.data != null)
      return HomeScreen();
    else
      return SignInScreen();
  }
}
