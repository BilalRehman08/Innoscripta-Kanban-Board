import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:kanban_board_innoscripta/services/api_service.dart';
import 'package:kanban_board_innoscripta/repositories/api_repositories.dart';
import 'package:kanban_board_innoscripta/models/comment_model.dart';
import 'package:get_it/get_it.dart';

@GenerateMocks([ApiService])
import 'comment_repository_test.mocks.dart';

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

  group('CommentRepository', () {
    group('getComments', () {
      test('returns list of CommentModel when successful', () async {
        when(mockApiService.get('/comments',
                queryParameters: {'task_id': '1'},
                context: anyNamed('context')))
            .thenAnswer((_) async => Response(
                  data: [
                    {
                      'id': '1',
                      'content': 'Comment 1',
                      'posted_at': '2023-06-10T10:00:00Z',
                      'task_id': '1',
                    },
                    {
                      'id': '2',
                      'content': 'Comment 2',
                      'posted_at': '2023-06-10T11:00:00Z',
                      'task_id': '1',
                    }
                  ],
                  statusCode: 200,
                  requestOptions: RequestOptions(path: ''),
                ));

        final result = await apiRepository.getComments('1'); // Use the instance

        expect(result, isA<List<CommentModel>>());
        expect(result.length, 2);
        expect(result[0].id, '1');
        expect(result[0].content, 'Comment 1');
      });
    });

    group('addComment', () {
      test('returns created CommentModel when successful', () async {
        when(mockApiService.post('/comments',
                data: {'task_id': '1', 'content': 'New Comment'},
                context: anyNamed('context')))
            .thenAnswer((_) async => Response(
                  data: {
                    'id': '1',
                    'content': 'New Comment',
                    'posted_at': '2023-06-10T12:00:00Z',
                    'task_id': '1',
                  },
                  statusCode: 201,
                  requestOptions: RequestOptions(path: ''),
                ));

        final result = await apiRepository.addComment(
            '1', 'New Comment'); // Use the instance

        expect(result, isA<CommentModel>());
        expect(result.id, '1');
        expect(result.content, 'New Comment');
      });
    });

    group('updateComment', () {
      test('completes successfully', () async {
        when(mockApiService.post('/comments/1',
                data: {'content': 'Updated Comment'},
                context: anyNamed('context')))
            .thenAnswer((_) async => Response(
                  statusCode: 200,
                  requestOptions: RequestOptions(path: ''),
                ));

        await expectLater(apiRepository.updateComment('1', 'Updated Comment'),
            completes); // Use the instance
      });
    });

    group('deleteComment', () {
      test('completes successfully', () async {
        when(mockApiService.delete('/comments/1', context: anyNamed('context')))
            .thenAnswer((_) async => Response(
                  statusCode: 204,
                  requestOptions: RequestOptions(path: ''),
                ));

        await expectLater(
            apiRepository.deleteComment('1'), completes); // Use the instance
      });
    });
  });
}
