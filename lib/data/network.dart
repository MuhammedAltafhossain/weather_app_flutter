

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

class Network{
  Future<dynamic> getMethod(String url) async {
     try {
      Uri uri = Uri.parse(url);
      final Response response = await get(uri);
      log(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {

      } else {
        log('status Code ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}