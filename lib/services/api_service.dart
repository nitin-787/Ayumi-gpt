// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:chatgpt/constants/api_consts.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );

      Map jsonResponse = jsonDecode(response.body);
      print("response $jsonResponse");
    } catch (error) {
      print("error $error");
    }
  }
}
