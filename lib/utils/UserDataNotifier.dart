import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDataNotifier extends ChangeNotifier {
  User _currentUser;

  UserDataNotifier() {
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  getCurrentUser() => _currentUser;

  notifyChange() {
    _currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }
}
