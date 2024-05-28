import 'package:flutter/material.dart';
import 'package:ticketa/src/models/user_model.dart';
import 'package:ticketa/src/pages/user_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  static Future<bool> login(String email, String password, var context) async {
    User? loggedUser = await User.login(email, password);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (loggedUser != null) {
      prefs.setBool("loggedin", true);
      prefs.setString("userEmail", email);
      prefs.setInt("userId", loggedUser.getId() ?? -1);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserHomePage()),
      );
      return true;
    }
    return false;
  }

  static Future<bool> register(
      String email, String password, String username, var context) async {
    int result = await User.create(User(null, email, username, password));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (result != -1) {
      prefs.setBool("loggedin", true);
      prefs.setString("userEmail", email);
      prefs.setInt("userId", result);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserHomePage()),
      );
      return true;
    }
    return false;
  }
  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
