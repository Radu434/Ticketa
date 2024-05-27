import 'dart:io';
import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
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

  final _searchController = TextEditingController();
  late DropzoneViewController _controller;
  dynamic image;
  String imageUrl = "";

  Future<dynamic> loadImage(dynamic image) async {
    final name = image.name;
    final bytes = await _controller.getFileData(image);
    final url = await _controller.createFileUrl(image);
    setState(() {
      image = bytes;
      imageUrl = url;
    });
    return image;
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
                                          color: Colors.grey.shade900  ,
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
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: const BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(6  ))
                                                        ),
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
                                                                color: Colors.white,
                                                                  fontSize:
                                                                      22.0),
                                                          softWrap: true,
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                            color: Colors.white,
                                                            Icons.edit,
                                                            size: 40,
                                                          )),
                                                      IconButton(
                                                          onPressed: () {},
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DottedBorder(
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
                                    ),
                                    Image.network(
                                      imageUrl,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const Center(child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.cloud_upload,size: 80,color: Colors.blue,),
                                            Text("Drop Image Here")
                                          ],
                                        ),) ;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
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
                                            clipBehavior: Clip.antiAlias,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(8))
                                            ),
                                            child: Image(

                                                fit:
                                                BoxFit.fill,
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
                                                  fontSize:
                                                  22.0),
                                              softWrap: true,
                                            ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DottedBorder(
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
                              ),
                              Image.network(
                                imageUrl,
                                errorBuilder: (BuildContext context,
                                    Object exception,
                                    StackTrace? stackTrace) {
                                  return const Center(child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cloud_upload,size: 80,color: Colors.blue,),
                                      Text("Drop Image Here")
                                    ],
                                  ),) ;
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
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
