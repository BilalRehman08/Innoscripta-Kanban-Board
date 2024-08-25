// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i9;
import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/ui/views/comments/comments_view.dart'
    as _i6;
import 'package:kanban_board_innoscripta/ui/views/completed_tasks/completed_task_view.dart'
    as _i7;
import 'package:kanban_board_innoscripta/ui/views/favorite_project/favorite_project_view.dart'
    as _i8;
import 'package:kanban_board_innoscripta/ui/views/projects/projects_view.dart'
    as _i3;
import 'package:kanban_board_innoscripta/ui/views/splash/splash_view.dart'
    as _i2;
import 'package:kanban_board_innoscripta/ui/views/tasks/tasks_view.dart' as _i4;
import 'package:kanban_board_innoscripta/ui/views/update_task/update_task_view.dart'
    as _i5;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i10;

class Routes {
  static const splashView = '/';

  static const projectsView = '/projects-view';

  static const tasksView = '/tasks-view';

  static const updateTaskView = '/update-task-view';

  static const commentsView = '/comments-view';

  static const completedTasksView = '/completed-tasks-view';

  static const favoriteProjectsView = '/favorite-projects-view';

  static const all = <String>{
    splashView,
    projectsView,
    tasksView,
    updateTaskView,
    commentsView,
    completedTasksView,
    favoriteProjectsView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.projectsView,
      page: _i3.ProjectsView,
    ),
    _i1.RouteDef(
      Routes.tasksView,
      page: _i4.TasksView,
    ),
    _i1.RouteDef(
      Routes.updateTaskView,
      page: _i5.UpdateTaskView,
    ),
    _i1.RouteDef(
      Routes.commentsView,
      page: _i6.CommentsView,
    ),
    _i1.RouteDef(
      Routes.completedTasksView,
      page: _i7.CompletedTasksView,
    ),
    _i1.RouteDef(
      Routes.favoriteProjectsView,
      page: _i8.FavoriteProjectsView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.ProjectsView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.ProjectsView(),
        settings: data,
      );
    },
    _i4.TasksView: (data) {
      final args = data.getArgs<TasksViewArguments>(nullOk: false);
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i4.TasksView(key: args.key, projectId: args.projectId),
        settings: data,
      );
    },
    _i5.UpdateTaskView: (data) {
      final args = data.getArgs<UpdateTaskViewArguments>(nullOk: false);
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.UpdateTaskView(
            key: args.key, projectId: args.projectId, taskId: args.taskId),
        settings: data,
      );
    },
    _i6.CommentsView: (data) {
      final args = data.getArgs<CommentsViewArguments>(nullOk: false);
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i6.CommentsView(key: args.key, taskId: args.taskId),
        settings: data,
      );
    },
    _i7.CompletedTasksView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.CompletedTasksView(),
        settings: data,
      );
    },
    _i8.FavoriteProjectsView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.FavoriteProjectsView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class TasksViewArguments {
  const TasksViewArguments({
    this.key,
    required this.projectId,
  });

  final _i9.Key? key;

  final String projectId;

  @override
  String toString() {
    return '{"key": "$key", "projectId": "$projectId"}';
  }

  @override
  bool operator ==(covariant TasksViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.projectId == projectId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ projectId.hashCode;
  }
}

class UpdateTaskViewArguments {
  const UpdateTaskViewArguments({
    this.key,
    required this.projectId,
    this.taskId,
  });

  final _i9.Key? key;

  final String projectId;

  final String? taskId;

  @override
  String toString() {
    return '{"key": "$key", "projectId": "$projectId", "taskId": "$taskId"}';
  }

  @override
  bool operator ==(covariant UpdateTaskViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.projectId == projectId &&
        other.taskId == taskId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ projectId.hashCode ^ taskId.hashCode;
  }
}

class CommentsViewArguments {
  const CommentsViewArguments({
    this.key,
    required this.taskId,
  });

  final _i9.Key? key;

  final String taskId;

  @override
  String toString() {
    return '{"key": "$key", "taskId": "$taskId"}';
  }

  @override
  bool operator ==(covariant CommentsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.taskId == taskId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ taskId.hashCode;
  }
}

extension NavigatorStateExtension on _i10.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProjectsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.projectsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTasksView({
    _i9.Key? key,
    required String projectId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.tasksView,
        arguments: TasksViewArguments(key: key, projectId: projectId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpdateTaskView({
    _i9.Key? key,
    required String projectId,
    String? taskId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.updateTaskView,
        arguments: UpdateTaskViewArguments(
            key: key, projectId: projectId, taskId: taskId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCommentsView({
    _i9.Key? key,
    required String taskId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.commentsView,
        arguments: CommentsViewArguments(key: key, taskId: taskId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCompletedTasksView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.completedTasksView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFavoriteProjectsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.favoriteProjectsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProjectsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.projectsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTasksView({
    _i9.Key? key,
    required String projectId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.tasksView,
        arguments: TasksViewArguments(key: key, projectId: projectId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpdateTaskView({
    _i9.Key? key,
    required String projectId,
    String? taskId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.updateTaskView,
        arguments: UpdateTaskViewArguments(
            key: key, projectId: projectId, taskId: taskId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCommentsView({
    _i9.Key? key,
    required String taskId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.commentsView,
        arguments: CommentsViewArguments(key: key, taskId: taskId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCompletedTasksView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.completedTasksView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFavoriteProjectsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.favoriteProjectsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
