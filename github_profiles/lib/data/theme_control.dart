import 'package:flutter/foundation.dart';
import 'package:github_profiles/data/storage_data.dart';

class DarkThemeProvider with ChangeNotifier {
  ThemePreference darkThemePreference = ThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme; //getter

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);//Update Storage for app persistance
    notifyListeners();//Update Provider Listeners
  }
}