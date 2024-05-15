import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketa/src/pages/landing_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

String randomAssetImg() {
  Random rnd = new Random();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.1,
                0.3,
                0.6,
                0.9,
              ],
              colors: [
                Colors.black,
                Colors.indigo,
                Colors.blue,
                Colors.orange,
              ],
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
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 40, 10, 50),
                      child: Column(
                        children: [
                           Text(
                            "Register",
                            style: GoogleFonts.quicksand(textStyle:  const TextStyle(fontSize: 50)),
                          ),
                          const SizedBox(height: 20),
                          const TextField(
                            decoration: InputDecoration(
                                hintText: "Email", icon: Icon(Icons.alternate_email_sharp)),
                          ),
                          const SizedBox(height: 20),
                          const TextField(
                            decoration: InputDecoration(
                                hintText: "Username", icon: Icon(Icons.person)),
                          ),
                          const SizedBox(height: 20),
                          const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Password", icon: Icon(Icons.lock)),
                          ),
                          const SizedBox(height: 20),
                          const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Confirm Password", icon: Icon(Icons.lock)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LandingPage()),
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
    );
  }
}
