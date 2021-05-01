import 'package:codeforces_assistant/services/FirestoreService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDataNotifier extends ChangeNotifier {
  User _currentUser;
  String userName, handle;

  UserDataNotifier() {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) initialiseAsyncVariables();
  }

  getCurrentUser() => _currentUser;

  notifyChange() {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) initialiseAsyncVariables();
    notifyListeners();
  }

  initialiseAsyncVariables() async {
    var userDoc =
        await FirestoreService.getUserFromId(uid: _currentUser.uid).get();
    if (!userDoc.exists) {
      userName = null;
      handle = null;
    } else {
      var data = userDoc.data();
      userName = data['userName'];
      print(userName);
      userDoc =
          await FirestoreService.getUserFromUserName(userName: userName).get();
      data = userDoc.data();
      handle = data['handle'];
    }
    notifyListeners();
  }

  setUserName(String newUserName) {
    userName = newUserName;
    notifyListeners();
  }

  setHandle(String newHandle) {
    handle = newHandle;
    notifyListeners();
  }
}
