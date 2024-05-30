import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketa/src/authentication/auth_service.dart';
import 'package:ticketa/src/models/user_model.dart';
import 'package:ticketa/src/pages/login_page.dart';
import 'package:ticketa/src/pages/user_home_page.dart';
import 'package:ticketa/src/pages/user_tickets_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Container(
              color: Colors.black,
              child: MediaQuery.of(context).size.width > 700
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(child: SizedBox()),
                        const Image(
                          image: AssetImage("logos/circularlogo.png"),
                        ),
                        SizedBox(
                          height: double.infinity,
                          child: FilledButton(
                              onPressed: () => {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const UserHomePage()),
                                ),
                                  },
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.black),
                                  shape: WidgetStateProperty.all<
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
                          height: double.infinity,
                          child: FilledButton(
                              onPressed: () => {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const UserTicketsPage()),
                                )
                                  },
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.black),
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ))),
                              child: Text("My Tickets",
                                  style: GoogleFonts.roboto(
                                      textStyle:
                                          const TextStyle(fontSize: 25)))),
                        ),
                        const Expanded(child: SizedBox()),
                        IconButton(
                            onPressed: () {
                              AuthenticationService.logout();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            icon: const Icon(
                              Icons.exit_to_app,
                              size: 60,
                              color: Colors.grey,
                            ))
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Image(
                          image: AssetImage("logos/circularlogo.png"),
                        ),
                        SizedBox(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FilledButton(
                                  onPressed: () => {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const UserHomePage()),
                                    ),
                                      },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(Colors.black),
                                      shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ))),
                                  child: Text("Find Events",
                                      style: GoogleFonts.roboto(
                                          textStyle:
                                              const TextStyle(fontSize: 20)))),
                              FilledButton(
                                  onPressed: () => {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const UserTicketsPage()),
                                    )
                                      },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(Colors.black),
                                      shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ))),
                                  child: Text("My Tickets",
                                      style: GoogleFonts.roboto(
                                          textStyle:
                                              const TextStyle(fontSize: 20)))),

                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              AuthenticationService.logout();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            icon: const Icon(
                              Icons.exit_to_app,
                              size: 60,
                              color: Colors.grey,
                            ))
                      ],
                    ))),
      body: SingleChildScrollView(
        child: Container(
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
                width: 100,
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
                width: 350,
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
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
                          textStyle: const TextStyle(fontSize: 25)),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                            hintText: "Username",
                            icon: Icon(Icons.person, size: 20)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            hintText: "New Email",
                            icon: Icon(Icons.alternate_email, size: 20)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "New Password",
                            icon: Icon(Icons.lock, size: 20)),
                      ),
                    ),

                    const Expanded(child: SizedBox()  ),

                    SizedBox(
                      width: 200,
                      child: FilledButton(
                          onPressed: () async{
                            final prefs = await SharedPreferences.getInstance();
                           int? id = prefs.getInt('userId');
                           if(id!=null){
                             User.update(id, User(null, _emailController.text, _usernameController.text, _passwordController.text));
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
                          child: Text("Confirm Changes",
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(fontSize: 16)))),
                    ),
                    const SizedBox(height: 20),

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
      ),
    );
  }
}
