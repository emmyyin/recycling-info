import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:recycle_app/resources/database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: App(),
  ));
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("error");
          return Scaffold();
        }

        // Once complete, show application
        if (snapshot.connectionState == ConnectionState.done) {
          print("successful");
          return Scaffold();
        }

        return CircularProgressIndicator();
      },
    );
  }
}
