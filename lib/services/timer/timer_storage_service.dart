import 'package:kanban_board_innoscripta/app/app.locator.dart';
import 'package:kanban_board_innoscripta/services/local_storage_service.dart';

abstract class ITimerStorageService {
  Future<String?> getRunningTaskId();
  Future<void> saveTimerState(String taskId);
  Future<String?> getTimerStartTime();
  Future<void> saveTimerStartTime(String? timeString);
  Future<int> getTaskDuration(String taskId);
  Future<void> saveTaskDuration(String taskId, int duration);
}

class TimerStorageService implements ITimerStorageService {
  final LocalStorageService _localStorageService;

  TimerStorageService({LocalStorageService? localStorageService})
      : _localStorageService =
            localStorageService ?? locator<LocalStorageService>();

  @override
  Future<String?> getRunningTaskId() async =>
      _localStorageService.getRunningTaskId();

  @override
  Future<void> saveTimerState(String taskId) async =>
      await _localStorageService.saveTimerState(taskId);

  @override
  Future<String?> getTimerStartTime() async =>
      _localStorageService.getTimerStartTime();

  @override
  Future<void> saveTimerStartTime(String? timeString) async =>
      await _localStorageService.saveTimerStartTime(timeString);

  @override
  Future<int> getTaskDuration(String taskId) async =>
      await _localStorageService.getTaskDuration(taskId);

  @override
  Future<void> saveTaskDuration(String taskId, int duration) async =>
      await _localStorageService.saveTaskDuration(taskId, duration);
}
