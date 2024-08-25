import 'theme_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/services/theme_service.dart';

class ThemeView extends StatelessWidget {
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ThemeViewModel>.reactive(
      viewModelBuilder: () => ThemeViewModel(themeService: ThemeService()),
      builder: (context, model, child) {
        return IconButton(
          onPressed: () => model.toggleTheme(),
          icon: Icon(
            model.themeMode == ThemeMode.light
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
        );
      },
    );
  }
}
