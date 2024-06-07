import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketa/src/models/event_model.dart';
import 'package:ticketa/src/models/ticket_model.dart';
import 'package:ticketa/src/models/transaction_model.dart';
import 'package:ticketa/src/pages/user_tickets_page.dart';

class CheckoutPage extends StatefulWidget {
  final Event event;

  const CheckoutPage({super.key, required this.event});

  @override
  State<CheckoutPage> createState() => _CheckoutPage();
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

class _CheckoutPage extends State<CheckoutPage> {
  int? selectedTicketId;
  bool expired = false;

  Future<List<Ticket>?> getTickets() async {
    return await Ticket.getAllByEventId(widget.event.getId()!);
  }

  @override
  void initState() {
    super.initState();
    getTickets();
    DateTime.parse(widget.event.getDate()).compareTo(DateTime.now()) >= 0
        ? expired = false
        : expired = true;
  }

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
          height: max(MediaQuery.of(context).size.height - 120, 500),
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
                    child: Container(
                      height: 300,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
                      child: Column(
                        children: [
                          FadeInImage(
                              placeholder:
                                  const AssetImage("assets/logos/logo1.png"),
                              image: NetworkImage(widget.event.getPhoto())),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            widget.event.getName(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(widget.event.getDate().toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20))
                        ],
                      ),
                    ),
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
                      padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                      child: Column(
                        children: [
                          Text(
                            "Fun is just one click away!",
                            style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(fontSize: 30)),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 160,
                            child: Text(
                              widget.event.getDescription(),
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(fontSize: 20)),
                            ),
                          ),
                          FutureBuilder<List<Ticket>?>(
                              future: getTickets(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                return DropdownButton(
                                  items: snapshot.data!
                                      .map<DropdownMenuItem<int>>(
                                          (Ticket element) {
                                    return DropdownMenuItem<int>(
                                      value: element.getId(),
                                      child: Text(
                                          "${element.getType()!} ${element.getPrice().toStringAsPrecision(4)} Ron"),
                                    );
                                  }).toList(),
                                  value: selectedTicketId,
                                  onChanged: (int? value) {
                                    setState(() {
                                      selectedTicketId = value;
                                    });
                                  },
                                  hint: const Text("Ticket type"),
                                );
                              }),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.maxFinite,
                            child: FilledButton(
                                onPressed: () async {
                                  if (!expired) {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    int? userId = prefs.getInt('userId');
                                    if (userId != null &&
                                        selectedTicketId != null) {
                                      Transaction.create(Transaction(
                                          null, userId, selectedTicketId!, ""));
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const UserTicketsPage()),
                                        );
                                    }
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => const AlertDialog(
                                          alignment: Alignment.center,
                                              content:
                                                  Text("Expired Event, cannot purhcase"),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.paypal,
                                      size: 20,
                                    ),
                                    Text("Purchase",
                                        style: GoogleFonts.roboto(
                                            textStyle:
                                                const TextStyle(fontSize: 20))),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.keyboard_backspace,
                              size: 60,
                            ),
                          )
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
