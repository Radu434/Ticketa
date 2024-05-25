import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketa/src/models/event_model.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPage();
}

class _AdminPage extends State<AdminPage> {
  Future<List<Event>?> getEvents() async {
    return await Event.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Image(
                  image: AssetImage("assets/logos/circularlogo.png"),
                ),
                Text(
                  "Admin Dashboard",
                  style: GoogleFonts.roboto(fontSize: 24, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.exit_to_app,
                      size: 60,
                      color: Colors.grey,
                    ))
              ],
            ),
          )),
      body: Container(
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
              Colors.grey,
              Colors.red,
              Colors.black,
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: MediaQuery.of(context).size.width > 1260
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 160,
                        width: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.width
                            : 600,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: FutureBuilder<List<Event>?>(
                            future: getEvents(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return Column(
                                children: [
                                  Container(
                                    height: 40,
                                    alignment: Alignment.bottomCenter,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(14),
                                          topRight: Radius.circular(14)),
                                    ),
                                    child: const Text(
                                      "Edit or remove events",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height -
                                            200,
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                    child: ListView.builder(
                                      itemCount: 500,
                                      itemBuilder: (context, position) {
                                        return Card(
                                          child: Container(
                                            padding:
                                                const EdgeInsets.all(16.0),
                                            height: 120,
                                            child: Row(
                                              children: [
                                                const Image(
                                                    image: AssetImage(
                                                        "logos/circularlogo.png")),
                                                Text(
                                                  position.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 22.0),
                                                ),
                                                const Expanded(
                                                  child: SizedBox(),
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      size: 40,
                                                    )),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.delete_sharp,
                                                      size: 40,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 160,
                        width: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.width
                            : 600,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 160,
                        width: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.width
                            : 600,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: FutureBuilder<List<Event>?>(
                            future: getEvents(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return Column(
                                children: [
                                  Container(
                                    height: 40,
                                    alignment: Alignment.bottomCenter,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(14),
                                          topRight: Radius.circular(14)),
                                    ),
                                    child: const Text(
                                      "Edit or remove events",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height -
                                            200,
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                    child: ListView.builder(
                                      itemCount: 500,
                                      itemBuilder: (context, position) {
                                        return Card(
                                          child: Container(
                                            padding:
                                                const EdgeInsets.all(16.0),
                                            height: 120,
                                            child: Row(
                                              children: [
                                                const Image(
                                                    image: AssetImage(
                                                        "logos/circularlogo.png")),
                                                Text(
                                                  position.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 22.0),
                                                ),
                                                const Expanded(
                                                  child: Text(""),
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      size: 40,
                                                    )),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.delete_sharp,
                                                      size: 40,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(height: 60),
                      Container(
                        height: MediaQuery.of(context).size.height - 160,
                        width: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.width
                            : 600,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
