import 'package:kanban_board_innoscripta/app/app.locator.dart';
import 'package:kanban_board_innoscripta/app/app.router.dart';
import 'package:kanban_board_innoscripta/models/task_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TaskDetailsSheetViewModel extends BaseViewModel {
  NavigationService navigationService = locator<NavigationService>();

  previewComments(TaskModel task) async {
    await navigationService.navigateTo(Routes.commentsView,
        arguments: CommentsViewArguments(taskId: task.id!));
  }
}
