import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:recycle_app/ui/pages/search_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: ThemeApp(),
  ));
}

class ThemeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF83bc78),
        accentColor: Color(0xFFb178bc),
        textTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).textTheme
        )
      ),
      home: App(),
    );
  }
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
          return Scaffold(
            appBar: AppBar(
              title: Text("SorteraMera", style: TextStyle(fontSize: 26, color: Colors.white70),),
              centerTitle: true,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: SearchPage()
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}
