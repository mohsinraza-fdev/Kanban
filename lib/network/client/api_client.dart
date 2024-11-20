import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:kanban_app/network/client/client_utils.dart';
import 'package:kanban_app/network/exceptions/client_exception.dart';

import 'api_client_base.dart';

abstract class ApiClient extends ApiClientBase {
  ApiClient(super.client);

  @override
  Future<T> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await client.get(
        endpoint,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        options: options,
      );
      if (response.data is T) {
        log('ApiClient - Get - Response Valid\nEndpoint:$endpoint\nStatusCode:${response.statusCode}');
        if (options?.responseType != ResponseType.bytes) {
          logJson(response.data);
        }
        return (response.data as T);
      }
      log('ApiClient - Get - Invalid Response From Server\nEndpoint:$endpoint');
      logJson(response.data);
      throw (const ClientException(message: 'Something went wrong', statusCode: -1));
    } on SocketException {
      throw (const ClientException(message: 'Please check your internet connection', statusCode: -1));
    } on ClientException {
      rethrow;
    } on DioException catch (e) {
      throw (e.error ?? e.message ?? "");
    } catch (e) {
      log('ApiClient - Get - Unexpected Exception\nException: "${e.toString()}"');
      throw (const ClientException(message: 'Something went wrong', statusCode: -1));
    }
  }

  @override
  Future<T> post<T>(String endpoint,
      {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    try {
      Response response = await client.post(
        endpoint,
        data: data,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.data is T) {
        log('ApiClient - Post - Response Valid\nEndpoint:$endpoint\nStatusCode:${response.statusCode}');
        logJson(response.data);
        return (response.data as T);
      }
      log('ApiClient - Post - Invalid Response From Server\nEndpoint:$endpoint');
      logJson(response.data);
      throw (const ClientException(message: 'Something went wrong', statusCode: -1));
    } on SocketException {
      throw (const ClientException(message: 'Please check your internet connection', statusCode: -1));
    } on ClientException catch (e) {
      log('ApiClient - Post - ClientException\nException: "${e.message}"');
      rethrow;
    } on DioException catch (e) {
      throw (e.error ?? e.message ?? "");
    } catch (e) {
      log('ApiClient - Post - Unexpected Exception\nException: "${e.toString()}"');
      throw (const ClientException(message: 'Something went wrong', statusCode: -1));
    }
  }

  @override
  Future<T> put<T>(String endpoint,
      {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    try {
      Response response = await client.put(
        endpoint,
        data: data,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.data is T) {
        log('ApiClient - Post - Response Valid\nEndpoint:$endpoint\nStatusCode:${response.statusCode}');
        logJson(response.data);
        return (response.data as T);
      }
      log('ApiClient - Post - Invalid Response From Server\nEndpoint:$endpoint');
      logJson(response.data);
      throw (const ClientException(message: 'Something went wrong', statusCode: -1));
    } on SocketException {
      throw (const ClientException(message: 'Please check your internet connection', statusCode: -1));
    } on ClientException catch (e) {
      log('ApiClient - Post - ClientException\nException: "${e.message}"');
      rethrow;
    } on DioException catch (e) {
      throw (e.error ?? e.message ?? "");
    } catch (e) {
      log('ApiClient - Post - Unexpected Exception\nException: "${e.toString()}"');
      throw (const ClientException(message: 'Something went wrong', statusCode: -1));
    }
  }

  @override
  Future<T> patch<T>(String endpoint,
      {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    try {
      Response response = await client.patch(
        endpoint,
        data: data,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        options: options,
      );
      if (response.data is T) {
        log('ApiClient - Patch - Response Valid\nEndpoint:$endpoint\nStatusCode:${response.statusCode}');
        logJson(response.data);
        return (response.data as T);
      }
      log('ApiClient - Patch - Invalid Response From Server\nEndpoint:$endpoint');
      logJson(response.data);
      throw (const ClientException(message: 'Something went wrong', statusCode: -1));
    } on SocketException {
      throw (const ClientException(message: 'Please check your internet connection', statusCode: -1));
    } on ClientException catch (e) {
      print(e.message);
      rethrow;
    } on DioException catch (e) {
      throw (e.error ?? e.message ?? "");
    } catch (e) {
      log('ApiClient - Patch - Unexpected Exception\nException: "${e.toString()}"');
      throw (const ClientException(message: 'Something went wrong', statusCode: -1));
    }
  }

  @override
  Future<T> delete<T>(String endpoint,
      {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    try {
      Response response = await client.delete(
        endpoint,
        data: data,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        options: options,
      );
      if (response.data is T) {
        log('ApiClient - Delete - Response Valid\nEndpoint:$endpoint\nStatusCode:${response.statusCode}');
        logJson(response.data);
        return (response.data as T);
      }
      log('ApiClient - Delete - Invalid Response From Server\nEndpoint:$endpoint');
      logJson(response.data);
      throw (const ClientException(message: 'Something went wrong', statusCode: -1));
    } on SocketException {
      throw (const ClientException(message: 'network_error', statusCode: -1));
    } on ClientException {
      rethrow;
    } on DioException catch (e) {
      throw (e.error ?? e.message ?? "");
    } catch (e) {
      log('ApiClient - Delete - Unexpected Exception\nException: "${e.toString()}"');
      throw (const ClientException(message: 'Something went wrong', statusCode: -1));
    }
  }
}
