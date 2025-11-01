import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mitra_cempaka/main.dart';
import 'package:mitra_cempaka/pages/login_page.dart';
import 'package:mitra_cempaka/services/storage/auth_preferences.dart';

class MitraCempakaApi {
  static Uri _endpoint(String path, [Map<String, dynamic>? query]) {
    return Uri.https('mitracempaka.id', path);
  }

  static Future<Map<String, String>> _headers() async {
    return {
      'Authorization': "Bearer ${await AuthPreferences.getAccessToken()}",
    };
  }

  static void _handleError() {
    AuthPreferences.setLoggedOut();
    AppNavigator.key.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  static Future<http.Response> login(String username, String password) async {
    return await http.post(
      _endpoint('api/login'),
      body: {'username': username, 'password': password},
    );
  }

  static Future<http.Response> getDrug() async {
    http.Response response = await http.get(
      _endpoint('api/cashier/create'),
      headers: await _headers(),
    );

    if (response.statusCode == 500) _handleError();

    return response;
  }

  static Future<http.Response> getHistory() async {
    http.Response response = await http.get(
      _endpoint('api/cashier/history'),
      headers: await _headers(),
    );

    if (response.statusCode == 500) _handleError();

    return response;
  }
}
