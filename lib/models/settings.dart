import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, system } 
enum TextScale { normal, large, extraLarge }

class AppSettings with ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const String _textScaleKey = 'text_scale';

  AppThemeMode _themeMode = AppThemeMode.system;
  TextScale _textScale = TextScale.normal;

  AppThemeMode get themeMode => _themeMode;
  TextScale get textScale => _textScale;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = AppThemeMode.values[
      prefs.getInt(_themeKey) ?? ThemeMode.system.index
    ];
    _textScale = TextScale.values[
      prefs.getInt(_textScaleKey) ?? TextScale.normal.index
    ];
    notifyListeners();
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
    notifyListeners();
  }

  Future<void> setTextScale(TextScale scale) async {
    _textScale = scale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_textScaleKey, scale.index);
    notifyListeners();
  }

  double get textScaleFactor {
    switch (_textScale) {
      case TextScale.large:
        return 1.25;
      case TextScale.extraLarge:
        return 1.5;
      default:
        return 1.0;
    }
  }
}