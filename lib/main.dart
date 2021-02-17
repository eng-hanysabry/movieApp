import 'package:flutter/material.dart';
import 'package:flutter_application_281/screens/SignIn.dart';
import 'package:flutter_application_281/screens/Signup.dart';
import 'package:flutter_application_281/screens/home.dart';


void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUp(),
    );
  }
}


