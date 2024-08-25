import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:kanban_board_innoscripta/services/api_service.dart';
import 'package:kanban_board_innoscripta/repositories/api_repositories.dart';
import 'package:kanban_board_innoscripta/models/task_model.dart';
import 'package:get_it/get_it.dart';

@GenerateMocks([ApiService])
import 'task_repository_test.mocks.dart';

void main() {
  late MockApiService mockApiService;
  late ApiRepository apiRepository; // Create an instance of ApiRepository

  setUp(() {
    mockApiService = MockApiService();
    GetIt.instance.registerSingleton<ApiService>(mockApiService);
    apiRepository = ApiRepository(); // Initialize ApiRepository
  });

  tearDown(() {
    GetIt.instance.unregister<ApiService>();
  });

  group('TaskRepository', () {
    group('getTasks', () {
      test('returns list of TaskModel when successful', () async {
        when(mockApiService.get('/tasks',
                queryParameters: {'project_id': '1'},
                context: anyNamed('context')))
            .thenAnswer((_) async => Response(
                  data: [
                    {'id': '1', 'content': 'Task 1'},
                    {'id': '2', 'content': 'Task 2'}
                  ],
                  statusCode: 200,
                  requestOptions: RequestOptions(path: ''),
                ));

        final result = await apiRepository.getTasks('1'); // Use the instance

        expect(result, isA<List<TaskModel>>());
        expect(result.length, 2);
        expect(result[0].id, '1');
        expect(result[0].content, 'Task 1');
      });
    });

    group('getTask', () {
      test('returns TaskModel when successful', () async {
        when(mockApiService.get('/tasks/1', context: anyNamed('context')))
            .thenAnswer((_) async => Response(
                  data: {'id': '1', 'content': 'Task 1'},
                  statusCode: 200,
                  requestOptions: RequestOptions(path: ''),
                ));

        final result = await apiRepository.getTask('1'); // Use the instance

        expect(result, isA<TaskModel>());
        expect(result.id, '1');
        expect(result.content, 'Task 1');
      });
    });

    group('createTask', () {
      test('returns created TaskModel when successful', () async {
        final taskToCreate = TaskModel(content: 'New Task');
        when(mockApiService.post('/tasks',
                data: taskToCreate.toJson(), context: anyNamed('context')))
            .thenAnswer((_) async => Response(
                  data: {'id': '1', 'content': 'New Task'},
                  statusCode: 201,
                  requestOptions: RequestOptions(path: ''),
                ));

        final result =
            await apiRepository.createTask(taskToCreate); // Use the instance

        expect(result, isA<TaskModel>());
        expect(result.id, '1');
        expect(result.content, 'New Task');
      });
    });

    group('deleteTask', () {
      test('completes successfully', () async {
        when(mockApiService.delete('/tasks/1', context: anyNamed('context')))
            .thenAnswer((_) async => Response(
                  statusCode: 204,
                  requestOptions: RequestOptions(path: ''),
                ));

        await expectLater(
            apiRepository.deleteTask('1'), completes); // Use the instance
      });
    });

    group('closeTask', () {
      test('completes successfully', () async {
        when(mockApiService.post('/tasks/1/close',
                context: anyNamed('context')))
            .thenAnswer((_) async => Response(
                  statusCode: 204,
                  requestOptions: RequestOptions(path: ''),
                ));

        await expectLater(
            apiRepository.closeTask('1'), completes); // Use the instance
      });
    });
  });
}
