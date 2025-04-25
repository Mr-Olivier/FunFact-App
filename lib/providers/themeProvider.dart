import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkModeChecked = true;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> updateMode({required bool darkMode}) async {
    try {
      isDarkModeChecked = darkMode;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isDarkModeChecked", darkMode);
      notifyListeners();
    } catch (e) {
      print("Error updating theme mode: $e");
    }
  }

  Future<void> loadMode() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      isDarkModeChecked = prefs.getBool("isDarkModeChecked") ?? true;
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      print("Error loading theme preferences: $e");
      // Use default value in case of error
      isDarkModeChecked = true;
      _isLoaded = true;
      notifyListeners();
    }
  }
}
