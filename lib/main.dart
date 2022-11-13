import 'package:flutter/material.dart';
import './screens/welcomescreen.dart';
import './screens/chatscreen.dart';
import './screens/loginscreen.dart';
import './screens/signinscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/awesomedialogescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chatapp',
      theme: ThemeData(),
      // home: Welcomescreen(),
      initialRoute: Welcomescreen.screenRoute,
      routes: {
        Welcomescreen.screenRoute: (context) => Welcomescreen(),
        Signinscreen.screenRoute: (context) => Signinscreen(),
        Chatscreen.screenRoute: (context) => Chatscreen(),
        Loginscreen.screenRoute: (context) => Loginscreen(),
        awesomeee.screenRoute: (context) => awesomeee()
      },
    );
  }
}
