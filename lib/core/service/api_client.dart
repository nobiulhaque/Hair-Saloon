import 'package:http/http.dart' as http;
import 'api_constants.dart';

class ApiClient {
  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse("${ApiConstants.baseUrl}$endpoint");
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw Exception('Failed request: ${response.statusCode}');
    }
  }
}
