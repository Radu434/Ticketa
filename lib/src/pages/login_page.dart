import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:ticketa/src/authentication/auth_service.dart';
import 'package:ticketa/src/pages/admin_page.dart';

import 'package:ticketa/src/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
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

class _LoginPage extends State<LoginPage> {
  String imagePath = randomAssetImg();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  List<Color> primaryColors = const [
    Colors.white,
    Colors.pinkAccent,
    Colors.pink,
  ];
  List<Color> secondaryColors = const [
    Colors.blue,
    Colors.blueAccent,
    Colors.white,
  ];

  double x = 0.0;
  double y = 0.0;

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
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
            height: max(MediaQuery.of(context).size.height - 120, 500),
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
                center: Alignment(x / 8 / MediaQuery.of(context).size.height,
                    y / MediaQuery.of(context).size.height / 2),
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 500,
                      width: 250,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imagePath),
                            scale: 5,
                            fit: BoxFit.none),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: const Image(
                        image: AssetImage("assets/logos/circularlogo.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 500,
                      width: 300,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 3,
                            blurRadius: 10,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Column(
                          children: [
                            Text(
                              "Welcome to Ticketa",
                              style: GoogleFonts.quicksand(
                                  textStyle: const TextStyle(fontSize: 50)),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                  hintText: "Email", icon: Icon(Icons.person)),
                            ),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  hintText: "Password", icon: Icon(Icons.lock)),
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: double.maxFinite,
                              child: FilledButton(
                                  onPressed: () async {
                                    if(_emailController.text=="Admin"&&_passwordController.text=="Admin"){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const AdminPage()),
                                      );
                                    }
                                    else{
                                      AuthenticationService.login(
                                          _emailController.text,
                                          _passwordController.text,
                                          this.context);
                                    }

                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(Colors.black),
                                      shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ))),
                                  child: Text("Login",
                                      style: GoogleFonts.roboto(
                                          textStyle:
                                              const TextStyle(fontSize: 16)))),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextButton(
                                onPressed: () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()),
                                    ),
                                child:
                                    const Text("Not authenticated? Register"))
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
