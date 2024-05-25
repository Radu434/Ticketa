import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketa/src/pages/admin_page.dart';
import 'package:ticketa/src/pages/login_page.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticketa',
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
            TargetPlatform.values,
            value: (dynamic _) => const OpenUpwardsPageTransitionsBuilder(), //applying old animation
          ),
        ),
      ),
      home: AdminPage() //loggedIn ? const UserHomePage() : const LoginPage(),
    );
  }
}
