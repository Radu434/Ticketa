
import 'package:ticketa/src/database/backend_service.dart';

class Ticket {
  final int? _id;
  final int _eventId;
  final double _price;
  final String? _type;

  Ticket(this._id, this._eventId, this._price, this._type);

  static Future<List<Ticket>?> getAll() async {
    List<dynamic>? responseList = await BackendService.getFromUri('ticket');
    List<Ticket> ticketList = [];

    if (responseList != null) {
      responseList.forEach((element) {
        try {
          ticketList.add(Ticket(
              int.parse(element['id']),
              int.parse(element['event_id']),
              double.parse(element['price']),
              element['type']));
        } catch (e) {
          print(e.toString());
        }
      });
    }
    return ticketList;
  }

  static Future<Ticket?> getById(int id) async {
    List<dynamic>? responseList =
        await BackendService.findByParameter('ticket', 'id=$id');

    if (responseList!.firstOrNull != null) {
      try {
        dynamic firstElement = responseList.first;
        Ticket ticket = Ticket(
            int.parse(firstElement['id']),
            int.parse(firstElement['event_id']),
            double.parse(firstElement['price']),
            firstElement['type']);
        print(ticket._price);
        return ticket;
      } catch (e) {
        print(e.toString());
      }
    }
    return null;
  }

  static Future<List<dynamic>?> getByUserId(int userId) async {
    List<Ticket>? ticketList = [];

    List<dynamic>? responseList =
        await BackendService.findByParameter('ticket', 'user_id=$userId');

    if (responseList != null) {
      try {
        for (var item in responseList) {
          Ticket ticket = Ticket(
              int.parse(item['id']),
              int.parse(item['event_id']),
              double.parse(item['price']),
              item['type']);
          ticketList.add(ticket);
        }
        return ticketList;
      } catch (e) {
        print(e.toString());
      }
    }

    return null;
  }

  static Future<List<Ticket>?> getAllByEventId(int eventId) async {
    List<dynamic>? responseList =
        await BackendService.findByParameter('ticket', 'event_id=$eventId');
    List<Ticket> ticketList = [];

    if (responseList != null) {
      responseList.forEach((element) {
        try {
          ticketList.add(Ticket(
              int.parse(element['id']),
              int.parse(element['event_id']),
              double.parse(element['price']),
              element['type']));
        } catch (e) {
          print(e.toString());
        }
      });
    }
    return ticketList;
  }

  double getPrice() {
    return _price;
  }

  int? getId() {
    return _id;
  }

  String? getType() {
    return _type;
  }
  int getEventId(){
    return _eventId;
  }

  Map<String, dynamic> toJson() =>
      {"id": _id, "event_id": _eventId, "price": _price, "type": _type};

  Map<String, dynamic> toJsonWithUserId(int userId) => {
        "id": _id,
        "event_id": _eventId,
        "price": _price,
        "type": _type,
        "user_id": userId
      };

  static Future<void> create(Ticket ticket) async {
    try {
      await BackendService.add('ticket', ticket.toJson());
    } catch (e) {
      print(e.toString());
    }
  }
}
