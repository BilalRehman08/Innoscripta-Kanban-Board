import 'package:kanban_board_innoscripta/app/app.bottomsheets.dart';
import 'package:kanban_board_innoscripta/app/app.router.dart';
import 'package:kanban_board_innoscripta/repositories/api_repositories.dart';
import 'package:kanban_board_innoscripta/services/local_storage_service.dart';
import 'package:kanban_board_innoscripta/services/projects_service.dart';
import 'package:kanban_board_innoscripta/services/timer/timer_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import 'package:kanban_board_innoscripta/models/task_model.dart';
import '../../../models/project_model.dart';

class TasksViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final BottomSheetService _bottomSheetService;
  final LocalStorageService _localStorageService;
  final TaskTimerService _taskTimerService;
  final ProjectsService projectsService;
  final ApiRepository apiRepository;

  TasksViewModel({
    NavigationService? navigationService,
    BottomSheetService? bottomSheetService,
    LocalStorageService? localStorageService,
    TaskTimerService? taskTimerService,
    ProjectsService? projectsService,
    ApiRepository? apiRepository,
  })  : _navigationService = navigationService ?? locator<NavigationService>(),
        apiRepository = apiRepository ?? ApiRepository(),
        _bottomSheetService =
            bottomSheetService ?? locator<BottomSheetService>(),
        _localStorageService =
            localStorageService ?? locator<LocalStorageService>(),
        _taskTimerService = taskTimerService ?? locator<TaskTimerService>(),
        projectsService = projectsService ?? locator<ProjectsService>() {
    _taskTimerService.addListener(_onTimerUpdate);
  }

  ProjectModel get project => projectsService.selectedProject!;

  List<TaskModel> _todoTasks = [];
  List<TaskModel> _inProgressTasks = [];
  List<TaskModel> _doneTasks = [];

  List<TaskModel> get todoTasks => _todoTasks;
  List<TaskModel> get inProgressTasks => _inProgressTasks;
  List<TaskModel> get doneTasks => _doneTasks;

  Future<void> initialize() async {
    setBusy(true);
    await _taskTimerService.initialize();
    final tasks = await apiRepository.getTasks(project.id!);
    _organizeTasks(tasks);
    _restoreTaskDurations();
    notifyListeners();
    setBusy(false);
  }

  void _onTimerUpdate() {
    notifyListeners();
  }

  void _organizeTasks(List<TaskModel> tasks) {
    _todoTasks = tasks.where((task) => task.status == 'To Do').toList();
    _inProgressTasks =
        tasks.where((task) => task.status == 'In Progress').toList();
    _doneTasks = tasks.where((task) => task.status == 'Done').toList();
  }

  Future<void> _restoreTaskDurations() async {
    for (var task in _inProgressTasks) {
      task.duration = await _taskTimerService.getTaskDuration(task.id!);
    }
  }

  Future<void> moveTask(TaskModel task, String newStatus) async {
    if (_taskTimerService.isTimerRunning(task.id!) &&
        newStatus != 'In Progress') {
      _taskTimerService.stopTimer();
    }

    // Remove the task from its current list and add to the new one
    _todoTasks.remove(task);
    _inProgressTasks.remove(task);
    _doneTasks.remove(task);

    task.setStatus(newStatus);

    switch (newStatus) {
      case 'To Do':
        _todoTasks.add(task);
        break;
      case 'In Progress':
        _inProgressTasks.add(task);
        break;
      case 'Done':
        _doneTasks.add(task);
        break;
    }

    notifyListeners();

    try {
      await apiRepository.updateTask(task.id!, task);
    } catch (e) {
      final tasks = await apiRepository.getTasks(project.id!);
      _organizeTasks(tasks);
      notifyListeners();
    }
  }

  void navigateToCompletedTasks() {
    _navigationService.navigateTo(Routes.completedTasksView);
  }

  Future<void> markTaskAsCompleted(TaskModel task) async {
    setBusy(true);
    try {
      await apiRepository.closeTask(task.id!);
      _doneTasks.remove(task);
      await _localStorageService.addCompletedTask(task);
      notifyListeners();
    } catch (e) {
      // Handle error
    } finally {
      setBusy(false);
    }
  }

  void toggleTimer(TaskModel task) {
    if (task.status != 'In Progress') {
      return;
    }

    if (_taskTimerService.isTimerRunning(task.id!)) {
      _taskTimerService.stopTimer();
    } else {
      _taskTimerService.startTimer(task);
    }
    notifyListeners();
  }

  bool isTimerRunning(TaskModel task) {
    return _taskTimerService.isTimerRunning(task.id!);
  }

  String getFormattedDuration(TaskModel task) {
    if (_taskTimerService.isTimerRunning(task.id!)) {
      return _taskTimerService
          .getFormattedDuration(_taskTimerService.currentDuration);
    } else {
      return _taskTimerService.getFormattedDuration(task.duration ?? 0);
    }
  }

  void createNewTask() async {
    final result = await _navigationService.navigateTo(Routes.updateTaskView,
        arguments: UpdateTaskViewArguments(projectId: project.id!));
    if (result == true) {
      initialize();
    }
  }

  Future<void> showTaskDetails(TaskModel task) async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.taskDetails,
      data: task,
    );

    if (result != null && result.confirmed) {
      editTask(task);
    }
  }

  void editTask(TaskModel task) async {
    final result = await _navigationService.navigateTo(Routes.updateTaskView,
        arguments:
            UpdateTaskViewArguments(projectId: project.id!, taskId: task.id));

    if (result == true) {
      // Task was updated, refresh the task list
      initialize();
    }
  }

  @override
  void dispose() {
    _taskTimerService.removeListener(_onTimerUpdate);
    _taskTimerService.stopTimer();
    super.dispose();
  }
}
