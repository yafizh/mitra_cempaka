import 'package:http/http.dart' as http;
import 'package:mitra_cempaka/services/storage/auth_preferences.dart';

class MitraCempakaApi {
  static Uri endpoint(String path, [Map<String, dynamic>? query]) {
    return Uri.https('mitracempaka.id', path);
  }

  static Future<http.Response> login(String username, String password) async {
    return await http.post(
      endpoint('api/login'),
      body: {'username': username, 'password': password},
    );
  }

  static Future<http.Response> getDrug() async {
    return await http.get(endpoint('api/cashier/create'),headers: {
      'Authorization': "Bearer ${await AuthPreferences.getAccessToken()}"
    });
  }

  static Future<http.Response> getHistory() async {
    return await http.get(endpoint('api/cashier/history'),headers: {
      'Authorization': "Bearer ${await AuthPreferences.getAccessToken()}"
    });
  }
}
