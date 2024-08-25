import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:kanban_board_innoscripta/services/api_service.dart';
import 'package:stacked_services/stacked_services.dart';

@GenerateMocks([Dio, SnackbarService])
import 'api_service_test.mocks.dart';

void main() {
  late ApiService apiService;
  late MockDio mockDio;
  late MockSnackbarService mockSnackbarService;

  setUp(() {
    mockDio = MockDio();
    mockSnackbarService = MockSnackbarService();

    // Stub the options property of mockDio
    final mockOptions = BaseOptions();
    when(mockDio.options).thenReturn(mockOptions);

    apiService = ApiService(dio: mockDio, snackbarService: mockSnackbarService);
  });

  group('ApiService', () {
    test('initializes with correct base URL and token', () {
      expect(apiService.dio.options.baseUrl, 'https://api.todoist.com/rest/v2');
      expect(apiService.dio.options.headers['Authorization'],
          'Bearer a09eeac02ed4ef38c543e88a2f6d2515d85d2519');
    });

    group('GET requests', () {
      test('successful GET request', () async {
        when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
            .thenAnswer((_) async => Response(
                  requestOptions: RequestOptions(path: ''),
                  statusCode: 200,
                  data: {'key': 'value'},
                ));

        final response =
            await apiService.get('/test', queryParameters: {'param': 'value'});

        expect(response.statusCode, 200);
        expect(response.data, {'key': 'value'});
        verify(mockDio.get('/test', queryParameters: {'param': 'value'}))
            .called(1);
      });
    });

    group('POST requests', () {
      test('successful POST request', () async {
        when(mockDio.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => Response(
                  requestOptions: RequestOptions(path: ''),
                  statusCode: 201,
                  data: {'id': '123'},
                ));

        final response = await apiService.post('/test', data: {'name': 'Test'});

        expect(response.statusCode, 201);
        expect(response.data, {'id': '123'});
        verify(mockDio.post('/test', data: {'name': 'Test'})).called(1);
      });
    });

    group('PUT requests', () {
      test('successful PUT request', () async {
        when(mockDio.put(any, data: anyNamed('data')))
            .thenAnswer((_) async => Response(
                  requestOptions: RequestOptions(path: ''),
                  statusCode: 200,
                  data: {'updated': true},
                ));

        final response =
            await apiService.put('/test', data: {'name': 'Updated'});

        expect(response.statusCode, 200);
        expect(response.data, {'updated': true});
        verify(mockDio.put('/test', data: {'name': 'Updated'})).called(1);
      });
    });

    group('DELETE requests', () {
      test('successful DELETE request', () async {
        when(mockDio.delete(any)).thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 204,
            ));

        final response = await apiService.delete('/test');

        expect(response.statusCode, 204);
        verify(mockDio.delete('/test')).called(1);
      });
    });
  });
}
