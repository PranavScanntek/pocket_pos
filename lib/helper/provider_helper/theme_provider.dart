import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colors.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme = lightTheme;
  IconData _currentButtonIcon=Icons.light_mode_outlined;
  SharedPreferences? _prefs;


  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    final isDark = _prefs!.getBool('isDark') ?? false;
    _currentTheme = isDark ? darkTheme : lightTheme;
    _currentButtonIcon = isDark ? darkThemeIcon : lightThemeIcon;
    notifyListeners();
  }
  ThemeData get currentTheme => _currentTheme;
  IconData get currentButtonIcon => _currentButtonIcon;

  Future<void> toggleTheme() async {
    _currentTheme = _currentTheme == lightTheme ? darkTheme : lightTheme;
    _currentButtonIcon = _currentButtonIcon == lightThemeIcon ? darkThemeIcon : lightThemeIcon;
    notifyListeners();

    final isDark = _currentTheme == darkTheme;
    await _prefs!.setBool('isDark', isDark);
  }
}
