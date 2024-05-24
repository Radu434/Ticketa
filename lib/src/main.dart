import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketa/src/pages/login_page.dart';
import 'package:ticketa/src/pages/register_page.dart';
import 'package:ticketa/src/pages/user_home_page.dart';

bool loggedIn = false;

Future<void> checkIfLoggedIn() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool("loggedin") == true) {
    loggedIn = true;
  } else {
    loggedIn = false;
  }
}

void main() {
  checkIfLoggedIn();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticketa',
      home: loggedIn ? const UserHomePage() : const LoginPage(),
    );
  }
}
