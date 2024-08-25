// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/projects/project_dialog_view.dart';

enum DialogType {
  projectForm,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.projectForm: (context, request, completer) =>
        ProjectFormDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
