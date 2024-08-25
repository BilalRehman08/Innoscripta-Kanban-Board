import 'package:kanban_board_innoscripta/services/api_service.dart';
import 'package:kanban_board_innoscripta/services/projects_service.dart';
import 'package:kanban_board_innoscripta/services/timer/timer_service.dart';
import 'package:kanban_board_innoscripta/services/timer/timer_storage_service.dart';
import 'package:kanban_board_innoscripta/ui/bottom_sheets/task_detail/task_detail_sheet.dart';
import 'package:kanban_board_innoscripta/ui/dialogs/projects/project_dialog_view.dart';
import 'package:kanban_board_innoscripta/ui/views/comments/comments_view.dart';
import 'package:kanban_board_innoscripta/ui/views/completed_tasks/completed_task_view.dart';
import 'package:kanban_board_innoscripta/ui/views/favorite_project/favorite_project_view.dart';
import 'package:kanban_board_innoscripta/ui/views/tasks/tasks_view.dart';
import 'package:kanban_board_innoscripta/ui/views/update_task/update_task_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../ui/views/splash/splash_view.dart';
import '../ui/views/projects/projects_view.dart';
import '../services/local_storage_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: ProjectsView),
    MaterialRoute(page: TasksView),
    MaterialRoute(page: UpdateTaskView),
    MaterialRoute(page: CommentsView),
    MaterialRoute(page: CompletedTasksView),
    MaterialRoute(page: FavoriteProjectsView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: LocalStorageService),
    LazySingleton(classType: ProjectsService),
    LazySingleton(classType: TaskTimerService),
    LazySingleton(classType: TimerStorageService, asType: ITimerStorageService),
  ],
  bottomsheets: [
    StackedBottomsheet(
      classType: TaskDetailsSheet,
    )
  ],
  dialogs: [
    StackedDialog(classType: ProjectFormDialog),
  ],
)
class App {}
