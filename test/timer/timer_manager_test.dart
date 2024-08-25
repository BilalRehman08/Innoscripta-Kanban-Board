import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board_innoscripta/models/task_model.dart';
import 'package:kanban_board_innoscripta/services/timer/timer_manager.dart';

void main() {
  late TimerManager timerManager;

  setUp(() {
    timerManager = TimerManager();
  });

  group('TimerManager', () {
    test('startTimer starts the timer correctly', () async {
      final task = TaskModel(id: '1', content: 'Test Task');
      int tickCount = 0;
      bool startCalled = false;

      timerManager.startTimer(
        task,
        onTick: () => tickCount++,
        onStart: () => startCalled = true,
      );

      expect(timerManager.runningTaskId, equals('1'));
      expect(timerManager.currentDuration, equals(0));
      expect(timerManager.timerStartTime, isNotNull);
      expect(startCalled, isTrue);

      // Wait for 2 seconds to allow some ticks
      await Future.delayed(const Duration(seconds: 2));
      expect(tickCount, greaterThan(0));
      expect(timerManager.currentDuration, greaterThan(0));
    });

    test('stopTimer stops the timer correctly', () async {
      final task = TaskModel(id: '1', content: 'Test Task');
      timerManager.startTimer(task, onTick: () {}, onStart: () {});

      // Wait for 1 second to ensure the timer has started
      await Future.delayed(const Duration(seconds: 1));

      bool stopCalled = false;
      timerManager.stopTimer(onStop: (taskId, duration) {
        stopCalled = true;
        expect(taskId, equals('1'));
        expect(duration, greaterThan(0));
      });

      expect(timerManager.runningTaskId, isNull);
      expect(timerManager.currentDuration, equals(0));
      expect(timerManager.timerStartTime, isNull);
      expect(stopCalled, isTrue);
    });

    test('isTimerRunning returns correct state', () {
      final task = TaskModel(id: '1', content: 'Test Task');
      expect(timerManager.isTimerRunning('1'), isFalse);

      timerManager.startTimer(task, onTick: () {}, onStart: () {});
      expect(timerManager.isTimerRunning('1'), isTrue);
      expect(timerManager.isTimerRunning('2'), isFalse);

      timerManager.stopTimer(onStop: (_, __) {});
      expect(timerManager.isTimerRunning('1'), isFalse);
    });

    test('getFormattedDuration returns correct format', () {
      expect(timerManager.getFormattedDuration(3661), equals('1:01:01'));
      expect(timerManager.getFormattedDuration(0), equals('0:00:00'));
      expect(timerManager.getFormattedDuration(86400), equals('24:00:00'));
    });

    test('restoreTimer restores timer state correctly', () {
      final now = DateTime.now();
      timerManager.restoreTimer(
          '1', 3600, now.subtract(const Duration(hours: 1)));

      expect(timerManager.runningTaskId, equals('1'));
      expect(timerManager.currentDuration, greaterThanOrEqualTo(3600));
      expect(timerManager.timerStartTime,
          equals(now.subtract(const Duration(hours: 1))));
    });
  });
}
