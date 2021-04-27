import 'package:codeforces_assistant/screens/SettingsScreen.dart';
import 'package:codeforces_assistant/screens/drawer_fragments/codeforces/ContestsFragment.dart';
import 'package:codeforces_assistant/screens/drawer_fragments/codeforces/CodeforcesProfileFragment.dart';
import 'package:codeforces_assistant/screens/drawer_fragments/UserInfoFragment.dart';
import 'package:codeforces_assistant/utils/DrawerFragmentNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DrawerFragmentNotifier>(
      create: (_) => DrawerFragmentNotifier(),
      builder: (context, _) {
        final drawerState = Provider.of<DrawerFragmentNotifier>(context);
        return Scaffold(
          appBar: AppBar(
            title: Consumer<DrawerFragmentNotifier>(
              builder: (context, drawerFragmentNotifier, _) {
                DrawerState drawerState = drawerFragmentNotifier.getState();
                return Text(getTitle(drawerState));
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Text('Codeforces Assistant'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Home'),
                  onTap: () {
                    drawerState.setState(DrawerState.UserInfo);
                    Navigator.of(context).pop();
                  },
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    'CODEFORCES',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Profile'),
                  onTap: () {
                    drawerState.setState(DrawerState.CodeforcesUserInfo);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text('Contests'),
                  onTap: () {
                    drawerState.setState(DrawerState.Contests);
                    Navigator.of(context).pop();
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Loading'),
                  onTap: () {
                    drawerState.setState(DrawerState.Other);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Hi')));
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
          body: Consumer<DrawerFragmentNotifier>(
            builder: (context, drawerFragmentNotifier, _) {
              DrawerState drawerState = drawerFragmentNotifier.getState();
              return route(drawerState);
            },
          ),
        );
      },
    );
  }

  Widget route(DrawerState drawerState) {
    switch (drawerState) {
      case DrawerState.UserInfo:
        return UserInfoFragment();
      case DrawerState.CodeforcesUserInfo:
        return CodeforcesProfileFragment();
      case DrawerState.Contests:
        return ContestsFragment();
      default:
        return Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}

String getTitle(DrawerState drawerState) {
  switch (drawerState) {
    case DrawerState.UserInfo:
      return 'Home';
    case DrawerState.CodeforcesUserInfo:
      return 'Codeforces Profile';
    case DrawerState.Contests:
      return 'Contests';
    default:
      return 'Loading';
  }
}

enum DrawerState { UserInfo, CodeforcesUserInfo, Contests, Other }
