import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ThemeService with ListenableServiceMixin {
  // Singleton pattern
  static final ThemeService _instance = ThemeService._internal();

  factory ThemeService() {
    return _instance;
  }

  ThemeService._internal() {
    listenToReactiveValues([_themeMode]);
  }

  // Using ReactiveValue to notify listeners
  final ReactiveValue<ThemeMode> _themeMode =
      ReactiveValue<ThemeMode>(ThemeMode.dark);

  ThemeMode get themeMode => _themeMode.value;

  void toggleTheme() {
    _themeMode.value =
        _themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notify listeners about the change
  }
}
