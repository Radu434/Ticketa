import 'package:ticketa/src/database/backend_service.dart';

class Transaction {
  final int? _id;
  final int _userId;
  final int _ticketId;
  final String _date;

  Transaction(this._id, this._userId, this._ticketId, this._date);

  static Future<List<Transaction>?> getAll() async {
    List<dynamic>? responseList =
        await BackendService.getFromUri('transaction');
    List<Transaction> transactionList = [];

    if (responseList != null) {
      responseList.forEach((element) {
        try {
          transactionList.add(Transaction(
              int.parse(element['id']),
              int.parse(element['user_id']),
              int.parse(element['ticket_id']),
              element['date']));
        } catch (e) {
          print(e.toString());
        }
      });
    }
    return transactionList;
  }

  static Future<Transaction?> getById(int id) async {
    List<dynamic>? responseList =
        await BackendService.findByParameter('transaction', 'id=$id');

    if (responseList!.firstOrNull != null) {
      try {
        dynamic element = responseList.first;
        return Transaction(
            int.parse(element['id']),
            int.parse(element['user_id']),
            int.parse(element['ticket_id']),
            element['date']);
      } catch (e) {
        print(e.toString());
      }
    }
    return null;
  }

  static Future<List<Transaction>?> getByUserId(int userId) async {
    List<Transaction>? transactionList = [];

    List<dynamic>? responseList =
        await BackendService.findByParameter('transaction', 'user_id=$userId');

    if (responseList != null) {
      try {
        for (var item in responseList) {
          Transaction transaction = Transaction(
              int.parse(item['id']),
              int.parse(item['user_id']),
              int.parse(item['ticket_id']),
              item['date']);
          transactionList.add(transaction);
        }
        return transactionList;
      } catch (e) {
        print(e.toString());
      }
    }

    return null;
  }

  int? getId() {
    return _id;
  }

  int getUserId() {
    return _userId;
  }

  int getTicketId() {
    return _ticketId;
  }

  String getDate() {
    return _date;
  }

  Map<String, dynamic> toJson() =>
      {"id": _id, "user_id": _userId, "ticket_id": _ticketId, "date": _date};

  static Future<void> create(Transaction transaction) async {
    try {
      await BackendService.add('transaction', transaction.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

}
