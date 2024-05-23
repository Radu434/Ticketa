import 'dart:html';
import 'dart:math';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketa/src/models/event_model.dart';
import 'package:ticketa/src/models/ticket_model.dart';

import 'package:ticketa/src/pages/user_home_page.dart';

class CheckoutPage extends StatefulWidget {
  final Event event;

  const CheckoutPage({super.key, required this.event});

  @override
  State<CheckoutPage> createState() => _CheckoutPage();
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

class _CheckoutPage extends State<CheckoutPage> {
  double ticketPrice = 0;
  bool priceLoaded = false;

  void getPrice() async {
    priceLoaded = false;

    Ticket? ticket = await Ticket.getByEventId(widget.event.getId()!);
    setState(() {
      priceLoaded = true;
      ticketPrice = ticket!.getPrice();
    });
  }

  @override
  void initState() {
    getPrice();

    super.initState();
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
                          Text(
                            priceLoaded ? "Price :$ticketPrice lei" : "",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(fontSize: 20)),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.maxFinite,
                            child: FilledButton(
                                onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const UserHomePage()),
                                    ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                    shape: MaterialStateProperty.all<
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
