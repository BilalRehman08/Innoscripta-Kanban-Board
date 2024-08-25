import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:kanban_board_innoscripta/models/task_model.dart';

class LocalStorageService {
  static SharedPreferences? _prefs;
  static const String completedTasksKey = 'completed_tasks';
  static const String runningTaskIdKey = 'running_task_id';

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future setString(String key, String value) async {
    return await _prefs!.setString(key, value);
  }

  String? getString(String key) {
    return _prefs!.getString(key);
  }

  Future<void> addCompletedTask(TaskModel task) async {
    List<TaskModel> completedTasks = getCompletedTasks();
    completedTasks.add(task);
    await _saveCompletedTasks(completedTasks);
  }

  List<TaskModel> getCompletedTasks() {
    String? tasksJson = _prefs!.getString(completedTasksKey);
    if (tasksJson == null) return [];
    List<dynamic> tasksList = jsonDecode(tasksJson);
    return tasksList.map((task) => TaskModel.fromJson(task)).toList();
  }

  Future<void> _saveCompletedTasks(List<TaskModel> tasks) async {
    String tasksJson = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await _prefs!.setString(completedTasksKey, tasksJson);
  }

  Future<void> saveTimerStartTime(String? timeString) async {
    if (timeString == null) {
      await _prefs!.remove('timer_start_time');
    } else {
      await _prefs!.setString('timer_start_time', timeString);
    }
  }

  String? getTimerStartTime() {
    return _prefs!.getString('timer_start_time');
  }

  Future<void> clearCompletedTasks() async {
    await _prefs!.remove(completedTasksKey);
  }

  Future<void> saveTimerState(String taskId) async {
    await _prefs!.setString(runningTaskIdKey, taskId);
  }

  String? getRunningTaskId() {
    return _prefs!.getString(runningTaskIdKey);
  }

  Future<void> saveTaskDuration(String taskId, int duration) async {
    await _prefs!.setInt('task_${taskId}_duration', duration);
  }

  Future<int> getTaskDuration(String taskId) async {
    return _prefs!.getInt('task_${taskId}_duration') ?? 0;
  }
}
