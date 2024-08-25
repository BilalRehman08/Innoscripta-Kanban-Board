import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/services/theme_service.dart';
import 'package:stacked/stacked.dart';

class ThemeViewModel extends ReactiveViewModel {
  final ThemeService _themeService;

  ThemeViewModel({required ThemeService themeService})
      : _themeService = themeService;

  @override
  List<ListenableServiceMixin> get listenableServices => [_themeService];

  ThemeMode get themeMode => _themeService.themeMode;

  void toggleTheme() {
    _themeService.toggleTheme();
  }
}
