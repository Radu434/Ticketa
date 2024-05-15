import 'dart:math';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketa/src/pages/register_page.dart';
import 'package:ticketa/src/pages/user_home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPage();
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

class _LandingPage extends State<LandingPage> {
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
          height: max(MediaQuery
              .of(context)
              .size
              .height - 120, 500),
          width: MediaQuery
              .of(context)
              .size
              .width,
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
            ),),
          padding: const EdgeInsets.all(20),
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
                      fit: BoxFit.contain,),
                  ),
                  Container(
                    height: 500,
                    width: 300,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),


                      ),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 40, 10, 50),
                      child: Column(
                        children: [
                           Text(
                            "Welcome to Ticketa",
                            style: GoogleFonts.quicksand(textStyle:  const TextStyle(fontSize: 50)),
                          ),
                          const SizedBox(
                              height: 20
                          ),
                          const TextField(
                            decoration: InputDecoration(
                                hintText: "Username", icon: Icon(Icons.person)),
                          ),
                          const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Password", icon: Icon(Icons.lock)),
                          ),

                          const SizedBox(
                              height: 20
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: FilledButton(
                                onPressed: () =>
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (
                                          context) => const UserHomePage()),
                                    ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.black),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                        )
                                    )
                                ),
                                child: Text("Login",style: GoogleFonts.roboto(textStyle:const  TextStyle(fontSize: 16)))),
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          TextButton(
                              onPressed: () =>
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (
                                        context) => const RegisterPage()),
                                  ),
                              child: const Text("Not authenticated? Register"))
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
