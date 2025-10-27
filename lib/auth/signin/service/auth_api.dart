import 'package:hair_saloon/core/service/api_constants.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  static Future<http.Response> login(email, password) async {
    return await http.post(
      Uri.parse('${ApiConstants.baseUrl}/User/login/'),
      body: {'email': email, 'password': password},
    );
  }
}