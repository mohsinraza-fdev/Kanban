// test/network/api_client_kanban_test.dart

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_app/network/api_client_kanban.dart';
import 'package:kanban_app/network/endpoints_kanban.dart';
import 'package:mockito/mockito.dart';

import '../test_helpers.mocks.dart';

void main() {
  late ApiClientKanban apiClient;
  late MockDio mockDio;
  late BaseOptions mockOptions;

  setUp(() {
    mockDio = MockDio();
    mockOptions = BaseOptions();
    when(mockDio.options).thenReturn(mockOptions);
    apiClient = ApiClientKanban(mockDio);
  });

  group('ApiClientKanban -', () {
    group('GET requests -', () {
      test('get() should return correct response on success', () async {
        const endpoint = '/test';
        const expectedData = {'key': 'value'};
        final response = Response(
          requestOptions: RequestOptions(path: endpoint),
          data: expectedData,
          statusCode: 200,
        );
        when(mockDio.get(any, options: anyNamed('options'))).thenAnswer((_) async => response);

        final result = await apiClient.get<Map<String, dynamic>>(endpoint);

        expect(result, equals(expectedData));
        verify(mockDio.get(endpoint, options: anyNamed('options'))).called(1);
      });

      test('get() should handle cancel token correctly', () async {
        const endpoint = '/test';
        final cancelToken = CancelToken();
        when(mockDio.get(any, cancelToken: cancelToken)).thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: endpoint),
              data: {'key': 'value'},
              statusCode: 200,
            ));

        await apiClient.get(endpoint, cancelToken: cancelToken);

        verify(mockDio.get(endpoint, cancelToken: cancelToken)).called(1);
      });

      test('get() should handle query parameters correctly', () async {
        const endpoint = '/test';
        final queryParams = {'key': 'value'};
        when(mockDio.get(any, queryParameters: queryParams)).thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: endpoint),
              data: {'response': 'data'},
              statusCode: 200,
            ));

        await apiClient.get(endpoint, queryParameters: queryParams);

        verify(mockDio.get(endpoint, queryParameters: queryParams)).called(1);
      });
    });

    group('POST requests -', () {
      test('post() should return correct response on success', () async {
        const endpoint = '/test';
        const requestData = {'request': 'data'};
        const expectedData = {'response': 'success'};
        final response = Response(
          requestOptions: RequestOptions(path: endpoint),
          data: expectedData,
          statusCode: 200,
        );
        when(mockDio.post(any, data: requestData)).thenAnswer((_) async => response);

        final result = await apiClient.post<Map<String, dynamic>>(
          endpoint,
          data: requestData,
        );

        expect(result, equals(expectedData));
        verify(mockDio.post(endpoint, data: requestData)).called(1);
      });
    });

    group('DELETE requests -', () {
      test('delete() should return correct response on success', () async {
        const endpoint = '/test';
        final response = Response(
          requestOptions: RequestOptions(path: endpoint),
          data: 'deleted',
          statusCode: 200,
        );
        when(mockDio.delete(any)).thenAnswer((_) async => response);

        final result = await apiClient.delete<String>(endpoint);

        expect(result, equals('deleted'));
        verify(mockDio.delete(endpoint)).called(1);
      });

      test('delete() should handle request with data correctly', () async {
        const endpoint = '/test';
        const requestData = {'id': '123'};
        when(mockDio.delete(any, data: requestData)).thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: endpoint),
              data: 'success',
              statusCode: 200,
            ));

        await apiClient.delete(endpoint, data: requestData);
        verify(mockDio.delete(endpoint, data: requestData)).called(1);
      });
    });

    group('Base configuration -', () {
      test('should have correct base URL', () {
        expect(apiClient.baseUrl, equals(EndpointsKanban.baseUrl));
      });

      test('should have correct timeout values', () {
        expect(apiClient.defaultConnectTimeout, equals(100000));
        expect(apiClient.defaultReceiveTimeout, equals(100000));
      });
    });
  });
}
