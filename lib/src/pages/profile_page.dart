import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketa/src/pages/checkout_page.dart';
import 'package:ticketa/src/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}
//TODO Create page to check own tickets and add this page as a submenu
class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Container(
            color: Colors.black,
            child: MediaQuery.of(context).size.width > 800
                ? Row(
                    children: [
                      const SizedBox(width: 50),
                      const Image(
                        image: AssetImage("assets/logos/circularlogo.png"),
                      ),
                      const SizedBox(width: 50),
                      SizedBox(
                        height: double.maxFinite,
                        child: FilledButton(
                            onPressed: () => {
                                  /*navigator to events page*/
                                },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ))),
                            child: Text("Find Events",
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(fontSize: 25)))),
                      ),
                      SizedBox(
                        height: double.maxFinite,
                        child: FilledButton(
                            onPressed: () => {
                                  /*navigator to user tickets page*/
                                },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ))),
                            child: Text("My Tickets",
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(fontSize: 25)))),
                      ),
                      SizedBox(
                        height: double.maxFinite,
                        child: FilledButton(
                            onPressed: () => {
                                  /*navigator to user profile page*/
                                },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ))),
                            child: Text("My Profile",
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(fontSize: 25)))),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      const Image(
                        image: AssetImage("assets/logos/circularlogo.png"),
                      ),
                      const SizedBox(width: 30),
                      Drawer(
                        backgroundColor: Colors.black,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            SizedBox(
                              width: 300,
                              child: FilledButton(
                                  onPressed: () => {
                                        /*navigator to events page*/
                                      },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ))),
                                  child: Text("Find Events",
                                      style: GoogleFonts.roboto(
                                          textStyle:
                                              const TextStyle(fontSize: 25)))),
                            ),
                            SizedBox(
                              width: 300,
                              child: FilledButton(
                                  onPressed: () => {
                                        /*navigator to user tickets page*/
                                      },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ))),
                                  child: Text("My Tickets",
                                      style: GoogleFonts.roboto(
                                          textStyle:
                                              const TextStyle(fontSize: 25)))),
                            ),
                            SizedBox(
                              width: 300,
                              child: FilledButton(
                                  onPressed: () => {
                                        /*navigator to user profile page*/
                                      },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ))),
                                  child: Text("My Profile",
                                      style: GoogleFonts.roboto(
                                          textStyle:
                                              const TextStyle(fontSize: 25)))),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          )),
      body: Container(
        height: max(MediaQuery.of(context).size.height - 120, 600),
        width: max(MediaQuery.of(context).size.width, 600),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
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
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 500,
              width: 150,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
            Container(
              height: 500,
              width: 400,
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 50),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "My Profile",
                    style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Username",
                          icon: Icon(Icons.person, size: 20)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: 300,
                    child: TextField(
                      obscureText: true,

                      decoration: InputDecoration(
                          hintText: "Old Password",
                          icon: Icon(Icons.lock, size: 20)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: 300,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "New Password",
                          icon: Icon(Icons.lock, size: 20)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 200,
                    child: FilledButton(
                        onPressed: () => Navigator.pop(context),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ))),
                        child: Text("Confirm Changes",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(fontSize: 16)))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.keyboard_backspace,
                      size: 60,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
