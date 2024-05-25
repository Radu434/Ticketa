import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketa/src/authentication/auth_service.dart';
import 'package:ticketa/src/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

String randomAssetImg() {
  Random rnd = Random();
  int key = rnd.nextInt(3);
  String path = [
    "assets/party_stock_images/party1.jpg",
    "assets/party_stock_images/party2.jpg",
    "assets/party_stock_images/party3.jpg",
  ].elementAt(key);
  return path;
}

class _RegisterPage extends State<RegisterPage> {
  String imagePath = randomAssetImg();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  double x = 0.0;
  double y = 0.0;

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  bool validateEmail(String input) {
    if (input.isEmpty) {
      return true;
    }
    RegExp exp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (input.length > 6 && exp.hasMatch(input)) {
      return true;
    }
    return false;
  }

  bool validateUsername(String input) {
    if (input.isEmpty) {
      return true;
    }
    if (input.length > 6) {
      return true;
    }
    return false;
  }

  bool validatePassword(String input) {
    if (input.isEmpty) {
      return true;
    }
    RegExp exp = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$');
    if (input.length > 6 && exp.hasMatch(input)) {
      return true;
    }
    return false;
  }

  bool validateConfirmPassword(String password, String confirmedPassword) {
    if (password == confirmedPassword) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _updateLocation,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Container(
              color: Colors.black,
              child: const Row(
                children: [
                  SizedBox(width: 50),
                  Image(
                    image: AssetImage("assets/logos/circularlogo.png"),
                  )
                ],
              ),
            )),
        body: SingleChildScrollView(
          child: Container(
            height: max(MediaQuery.of(context).size.height - 120, 600),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: SweepGradient(
                startAngle: pi * 0.3,
                endAngle: pi * 1.9,
                colors: const [
                  Colors.blue,
                  Colors.indigo,
                  Colors.orange,
                  Colors.redAccent,
                  Colors.blue,
                ],
                stops: const <double>[0.0, 0.3, 0.5, 0.8, 1.0],
                center: Alignment(x / 5 / MediaQuery.of(context).size.width,
                    y / 2 / MediaQuery.of(context).size.height),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(

                        image: DecorationImage(
                            image: AssetImage(imagePath),
                            scale: 5,
                            fit: BoxFit.none),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 300,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0,0), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Join Ticketa",
                              style: GoogleFonts.quicksand(
                                  textStyle: const TextStyle(fontSize: 50)),
                            ),
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  errorText: validateEmail(_emailController.text)
                                      ? null
                                      : "Invalid Email",
                                  hintText: "Email",
                                  icon: const Icon(Icons.alternate_email_sharp)),
                              onChanged: (_) => setState(() {}),
                            ),
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                  errorText:
                                      validateUsername(_usernameController.text)
                                          ? null
                                          : "Username is too short",
                                  hintText: "Username",
                                  icon: const Icon(Icons.person)),
                              onChanged: (_) => setState(() {}),
                            ),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  errorText: validatePassword(
                                          _passwordController.text)
                                      ? null
                                      : "Must include a digit and an uppercase",
                                  hintText: "Password",
                                  icon: const Icon(Icons.lock)),
                              onChanged: (_) => setState(() {}),
                            ),
                            TextField(
                              obscureText: true,
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                  errorText: validateConfirmPassword(
                                          _passwordController.text,
                                          _confirmPasswordController.text)
                                      ? null
                                      : "Passwords do not match",
                                  hintText: "Confirm Password",
                                  icon: const Icon(Icons.lock)),
                              onChanged: (_) => setState(() {}),
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              child: FilledButton(
                                  onPressed: () async {
                                    if (validatePassword(
                                            _passwordController.text) &&
                                        validateUsername(
                                            _usernameController.text) &&
                                        validateEmail(_emailController.text) &&
                                        validateConfirmPassword(
                                            _passwordController.text,
                                            _confirmPasswordController.text)) {
                                      AuthenticationService.register(
                                          _emailController.text,
                                          _passwordController.text,
                                          _usernameController.text,
                                          this.context);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) => const AlertDialog(
                                                content:
                                                    Text("Invalid Credentials"),
                                              ));
                                    }
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(Colors.black),
                                      shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ))),
                                  child: Text("Register",
                                      style: GoogleFonts.roboto(
                                          textStyle:
                                              const TextStyle(fontSize: 16)))),
                            ),
                            TextButton(
                                onPressed: () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                    ),
                                child: const Text("Already registered? Log in"))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
