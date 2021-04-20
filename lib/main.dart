import 'package:codeforces_assistant/utils/ConnectivityService.dart';
import 'package:codeforces_assistant/services/RoutingService.dart';
import 'package:codeforces_assistant/utils/UserDataNotifier.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('${snapshot.error}');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return RouteBasedOnAuth(
            builder: (context, localUserSnapshot) {
              return StreamProvider<ConnectivityResult>.value(
                value: ConnectivityService().connectionStatusController.stream,
                initialData: null,
                child: ChangeNotifierProvider<UserDataNotifier>(
                  create: (_) => UserDataNotifier(),
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Codeforces Assistant',
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                    ),
                    home: RouteWidget(
                      currentUserSnapshot: localUserSnapshot,
                    ),
                  ),
                ),
              );
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}
