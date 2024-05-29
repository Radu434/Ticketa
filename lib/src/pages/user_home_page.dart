import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketa/src/authentication/auth_service.dart';
import 'package:ticketa/src/pages/checkout_page.dart';
import 'package:ticketa/src/pages/login_page.dart';
import 'package:ticketa/src/pages/profile_page.dart';
import 'package:ticketa/src/pages/user_tickets_page.dart';

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
    eventList!.sort((a,b)=>DateTime.parse(b.getDate()).compareTo(DateTime.parse(a.getDate())));
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Container(
              color: Colors.black,
              child:MediaQuery.of(context).size.width>700? Row(
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
                                    /*navigator to events page*/
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
                                Navigator.push(
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
                        SizedBox(
                          height: double.infinity,
                          child: FilledButton(
                              onPressed: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfilePage()),
                                  ),
                              style: ButtonStyle(
                                  backgroundColor:
                                  WidgetStateProperty.all(Colors.black),
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ))),
                              child: Text("My Profile",
                                  style: GoogleFonts.roboto(
                                      textStyle:
                                          const TextStyle(fontSize: 25)))),
                        ),
                        const Expanded(child: SizedBox()),
                        IconButton(
                            onPressed:  () {
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
                    ):
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Image(
                    image: AssetImage("logos/circularlogo.png"),
                  ),
                  SizedBox(width: 200,child: Column(
                   mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton(
                          onPressed: () => {
                            /*navigator to events page*/
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
                            /*navigator to user tickets page*/
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
                      FilledButton(
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ProfilePage()),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                              WidgetStateProperty.all(Colors.black),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ))),
                          child: Text("My Profile",
                              style: GoogleFonts.roboto(
                                  textStyle:
                                  const TextStyle(fontSize: 20)))),
                    ],
                  ),),
                  IconButton(
                      onPressed:  () {
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

            )),
        body: (!isLoading)
            ? Container(
                height: max(MediaQuery.of(context).size.height - 119, 600),
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
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                        final Color statusColor = DateTime.parse(eventList!.elementAt(index).getDate()).compareTo(DateTime.now())>=0? Colors.white:Colors.grey;
                    return Center(
                      child: Container(
                        height: 360,
                        width: 300,
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration:  BoxDecoration(
                            color:statusColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            )),
                        child: SingleChildScrollView(
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(statusColor),
                                shape: WidgetStateProperty.all(
                                    const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutPage(
                                        event: eventList!.elementAt(index))),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FadeInImage(
                                    height: 200,
                                    width: 300,
                                    placeholder: const AssetImage(
                                        "assets/logos/logo1.png"),
                                    image: NetworkImage(eventList!
                                        .elementAt(index)
                                        .getPhoto())),
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
                                      textStyle: const TextStyle(fontSize: 20,color: Colors.indigo)),
                                )
                              ],
                            ),
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


