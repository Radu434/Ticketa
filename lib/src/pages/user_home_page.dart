import 'dart:html';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketa/src/pages/checkout_page.dart';
import 'package:ticketa/src/pages/profile_page.dart';

import '../models/event_model.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePage();
}

class _UserHomePage extends State<UserHomePage> {
  bool isLoading = true;
  late List<Event>? eventList;

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  void getEvents() async {
    setState(() => isLoading = true);

    eventList = await Event.getAll();
    setState(() => isLoading = false);
  }

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
                                      textStyle:
                                          const TextStyle(fontSize: 25)))),
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
                                      textStyle:
                                          const TextStyle(fontSize: 25)))),
                        ),
                        SizedBox(
                          height: double.maxFinite,
                          child: FilledButton(
                              onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfilePage()),
                                  ),
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
                                      textStyle:
                                          const TextStyle(fontSize: 25)))),
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
                                            textStyle: const TextStyle(
                                                fontSize: 25)))),
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
                                            textStyle: const TextStyle(
                                                fontSize: 25)))),
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
                                            textStyle: const TextStyle(
                                                fontSize: 25)))),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
            )),
        body: (!isLoading)
            ? Container(
                height: max(MediaQuery.of(context).size.height - 120, 600),
                width: max(MediaQuery.of(context).size.width, 600),
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
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: GridView.count(
                  crossAxisCount: MediaQuery.of(context).size.width > 1300
                      ? 4
                      : MediaQuery.of(context).size.width > 1000
                          ? 3
                          : MediaQuery.of(context).size.width > 700
                              ? 2
                              : 1,
                  children: List.generate(
                      eventList != null ? eventList!.length : 0, (index) {
                    return SizedBox(
                      height: 320,
                      width: 260,
                      child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                            )),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutPage(
                                    event: eventList!.elementAt(index))),
                          );
                        },
                        child: Container(
                          height: 320,
                          width: 260,
                          padding: const EdgeInsets.all(24),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 180,
                                  width: 240,
                                  child: FadeInImage(
                                      placeholder: const AssetImage(
                                          "assets/logos/logo1.png"),
                                      image: NetworkImage(eventList!
                                          .elementAt(index)
                                          .getPhoto()))),
                              const SizedBox(height: 10),
                              Text(
                                eventList!.elementAt(index).getName(),
                                style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                        fontSize: 25, color: Colors.black)),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                eventList!
                                    .elementAt(index)
                                    .getLocation()
                                    .toString(),
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(fontSize: 20)),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}

/*Container(
        height: max(MediaQuery.of(context).size.height - 120, 600),
        width: max(MediaQuery.of(context).size.width, 600),
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
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 1300
              ? 4
              : MediaQuery.of(context).size.width > 1000
                  ? 3
                  : MediaQuery.of(context).size.width > 700
                      ? 2
                      : 1,
          children: List.generate(20, (index) {
            return TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckoutPage()),
              ),
              child: Container(
                height: 320,
                width: 260,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                        height: 180,
                        width: 240,
                        child:
                            Image(image: AssetImage("assets/logos/logo1.png"))),
                    const SizedBox(height: 10),
                    Text(
                      'Event x y z',
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontSize: 30, color: Colors.black)),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Price: $index leu",
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),*/
