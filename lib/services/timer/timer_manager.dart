import 'dart:async';
import 'package:kanban_board_innoscripta/models/task_model.dart';

abstract class ITimerManager {
  String? get runningTaskId;
  int get currentDuration;
  DateTime? get timerStartTime;

  void startTimer(TaskModel task,
      {required Function onTick, required Function onStart});
  void stopTimer({required Function(String? taskId, int duration) onStop});
  bool isTimerRunning(String taskId);
  String getFormattedDuration(int seconds);
  void restoreTimer(String taskId, int duration, DateTime startTime);
}

class TimerManager implements ITimerManager {
  Timer? _timer;
  String? _runningTaskId;
  int _currentDuration = 0;
  DateTime? _timerStartTime;

  @override
  String? get runningTaskId => _runningTaskId;

  @override
  int get currentDuration => _currentDuration;

  @override
  DateTime? get timerStartTime => _timerStartTime;

  @override
  void startTimer(TaskModel task,
      {required Function onTick, required Function onStart}) {
    stopTimer(onStop: (_, __) {});
    _runningTaskId = task.id;
    _currentDuration = task.duration ?? 0;
    _timerStartTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentDuration++;
      task.duration = _currentDuration;
      task.durationUnit = "minute";
      onTick();
    });
    onStart();
  }

  @override
  void stopTimer({required Function(String? taskId, int duration) onStop}) {
    _timer?.cancel();
    _timer = null;
    if (_runningTaskId != null) {
      onStop(_runningTaskId, _currentDuration);
      _runningTaskId = null;
      _currentDuration = 0;
      _timerStartTime = null;
    }
  }

  @override
  bool isTimerRunning(String taskId) => _runningTaskId == taskId;

  @override
  String getFormattedDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void restoreTimer(String taskId, int duration, DateTime startTime) {
    _runningTaskId = taskId;
    _currentDuration = duration;
    _timerStartTime = startTime;
    int elapsedSeconds = DateTime.now().difference(_timerStartTime!).inSeconds;
    _currentDuration += elapsedSeconds;
  }
}
