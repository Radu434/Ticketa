import 'dart:convert';

import 'package:http/http.dart';

class BackendService {
  static Future<List<dynamic>?> getFromUri(String resource) async {
    var client = Client();
    List<dynamic>? responseList;
    try {
      Response response = await client
          .get(Uri.parse('http://localhost/ticketa_backend/$resource'));
      client.close();
      if (response.statusCode == 200 && response.body.length > 2) {
        responseList = jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return responseList;
  }

  static Future<int> add(
      String location, Map<String, dynamic>? dataBody) async {
    var client = Client();
    try {
      var response = await client.post(
          Uri.parse('http://localhost/ticketa_backend/$location'),
          body: jsonEncode(dataBody));
      client.close();
      return jsonDecode(response.body)["id"] ?? -1;
    } catch (e) {
      print(e);
      return -1;
    }
  }

  static Future<List<dynamic>?> findByParameter(
      String resource, String params) async {
    var client = Client();
    try {
      Response response = await client
          .get(Uri.parse('http://localhost/ticketa_backend/$resource?$params'));
      client.close();

      if (response.statusCode == 200 && response.body.length > 2) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<bool> updateByParameter(
      String resource, String params, String dataBody) async {
    var client = Client();
    try {
      await client.patch(
          Uri.parse('http://localhost/ticketa_backend/$resource?$params'),
          body: dataBody);
      client.close();
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }
}
