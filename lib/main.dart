import 'package:kanban_board_innoscripta/ui/views/theme/app_theme.dart';

import 'app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:kanban_board_innoscripta/app/app.router.dart';
import 'package:kanban_board_innoscripta/app/app.dialogs.dart';
import 'package:kanban_board_innoscripta/app/app.bottomsheets.dart';
import 'package:kanban_board_innoscripta/services/theme_service.dart';
import 'package:kanban_board_innoscripta/ui/views/theme/theme_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ThemeViewModel>.reactive(
      viewModelBuilder: () => ThemeViewModel(themeService: ThemeService()),
      builder: (context, model, child) {
        return MaterialApp(
          title: 'Time Tracking App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: model.themeMode,
          navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: StackedRouter().onGenerateRoute,
        );
      },
    );
  }
}
