import 'dart:convert';
import 'dart:js_interop';

import 'package:ticketa/src/database/backend_service.dart';

class Event {
  int? _id;
  String _name;
  String _location;
  String _date;
  String _description;
  String _photo;

  int? getId() => _id;

  set id(int value) {
    _id = value;
  }

  Event(this._id, this._name, this._location, this._date, this._description,
      this._photo);

  static Future<List<Event>?> getAll() async {
    List<dynamic>? responseList = await BackendService.getFromUri('event');
    List<Event> ticketList = [];

    if (responseList != null) {
      responseList.forEach((element) {
        try {
          ticketList.add(Event(
              int.parse(element['id']),
              element['name'],
              element['location'],
              element['date'],
              element['description'],
              element['photo']));
        } catch (e) {
          print(e.toString());
        }
      });
    }
    return ticketList;
  }

  static Future<Event?> getById(int id) async {
    List<dynamic>? responseList =
        await BackendService.findByParameter('event', 'id=$id');

    if (responseList!.firstOrNull != null) {
      try {
        dynamic firstElement = responseList.firstOrNull;
        Event event = Event(
            int.parse(firstElement['id']),
            firstElement['name'],
            firstElement['location'],
            firstElement['date'],
            firstElement['description'],
            firstElement['photo']);

        return event;
      } catch (e) {
        print(e.toString());
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        "id": _id,
        "name": _name,
        "location": _location,
        "date": _date,
        "description": _description,
        "photo": _photo
      };

  static Future<void> create(Event event) async {
    try {
      await BackendService.add('event', event.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  String getName() => _name;

  set name(String value) {
    _name = value;
  }

  String getLocation() => _location;

  set location(String value) {
    _location = value;
  }

  String getDate() => _date;

  set date(String value) {
    _date = value;
  }

  String getDescription() => _description;

  set description(String value) {
    _description = value;
  }

  String getPhoto() => _photo;

  set photo(String value) {
    _photo = value;
  }
}
