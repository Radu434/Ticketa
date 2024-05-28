import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketa/src/authentication/auth_service.dart';
import 'package:ticketa/src/database/free_image_host_uploader.dart';
import 'package:ticketa/src/models/event_model.dart';
import 'package:ticketa/src/models/ticket_model.dart';
import 'package:ticketa/src/pages/edit_event_page.dart';
import 'package:ticketa/src/pages/login_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPage();
}

class _AdminPage extends State<AdminPage> {
  final _searchController = TextEditingController();
  final _eventNameController = TextEditingController();
  final _eventLocationController = TextEditingController();
  final _eventDescriptionController = TextEditingController();
  final _ticketTypeController = TextEditingController();
  final _ticketPriceController = TextEditingController();

  late DropzoneViewController _controller;
  dynamic eventImage;
  String imageUrl = "";
  Color dropZoneAccent = Colors.blueAccent;
  DateTime _selectedDate = DateTime.now();
  String _dateButtonText = "Pick a date";
  List<Ticket?> ticketList = [];

  Future<List<Event>?> getEvents() async {
    return await Event.getAll();
  }

  Future<dynamic> loadImage(dynamic image) async {
    final bytes = await _controller.getFileData(image);
    final url = await _controller.createFileUrl(image);
    final mime = await _controller.getFileMIME(image);
    if (mime.contains("image")) {
      setState(() {
        eventImage = bytes;
        imageUrl = url;
      });
    } else {
      setState(() {
        dropZoneAccent = Colors.red;
      });
    }

    return image;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateButtonText =
            '${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}';
      });
    }
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
            ),
          )),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: MediaQuery.of(context).size.width > 1260
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            height: 40,
                            width: MediaQuery.of(context).size.width < 600
                                ? MediaQuery.of(context).size.width
                                : 600,
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.circular(14)),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {});
                              },
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.grey,
                              decoration: const InputDecoration(
                                iconColor: Colors.white,
                                icon: Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                hintText: "Search Event",
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height - 200,
                            width: MediaQuery.of(context).size.width < 600
                                ? MediaQuery.of(context).size.width
                                : 600,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16)),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height - 200,
                              padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
                              child: FutureBuilder<List<Event>?>(
                                  future: getEvents(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState !=
                                        ConnectionState.done) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                    return ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          color: Colors.grey.shade900,
                                          child: snapshot.data!
                                                  .elementAt(index)
                                                  .getName()
                                                  .contains(
                                                      _searchController.text)
                                              ? Container(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  height: 120,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6))),
                                                        child: Image(
                                                            fit:
                                                                BoxFit.fitWidth,
                                                            image: NetworkImage(
                                                                snapshot.data!
                                                                    .elementAt(
                                                                        index)
                                                                    .getPhoto())),
                                                      ),
                                                      const SizedBox(width: 20),
                                                      Expanded(
                                                        child: Text(
                                                          snapshot.data!
                                                              .elementAt(index)
                                                              .getName(),
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      22.0),
                                                          softWrap: true,
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () =>
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        EditEventPage(
                                                                            id: snapshot.data!.elementAt(index).getId() ??
                                                                                -1)),
                                                              ),
                                                          icon: const Icon(
                                                            color: Colors.white,
                                                            Icons.edit,
                                                            size: 40,
                                                          )),
                                                      IconButton(
                                                          onPressed: () {
                                                            Event.delete(
                                                                snapshot.data!
                                                                    .elementAt(
                                                                        index)
                                                                    .getId());
                                                            setState(() {});
                                                          },
                                                          icon: const Icon(
                                                            color: Colors.white,
                                                            Icons.delete_sharp,
                                                            size: 40,
                                                          ))
                                                    ],
                                                  ),
                                                )
                                              : null,
                                        );
                                      },
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 160,
                        width: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.width
                            : 600,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DottedBorder(
                                    color: dropZoneAccent,
                                    child: SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: Stack(
                                        children: [
                                          DropzoneView(
                                            onCreated: (controller) =>
                                                this._controller = controller,
                                            onDrop: (param) {
                                              loadImage(param);
                                            },
                                            onHover: () {
                                              setState(() {
                                                dropZoneAccent = Colors.green;
                                              });
                                            },
                                            onLeave: () {
                                              setState(() {
                                                dropZoneAccent =
                                                    Colors.blueAccent;
                                              });
                                            },
                                            onError: (error) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const AlertDialog(
                                                        content: Text(
                                                            "Invalid File"),
                                                      ));
                                            },
                                          ),
                                          Image.network(
                                            imageUrl,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.cloud_upload,
                                                        size: 80,
                                                        color: dropZoneAccent),
                                                    const Text(
                                                        "Drop Image Here")
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 230,
                                    height: 200,
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: _eventNameController,
                                          textAlign: TextAlign.start,
                                          keyboardType: TextInputType.text,
                                          maxLength: 40,
                                          decoration: InputDecoration(
                                            hintText: 'Event Name',
                                            hintStyle:
                                                const TextStyle(fontSize: 16),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                  width: 10,
                                                  style: BorderStyle.solid,
                                                  color: Colors.black),
                                            ),
                                            filled: true,
                                            contentPadding:
                                                const EdgeInsets.all(6),
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                        TextField(
                                          controller: _eventLocationController,
                                          textAlign: TextAlign.start,
                                          keyboardType: TextInputType.text,
                                          maxLength: 40,
                                          decoration: InputDecoration(
                                            hintText: 'Event Location',
                                            hintStyle:
                                                const TextStyle(fontSize: 16),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                  width: 10,
                                                  style: BorderStyle.solid,
                                                  color: Colors.black),
                                            ),
                                            filled: true,
                                            contentPadding:
                                                const EdgeInsets.all(6),
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              _selectDate(context);
                                            },
                                            style: const ButtonStyle(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                    Icons.calendar_month),
                                                Text(_dateButtonText),
                                              ],
                                            ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _eventDescriptionController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                maxLength: 280,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Event Description',
                                  hintStyle: const TextStyle(fontSize: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        width: 10,
                                        style: BorderStyle.solid,
                                        color: Colors.black),
                                  ),
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(6),
                                  fillColor: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: TextField(
                                        controller: _ticketTypeController,
                                        textAlign: TextAlign.start,
                                        keyboardType: TextInputType.text,
                                        maxLength: 50,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          hintText: 'Ticket Type',
                                          hintStyle:
                                              const TextStyle(fontSize: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: const BorderSide(
                                                width: 10,
                                                style: BorderStyle.solid,
                                                color: Colors.black),
                                          ),
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.all(6),
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: TextField(
                                        controller: _ticketPriceController,
                                        textAlign: TextAlign.start,
                                        keyboardType: TextInputType.text,
                                        maxLength: 50,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          hintText: 'Ticket Price',
                                          hintStyle:
                                              const TextStyle(fontSize: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: const BorderSide(
                                                width: 10,
                                                style: BorderStyle.solid,
                                                color: Colors.black),
                                          ),
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.all(6),
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      height: 40,
                                      child: ElevatedButton(
                                        style: const ButtonStyle(
                                            alignment: Alignment.center),
                                        onPressed: () {
                                          if (!ticketList.any((item) =>
                                                  item!.getType() ==
                                                  _ticketTypeController.text) &&
                                              _ticketPriceController
                                                  .text.isNotEmpty &&
                                              _ticketTypeController
                                                  .text.isNotEmpty) {
                                            ticketList.add(Ticket(
                                                null,
                                                0,
                                                double.parse(
                                                    _ticketPriceController
                                                        .text),
                                                _ticketTypeController.text));
                                            _ticketPriceController.clear();
                                            _ticketTypeController.clear();
                                            setState(() {});
                                          }
                                        },
                                        child: const Text("Add Ticket"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6))),
                                    child: ListView.builder(
                                      itemCount: ticketList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          title: Container(
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                  "${ticketList.elementAt(index)!.getType()} ${ticketList.elementAt(index)!.getPrice()} Ron")),
                                          trailing: ElevatedButton(
                                            onPressed: () {
                                              ticketList.removeAt(index);
                                              setState(() {});
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.red),
                                            ),
                                            child: const Icon(
                                              Icons.delete_forever,
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_eventNameController
                                                .text.isNotEmpty &&
                                            _eventLocationController
                                                .text.isNotEmpty &&
                                            _eventDescriptionController
                                                .text.isNotEmpty &&
                                            imageUrl.isNotEmpty) {
                                          String link =
                                              await FreeImageHostUploader
                                                  .upload(eventImage);
                                          final id = await Event.create(Event(
                                              null,
                                              _eventNameController.text,
                                              _eventLocationController.text,
                                              _selectedDate.toString(),
                                              _eventDescriptionController.text,
                                              link));

                                          if (id != null && id != -1) {
                                            ticketList.forEach((ticket) {
                                              if (ticket != null) {
                                                Ticket.create(Ticket(
                                                    null,
                                                    id,
                                                    ticket.getPrice(),
                                                    ticket.getType()));
                                              }
                                              ;
                                            });
                                          }
                                          _eventNameController.clear();
                                          _eventLocationController.clear();
                                          _eventDescriptionController.clear();
                                          ticketList.clear();

                                          setState(() {
                                            imageUrl = "";
                                            eventImage = null;
                                            dropZoneAccent = Colors.blueAccent;
                                            _selectedDate = DateTime.now();
                                            _dateButtonText = "Pick a date";
                                          });
                                        }
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.green),
                                          shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ))),
                                      child: const Text(
                                        "Create Event",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            height: 40,
                            width: MediaQuery.of(context).size.width < 600
                                ? MediaQuery.of(context).size.width
                                : 600,
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.circular(14)),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {});
                              },
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.grey,
                              decoration: const InputDecoration(
                                iconColor: Colors.white,
                                icon: Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                hintText: "Search Event",
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height - 200,
                            width: MediaQuery.of(context).size.width < 600
                                ? MediaQuery.of(context).size.width
                                : 600,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16)),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height - 200,
                              padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
                              child: FutureBuilder<List<Event>?>(
                                  future: getEvents(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState !=
                                        ConnectionState.done) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                    return ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          color: Colors.grey.shade900,
                                          child: snapshot.data!
                                                  .elementAt(index)
                                                  .getName()
                                                  .contains(
                                                      _searchController.text)
                                              ? Container(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  height: 120,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6))),
                                                        child: Image(
                                                            fit:
                                                                BoxFit.fitWidth,
                                                            image: NetworkImage(
                                                                snapshot.data!
                                                                    .elementAt(
                                                                        index)
                                                                    .getPhoto())),
                                                      ),
                                                      const SizedBox(width: 20),
                                                      Expanded(
                                                        child: Text(
                                                          snapshot.data!
                                                              .elementAt(index)
                                                              .getName(),
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      22.0),
                                                          softWrap: true,
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () =>
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        EditEventPage(
                                                                            id: snapshot.data!.elementAt(index).getId() ??
                                                                                -1)),
                                                              ),
                                                          icon: const Icon(
                                                            color: Colors.white,
                                                            Icons.edit,
                                                            size: 40,
                                                          )),
                                                      IconButton(
                                                          onPressed: () {
                                                            Event.delete(
                                                                snapshot.data!
                                                                    .elementAt(
                                                                        index)
                                                                    .getId());
                                                            setState(() {});
                                                          },
                                                          icon: const Icon(
                                                            color: Colors.white,
                                                            Icons.delete_sharp,
                                                            size: 40,
                                                          ))
                                                    ],
                                                  ),
                                                )
                                              : null,
                                        );
                                      },
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: MediaQuery.of(context).size.height - 160,
                        width: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.width
                            : 600,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DottedBorder(
                                    color: dropZoneAccent,
                                    child: SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: Stack(
                                        children: [
                                          DropzoneView(
                                            onCreated: (controller) =>
                                                this._controller = controller,
                                            onDrop: (param) {
                                              loadImage(param);
                                            },
                                            onHover: () {
                                              setState(() {
                                                dropZoneAccent = Colors.green;
                                              });
                                            },
                                            onLeave: () {
                                              setState(() {
                                                dropZoneAccent =
                                                    Colors.blueAccent;
                                              });
                                            },
                                            onError: (error) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const AlertDialog(
                                                        content: Text(
                                                            "Invalid File"),
                                                      ));
                                            },
                                          ),
                                          Image.network(
                                            imageUrl,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.cloud_upload,
                                                        size: 80,
                                                        color: dropZoneAccent),
                                                    const Text(
                                                        "Drop Image Here")
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 230,
                                    height: 200,
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: _eventNameController,
                                          textAlign: TextAlign.start,
                                          keyboardType: TextInputType.text,
                                          maxLength: 40,
                                          decoration: InputDecoration(
                                            hintText: 'Event Name',
                                            hintStyle:
                                                const TextStyle(fontSize: 16),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                  width: 10,
                                                  style: BorderStyle.solid,
                                                  color: Colors.black),
                                            ),
                                            filled: true,
                                            contentPadding:
                                                const EdgeInsets.all(6),
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                        TextField(
                                          controller: _eventLocationController,
                                          textAlign: TextAlign.start,
                                          keyboardType: TextInputType.text,
                                          maxLength: 40,
                                          decoration: InputDecoration(
                                            hintText: 'Event Location',
                                            hintStyle:
                                                const TextStyle(fontSize: 16),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                  width: 10,
                                                  style: BorderStyle.solid,
                                                  color: Colors.black),
                                            ),
                                            filled: true,
                                            contentPadding:
                                                const EdgeInsets.all(6),
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              _selectDate(context);
                                            },
                                            style: const ButtonStyle(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                    Icons.calendar_month),
                                                Text(_dateButtonText),
                                              ],
                                            ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _eventDescriptionController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                maxLength: 280,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Event Description',
                                  hintStyle: const TextStyle(fontSize: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        width: 10,
                                        style: BorderStyle.solid,
                                        color: Colors.black),
                                  ),
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(6),
                                  fillColor: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: TextField(
                                        controller: _ticketTypeController,
                                        textAlign: TextAlign.start,
                                        keyboardType: TextInputType.text,
                                        maxLength: 50,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          hintText: 'Ticket Type',
                                          hintStyle:
                                              const TextStyle(fontSize: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: const BorderSide(
                                                width: 10,
                                                style: BorderStyle.solid,
                                                color: Colors.black),
                                          ),
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.all(6),
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: TextField(
                                        controller: _ticketPriceController,
                                        textAlign: TextAlign.start,
                                        keyboardType: TextInputType.text,
                                        maxLength: 50,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          hintText: 'Ticket Price',
                                          hintStyle:
                                              const TextStyle(fontSize: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: const BorderSide(
                                                width: 10,
                                                style: BorderStyle.solid,
                                                color: Colors.black),
                                          ),
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.all(6),
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      height: 40,
                                      child: ElevatedButton(
                                        style: const ButtonStyle(
                                            alignment: Alignment.center),
                                        onPressed: () {
                                          if (!ticketList.any((item) =>
                                                  item!.getType() ==
                                                  _ticketTypeController.text) &&
                                              _ticketPriceController
                                                  .text.isNotEmpty &&
                                              _ticketTypeController
                                                  .text.isNotEmpty) {
                                            ticketList.add(Ticket(
                                                null,
                                                0,
                                                double.parse(
                                                    _ticketPriceController
                                                        .text),
                                                _ticketTypeController.text));
                                            _ticketPriceController.clear();
                                            _ticketTypeController.clear();
                                            setState(() {});
                                          }
                                        },
                                        child: const Text("Add Ticket"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6))),
                                    child: ListView.builder(
                                      itemCount: ticketList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          title: Container(
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                  "${ticketList.elementAt(index)!.getType()} ${ticketList.elementAt(index)!.getPrice()} Ron")),
                                          trailing: ElevatedButton(
                                            onPressed: () {
                                              ticketList.removeAt(index);
                                              setState(() {});
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.red),
                                            ),
                                            child: const Icon(
                                              Icons.delete_forever,
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_eventNameController
                                                .text.isNotEmpty &&
                                            _eventLocationController
                                                .text.isNotEmpty &&
                                            _eventDescriptionController
                                                .text.isNotEmpty &&
                                            imageUrl.isNotEmpty) {
                                          String link =
                                              await FreeImageHostUploader
                                                  .upload(eventImage);
                                          final id = await Event.create(Event(
                                              null,
                                              _eventNameController.text,
                                              _eventLocationController.text,
                                              _selectedDate.toString(),
                                              _eventDescriptionController.text,
                                              link));

                                          if (id != null && id != -1) {
                                            ticketList.forEach((ticket) {
                                              if (ticket != null) {
                                                Ticket.create(Ticket(
                                                    null,
                                                    id,
                                                    ticket.getPrice(),
                                                    ticket.getType()));
                                              }
                                              ;
                                            });
                                          }
                                          _eventNameController.clear();
                                          _eventLocationController.clear();
                                          _eventDescriptionController.clear();
                                          ticketList.clear();

                                          setState(() {
                                            imageUrl = "";
                                            eventImage = null;
                                            dropZoneAccent = Colors.blueAccent;
                                            _selectedDate = DateTime.now();
                                            _dateButtonText = "Pick a date";
                                          });
                                        }
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.green),
                                          shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ))),
                                      child: const Text(
                                        "Create Event",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  )
                                ],
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
    );
  }
}
