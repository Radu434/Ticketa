import 'dart:convert';

import 'package:http/http.dart';

class FreeImageHostUploader {
  static Future<String> upload(dynamic bytes) async {
    var client = Client();
    String encodedString = Uri.encodeComponent(base64Encode(bytes).toString());
    String body = 'source=$encodedString';
    try {
      Response response = await post(
          Uri.parse(
              'https://freeimage.host/api/1/upload?key=6d207e02198a847aa98d0a2a901485a5&format=json'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: body);
      if (response.statusCode == 200) {
        var decodedJson = jsonDecode(response.body);
        String imageUrl = decodedJson['image']['url'];
        return imageUrl;
      }
    } catch (e) {
      print(e);
      return '';
    }
    client.close();
    return '';
  }
}
