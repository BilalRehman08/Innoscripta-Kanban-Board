import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:kanban_board_innoscripta/services/api_service.dart';
import 'package:kanban_board_innoscripta/repositories/api_repositories.dart';
import 'package:kanban_board_innoscripta/models/project_model.dart';
import 'package:get_it/get_it.dart';

@GenerateMocks([ApiService])
import 'project_repository_test.mocks.dart';

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

  group('ProjectRepository', () {
    group('getProjects', () {
      test('returns list of ProjectModel when successful', () async {
        when(mockApiService.get('/projects', context: anyNamed('context')))
            .thenAnswer((_) async => Response(
                  data: [
                    {'id': '1', 'name': 'Project 1'},
                    {'id': '2', 'name': 'Project 2'}
                  ],
                  statusCode: 200,
                  requestOptions: RequestOptions(path: ''),
                ));

        final result = await apiRepository.getProjects(); // Use the instance

        expect(result, isA<List<ProjectModel>>());
        expect(result.length, 2);
        expect(result[0].id, '1');
        expect(result[0].name, 'Project 1');
      });
    });

    group('getProject', () {
      test('returns ProjectModel when successful', () async {
        when(mockApiService.get('/projects/1', context: anyNamed('context')))
            .thenAnswer((_) async => Response(
                  data: {'id': '1', 'name': 'Project 1'},
                  statusCode: 200,
                  requestOptions: RequestOptions(path: ''),
                ));

        final result = await apiRepository.getProject('1'); // Use the instance

        expect(result, isA<ProjectModel>());
        expect(result.id, '1');
        expect(result.name, 'Project 1');
      });
    });
  });
}
