import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketa/src/authentication/auth_service.dart';
import 'package:ticketa/src/models/ticket_model.dart';
import 'package:ticketa/src/models/transaction_model.dart';
import 'package:ticketa/src/pages/login_page.dart';
import 'package:ticketa/src/pages/profile_page.dart';
import 'package:ticketa/src/pages/user_home_page.dart';
import 'package:ticketa/src/pages/view_ticket_page.dart';

import '../models/event_model.dart';

class UserTicketsPage extends StatefulWidget {
  const UserTicketsPage({super.key});

  @override
  State<UserTicketsPage> createState() => _UserTicketsPage();
}

class _UserTicketsPage extends State<UserTicketsPage> {
  bool isLoading = true;

  late List<Transaction>? transactionList;
  late int userId;

  @override
  void initState() {
    super.initState();
    getTansactions();
  }

  void getTansactions() async {
    setState(() => isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('userId');
    transactionList = await Transaction.getByUserId(id ?? -1);
    transactionList!
        .sort((a, b) => (b.getId() ?? 1).compareTo(a.getId() ?? -1));

    setState(() {
      isLoading = false;
      userId = id ?? -1;
    });
  }

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
                                onPressed: () {
                                  setState(() {});
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
                              mainAxisAlignment: MainAxisAlignment.end,
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
                                            WidgetStateProperty.all(
                                                Colors.black),
                                        shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                            const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ))),
                                    child: Text("Find Events",
                                        style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                                fontSize: 20)))),
                                FilledButton(
                                    onPressed: () => {
                                          /*navigator to user tickets page*/
                                        },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.black),
                                        shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                            const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ))),
                                    child: Text("My Tickets",
                                        style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                                fontSize: 20)))),
                                FilledButton(
                                    onPressed: () => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProfilePage()),
                                        ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.black),
                                        shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                            const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ))),
                                    child: Text("My Profile",
                                        style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                                fontSize: 20)))),
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
                    transactionList != null ? transactionList!.length : 0,
                    (index) {
                      return FutureBuilder<Ticket?>(
                        future: Ticket.getById(
                            transactionList!.elementAt(index).getTicketId()),
                        builder: (context, ticketSnapshot) {
                          if (ticketSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (ticketSnapshot.hasError) {
                            return Center(
                                child: Text('Error: ${ticketSnapshot.error}'));
                          } else {
                            Ticket ticket = ticketSnapshot.data!;
                            return FutureBuilder<Event?>(
                              future: Event.getById(ticket.getEventId()),
                              builder: (context, eventSnapshot) {
                                if (eventSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (eventSnapshot.hasError) {
                                  return Center(
                                      child: Text(
                                          'Error: ${eventSnapshot.error}'));
                                } else {
                                  Event event = eventSnapshot.data!;
                                  return Center(
                                    child: Container(
                                      height: 360,
                                      width: 300,
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                      child: SingleChildScrollView(
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.white),
                                            shape: WidgetStateProperty.all(
                                              const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16)),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewTicketPage(
                                                        event: event,
                                                        ticket: ticket,
                                                        transaction:
                                                            transactionList!
                                                                .elementAt(
                                                                    index)),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              FadeInImage(
                                                height: 200,
                                                width: 300,
                                                placeholder: const AssetImage(
                                                    "assets/logos/logo1.png"),
                                                image: NetworkImage(
                                                    event.getPhoto()),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                event.getName(),
                                                style: GoogleFonts.quicksand(
                                                  textStyle: const TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                ticket.getType() ?? "Standard",
                                                style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.indigo),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                event.getDate(),
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      fontSize: 20,
                                                      color: DateTime.parse(event
                                                                      .getDate())
                                                                  .compareTo(
                                                                      DateTime
                                                                          .now()) >=
                                                              0
                                                          ? Colors.green
                                                          : Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
                ))
            : Center(
                child: FilledButton(
                    onPressed: () => {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserHomePage()),
                          ),
                        },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.black),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ))),
                    child: Text("Find Events",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(fontSize: 20)))),
              ));
  }
}
