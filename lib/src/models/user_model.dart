import 'dart:convert';
import 'package:ticketa/src/database/backend_service.dart';

class User {
  int? _id;
  String? _email;
  String? _username;
  String? _password;

  User(this._id, this._email, this._username, this._password);

  static Future<List<User>?> getAll() async {
    List<dynamic>? responseList = await BackendService.getFromUri('user');
    List<User> ticketList = [];

    if (responseList != null) {
      responseList.forEach((element) {
        try {
          ticketList.add(User(int.parse(element['id']), element['email'],
              element['password'], element['username']));
        } catch (e) {
          print(e.toString());
        }
      });
    }
    return ticketList;
  }

  static Future<User?> findById(int id) async {
    List<dynamic>? mappedResponse =
        await BackendService.findByParameter('user', 'id=$id');

    if (mappedResponse!.firstOrNull != null) {
      try {
        dynamic firstElement = mappedResponse.first;
        User event = User(int.parse(firstElement['id']), firstElement['email'],
            firstElement['username'], firstElement['password']);

        return event;
      } catch (e) {
        print(e.toString());
      }
    }
    return null;
  }

  static Future<User?> findByEmail(String email) async {
    List<dynamic>?  responseList =
        await BackendService.findByParameter('user', 'email=$email');

    if (responseList!.firstOrNull != null) {
      try {
        dynamic firstElement = responseList.first;
        User event = User(int.parse(firstElement['id']), firstElement['email'],
            firstElement['username'], firstElement['password']);

        return event;
      } catch (e) {
        print(e.toString());
      }
    }
    return null;
  }

  static Future<User?> login(String email, String password) async {
    List<dynamic>?  responseList = await BackendService.findByParameter(
        'user', 'login=true&password=$password&email=$email');

    if (responseList!.firstOrNull != null) {
      try {
        User user = User(responseList.first['id'], responseList.first['email'],
            responseList.first['username'], responseList.first['password']);
        print(user.toJson());
        return user;
      } catch (e) {
        print(e.toString());
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        "id": _id,
        "email": _email,
        "username": _username,
        "password": _password
      };

  static Future<int> create(User user) async {
    try {
      return await BackendService.add('user', user.toJson());
    } catch (e) {
      print(e.toString());
      return -1;
    }
  }

  static Future<void> update(int id, User user) async {
    try {
      await BackendService.updateByParameter(
          'user', 'id=$id', jsonEncode(user.toJson()));
    } catch (e) {
      print(e.toString());
    }
  }

  String? getPassword() => _password;

  set password(String value) {
    _password = value;
  }

  String? getUsername() => _username;

  set username(String value) {
    _username = value;
  }

  String? getEmail() => _email;

  set email(String value) {
    _email = value;
  }

  int? getId() => _id;
}
