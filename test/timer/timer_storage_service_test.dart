import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:kanban_board_innoscripta/services/local_storage_service.dart';
import 'package:kanban_board_innoscripta/services/timer/timer_storage_service.dart';

@GenerateMocks([LocalStorageService])
import 'timer_storage_service_test.mocks.dart';

void main() {
  late TimerStorageService timerStorageService;
  late MockLocalStorageService mockLocalStorageService;

  setUp(() {
    mockLocalStorageService = MockLocalStorageService();
    timerStorageService =
        TimerStorageService(localStorageService: mockLocalStorageService);
  });

  group('TimerStorageService', () {
    test('saveTimerState delegates to LocalStorageService', () async {
      await timerStorageService.saveTimerState('1');
      verify(mockLocalStorageService.saveTimerState('1')).called(1);
    });

    test('saveTimerStartTime delegates to LocalStorageService', () async {
      final now = DateTime.now().toIso8601String();
      await timerStorageService.saveTimerStartTime(now);
      verify(mockLocalStorageService.saveTimerStartTime(now)).called(1);

      await timerStorageService.saveTimerStartTime(null);
      verify(mockLocalStorageService.saveTimerStartTime(null)).called(1);
    });

    test('getTaskDuration delegates to LocalStorageService', () async {
      when(mockLocalStorageService.getTaskDuration('1'))
          .thenAnswer((_) async => 3600);
      expect(await timerStorageService.getTaskDuration('1'), equals(3600));
    });

    test('saveTaskDuration delegates to LocalStorageService', () async {
      await timerStorageService.saveTaskDuration('1', 3600);
      verify(mockLocalStorageService.saveTaskDuration('1', 3600)).called(1);
    });
  });
}
