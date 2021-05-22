import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
  static read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}

