import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  /// Salva {key: value} em Local Storage.
  static Future save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  /// Busca por key em Local Storage.
  static Future<String> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '0';
  }

  /// Verifica se em Local Storage possui key.
  static Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  /// Remove key em Local Storage.
  static Future remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  /// Busca todas keys em Local Storage.
  static Future<Set<String>> getAllKeys() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }

  /// Deleta todas key em Local Storage.
  static Future removeAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
