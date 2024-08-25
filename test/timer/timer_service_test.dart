import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:kanban_board_innoscripta/services/timer/timer_service.dart';
import 'package:kanban_board_innoscripta/services/timer/timer_manager.dart';
import 'package:kanban_board_innoscripta/services/timer/timer_storage_service.dart';

@GenerateMocks([ITimerManager, ITimerStorageService])
import 'timer_service_test.mocks.dart';

void main() {
  late TaskTimerService taskTimerService;
  late MockITimerManager mockTimerManager;
  late MockITimerStorageService mockStorageService;

  setUp(() {
    mockTimerManager = MockITimerManager();
    mockStorageService = MockITimerStorageService();
    taskTimerService = TaskTimerService(
      timerManager: mockTimerManager,
      storageService: mockStorageService,
    );
  });

  group('TaskTimerService', () {
    test('stopTimer calls timerManager.stopTimer and saves state', () {
      taskTimerService.stopTimer();

      verify(mockTimerManager.stopTimer(onStop: anyNamed('onStop'))).called(1);
    });

    test('isTimerRunning delegates to timerManager', () {
      when(mockTimerManager.isTimerRunning('1')).thenReturn(true);

      expect(taskTimerService.isTimerRunning('1'), isTrue);

      when(mockTimerManager.isTimerRunning('2')).thenReturn(false);
      expect(taskTimerService.isTimerRunning('2'), isFalse);
    });

    test('getFormattedDuration delegates to timerManager', () {
      when(mockTimerManager.getFormattedDuration(3600)).thenReturn('1:00:00');

      expect(taskTimerService.getFormattedDuration(3600), equals('1:00:00'));
    });

    test('getTaskDuration delegates to storageService', () async {
      when(mockStorageService.getTaskDuration('1'))
          .thenAnswer((_) async => 3600);

      expect(await taskTimerService.getTaskDuration('1'), equals(3600));
    });

    test('saveTaskDuration delegates to storageService', () async {
      await taskTimerService.saveTaskDuration('1', 3600);

      verify(mockStorageService.saveTaskDuration('1', 3600)).called(1);
    });
  });
}
