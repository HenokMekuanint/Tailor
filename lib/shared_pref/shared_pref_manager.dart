import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  SharedPrefManager({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  void setString(String key, String value) {
    sharedPreferences.setString(key, value);
  }

  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  void setInt(String key, int value) {
    sharedPreferences.setInt(key, value);
  }

  int? getInt(String key) {
    return sharedPreferences.getInt(key);
  }

  void setDouble(String key, double value) {
    sharedPreferences.setDouble(key, value);
  }

  double? getDouble(String key) {
    return sharedPreferences.getDouble(key);
  }

  void setBool(String key, bool value) {
    sharedPreferences.setBool(key, value);
  }

  bool getBool(String key) {
    return sharedPreferences.getBool(key) ?? false;
  }

  void remove(String key) {
    sharedPreferences.remove(key);
  }

  void clear() {
    sharedPreferences.clear();
  }

  bool containsKey(String key) {
    return sharedPreferences.containsKey(key);
  }

  Set<String> getKeys() {
    return sharedPreferences.getKeys();
  }

  void setStringList(String key, List<String> value) {
    sharedPreferences.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return sharedPreferences.getStringList(key);
  }

  Future<SharedPreferences> get instance async =>
      await SharedPreferences.getInstance();
}