import 'package:flutter/material.dart';
import 'package:codeforces_assistant/screens/HomeScreen.dart';

class DrawerFragmentNotifier extends ChangeNotifier {
  DrawerState _drawerState = DrawerState.UserInfo;

  getState() => _drawerState;

  setState(DrawerState drawerState) {
    _drawerState = drawerState;
    notifyListeners();
  }
}
