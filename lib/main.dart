import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loader_overlay/loader_overlay.dart';
// screens
import 'package:project_NVCTI/screens/onboarding.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {

     return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return somethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return new MaterialApp(
              title: 'Project NVCTI',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(fontFamily: 'Montserrat'),
              home: LoaderOverlay(
                useDefaultLoading: true,
                overlayColor: Colors.orangeAccent,
                overlayOpacity: 0.8,
                child: Onboarding(),
              ),

          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return loading();
      },
    );


  }

  Widget loading(){
    return  MaterialApp(
        title: "Project_NVCTI",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Montserrat'),
        home : Text("loading wait..."),
    );
  }

  Widget somethingWentWrong(){
   return  MaterialApp(
      title: "Project_NVCTI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home : Text("Sorry something went wrong"),
    );

  }

}
