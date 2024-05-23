import 'dart:convert';
import 'dart:js_interop';

import 'package:ticketa/src/database/backend_service.dart';

class Ticket {
  int? _id;
  int _eventId;
  double _price;

  Ticket(
    this._id,
    this._eventId,
    this._price,
  );

  static Future<List<Ticket>?> getAll() async {
    List<dynamic>? responseList = await BackendService.getFromUri('ticket');
    List<Ticket> ticketList = [];

    if (responseList != null) {
      responseList.forEach((element) {
        try {
          ticketList.add(Ticket(int.parse(element['id']),
              int.parse(element['event_id']), double.parse(element['price'])));
        } catch (e) {
          print(e.toString());
        }
      });
    }
    return ticketList;
  }

  static Future<Ticket?> getById(int id) async {
    Map<String, dynamic>? responseList =
        await BackendService.findByParameter('ticket', 'id=$id');

    if (responseList != null) {
      try {
        dynamic firstElement = responseList;
        Ticket ticket = Ticket(
            int.parse(firstElement['id']),
            int.parse(firstElement['event_id']),
            double.parse(firstElement['price']));
        print(ticket._price);
        return ticket;
      } catch (e) {
        print(e.toString());
      }
    }
    return null;
  }

  static Future<Ticket?> getByUserId(int userId) async {
    Map<String, dynamic>? responseList =
        await BackendService.findByParameter('ticket', 'user_id=$userId');

    if (responseList != null) {
      try {
        Ticket ticket = Ticket(
            int.parse(responseList['id']),
            int.parse(responseList['event_id']),
            double.parse(responseList['price']));
        print(ticket._price);
        return ticket;
      } catch (e) {
        print(e.toString());
      }
    }
    return null;
  }

  static Future<Ticket?> getByEventId(int eventId) async {
    Map<String, dynamic>? responseMap =
        await BackendService.findByParameter('ticket', 'event_id=$eventId');

    if (responseMap != null) {
      try {
        dynamic firstElement = responseMap;
        Ticket ticket = Ticket(
            int.parse(firstElement['id']),
            int.parse(firstElement['event_id']),
            double.parse(firstElement['price']));

        return ticket;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }

  double getPrice() {
    return this._price;
  }

  Map<String, dynamic> toJson() =>
      {"id": _id, "event_id": _eventId, "price": _price};

  Map<String, dynamic> toJsonWithUserId(int userId) =>
      {"id": _id, "event_id": _eventId, "price": _price, "user_id": userId};

  static Future<void> create(Ticket ticket, int userId) async {
    try {
      await BackendService.add(
          'ticket', jsonEncode(ticket.toJsonWithUserId(userId)));
    } catch (e) {
      print(e.toString());
    }
  }
}
