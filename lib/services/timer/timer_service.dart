import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:kanban_board_innoscripta/app/app.locator.dart';
import 'package:kanban_board_innoscripta/models/task_model.dart';
import 'package:kanban_board_innoscripta/services/timer/timer_manager.dart';
import 'package:kanban_board_innoscripta/services/timer/timer_storage_service.dart';

class TaskTimerService extends ChangeNotifier {
  final ITimerStorageService _storageService;
  final ITimerManager _timerManager;

  TaskTimerService({
    ITimerStorageService? storageService,
    ITimerManager? timerManager,
  })  : _storageService = storageService ?? locator<ITimerStorageService>(),
        _timerManager = timerManager ?? TimerManager();

  String? get runningTaskId => _timerManager.runningTaskId;
  int get currentDuration => _timerManager.currentDuration;

  Future<void> initialize() async {
    await _restoreTimerState();
  }

  void startTimer(TaskModel task) {
    _timerManager.startTimer(
      task,
      onTick: () => notifyListeners(),
      onStart: _saveTimerState,
    );
  }

  void stopTimer() {
    _timerManager.stopTimer(
      onStop: (String? taskId, int duration) {
        if (taskId != null) {
          _storageService.saveTaskDuration(taskId, duration);
        }
        _saveTimerState();
        notifyListeners();
      },
    );
  }

  bool isTimerRunning(String taskId) => _timerManager.isTimerRunning(taskId);

  String getFormattedDuration(int seconds) =>
      _timerManager.getFormattedDuration(seconds);

  Future<void> _restoreTimerState() async {
    String? taskId = await _storageService.getRunningTaskId();
    if (taskId != null) {
      int duration = await _storageService.getTaskDuration(taskId);
      String? startTimeStr = await _storageService.getTimerStartTime();
      if (startTimeStr != null) {
        DateTime startTime = DateTime.parse(startTimeStr);
        _timerManager.restoreTimer(taskId, duration, startTime);
        notifyListeners();
      }
    }
  }

  Future<void> _saveTimerState() async {
    await _storageService.saveTimerState(_timerManager.runningTaskId ?? '');
    await _storageService
        .saveTimerStartTime(_timerManager.timerStartTime?.toIso8601String());
  }

  Future<int> getTaskDuration(String taskId) =>
      _storageService.getTaskDuration(taskId);

  Future<void> saveTaskDuration(String taskId, int duration) =>
      _storageService.saveTaskDuration(taskId, duration);
}
