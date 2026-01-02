import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<SharedPreferences> prefs() async => await SharedPreferences.getInstance();
}
