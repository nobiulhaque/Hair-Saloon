
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  static Future<void> write(String key, String value) async {
    await _prefs.setString(key, value);
  }
  static String? read(String key) => _prefs.getString(key);
}