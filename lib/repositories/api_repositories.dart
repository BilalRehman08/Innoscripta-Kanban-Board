import 'package:kanban_board_innoscripta/app/app.locator.dart';
import 'package:kanban_board_innoscripta/models/comment_model.dart';
import 'package:kanban_board_innoscripta/services/api_service.dart';
import 'package:kanban_board_innoscripta/models/project_model.dart';
import 'package:kanban_board_innoscripta/models/task_model.dart';

class ApiRepository {
  ApiService get _apiService => locator<ApiService>();

  Future<List<ProjectModel>> getProjects() async {
    final response = await _apiService.get('/projects');
    return (response.data as List)
        .map((p) => ProjectModel.fromJson(p))
        .where((project) =>
            !(project.name == 'Inbox' && project.id == '2338232324'))
        .toList();
  }

  Future<void> deleteProject(String projectId) async {
    await _apiService.delete('/projects/$projectId');
  }

  Future<ProjectModel> createProject(ProjectModel project) async {
    final response = await _apiService.post('/projects',
        data: {'name': project.name, 'color': project.color});
    return ProjectModel.fromJson(response.data);
  }

  Future<ProjectModel> updateProject(ProjectModel project) async {
    final response = await _apiService.post('/projects/${project.id}', data: {
      'name': project.name,
      'color': project.color,
      'is_favorite': project.isFavorite,
    });
    return ProjectModel.fromJson(response.data);
  }

  Future<ProjectModel> getProject(String projectId) async {
    final response = await _apiService.get('/projects/$projectId');
    return ProjectModel.fromJson(response.data);
  }

  Future<List<TaskModel>> getTasks(String projectId) async {
    final response = await _apiService
        .get('/tasks', queryParameters: {'project_id': projectId});
    return (response.data as List).map((t) => TaskModel.fromJson(t)).toList();
  }

  Future<TaskModel> getTask(String taskId) async {
    final response = await _apiService.get('/tasks/$taskId');
    return TaskModel.fromJson(response.data);
  }

  Future<TaskModel> createTask(TaskModel task) async {
    final response = await _apiService.post('/tasks', data: task.toJson());
    return TaskModel.fromJson(response.data);
  }

  Future<TaskModel> updateTask(String taskId, TaskModel task) async {
    task.durationUnit = task.durationUnit ?? 'minute';
    task.duration = task.duration ?? 1;
    final data = task.toJson();
    final response = await _apiService.post('/tasks/$taskId', data: data);
    return TaskModel.fromJson(response.data);
  }

  Future<void> deleteTask(String taskId) async {
    await _apiService.delete('/tasks/$taskId');
  }

  Future<List<CommentModel>> getComments(String taskId) async {
    final response = await _apiService
        .get('/comments', queryParameters: {'task_id': taskId});
    return (response.data as List)
        .map((comment) => CommentModel.fromJson(comment))
        .toList();
  }

  Future<CommentModel> addComment(String taskId, String content) async {
    final response = await _apiService.post(
      '/comments',
      data: {'task_id': taskId, 'content': content},
    );
    return CommentModel.fromJson(response.data);
  }

  Future<void> updateComment(String commentId, String newContent) async {
    await _apiService
        .post('/comments/$commentId', data: {'content': newContent});
  }

  Future<void> deleteComment(String commentId) async {
    await _apiService.delete('/comments/$commentId');
  }

  Future<void> closeTask(String taskId) async {
    await _apiService.post('/tasks/$taskId/close');
  }
}
