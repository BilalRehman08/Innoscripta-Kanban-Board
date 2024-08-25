import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:kanban_board_innoscripta/models/task_model.dart';
import 'package:kanban_board_innoscripta/models/project_model.dart';
import 'package:kanban_board_innoscripta/services/local_storage_service.dart';
import 'package:kanban_board_innoscripta/services/projects_service.dart';
import 'package:kanban_board_innoscripta/utils/date_formatter_utility.dart';
import 'package:kanban_board_innoscripta/utils/priority_utility.dart';
import 'package:kanban_board_innoscripta/app/app.locator.dart';

class CompletedTasksViewModel extends BaseViewModel {
  final _localStorageService = locator<LocalStorageService>();
  final _projectsService = locator<ProjectsService>();
  Map<String, List<TaskModel>> _completedTasksByProject = {};
  final Map<String, String> _projectNames = {};

  Map<String, List<TaskModel>> get completedTasksByProject =>
      _completedTasksByProject;
  Map<String, String> get projectNames => _projectNames;

  Future<void> initialize() async {
    await fetchCompletedTasks();
    _fetchProjectNames();
  }

  Future<void> fetchCompletedTasks() async {
    setBusy(true);
    List<TaskModel> allCompletedTasks =
        _localStorageService.getCompletedTasks();
    _completedTasksByProject = {};
    for (var task in allCompletedTasks) {
      if (task.projectId != null) {
        _completedTasksByProject
            .putIfAbsent(task.projectId!, () => [])
            .add(task);
      }
    }
    setBusy(false);
  }

  void _fetchProjectNames() {
    for (var projectId in _completedTasksByProject.keys) {
      final project = _projectsService.projects.firstWhere(
        (p) => p.id == projectId,
        orElse: () => ProjectModel(id: projectId, name: 'Unknown Project'),
      );
      _projectNames[projectId] = project.name ?? 'Unknown Project';
    }
    notifyListeners();
  }

  String getPriorityLabel(int priority) {
    return PriorityUtility.getPriorityString(priority);
  }

  Color getPriorityColor(int priority) {
    return PriorityUtility.getPriorityColor(priority);
  }

  String getFormattedDuration(int seconds) {
    return DateFormatterUtility.formatDuration(seconds);
  }

  String getProjectName(String projectId) {
    return _projectNames[projectId] ?? 'Unknown Project';
  }

  String getProjectColor(String projectId) {
    final project = _projectsService.projects.firstWhere(
      (p) => p.id == projectId,
      orElse: () => ProjectModel(id: projectId, color: '0xFF000000'),
    );
    return project.color ?? '0xFF000000';
  }
}
