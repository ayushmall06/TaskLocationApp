import 'package:flutter/material.dart';
import 'package:mytask/config/config.dart';
import 'package:mytask/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());

}

class MainApp extends StatefulWidget {


  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {










  @override
  Widget build(BuildContext context) {




    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        primaryColor: primaryColor,
        brightness: Brightness.dark
      ),
      darkTheme: ThemeData(
        primaryColor: primaryColor,
        brightness: Brightness.dark,
      ),
    );
  }
}

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
    );
  }
}

