import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kanban_app/network/client/client_utils.dart';
import 'package:kanban_app/network/interceptors/on_error_interceptor.dart';
import 'package:kanban_app/network/interceptors/on_request_interceptor.dart';
import 'package:kanban_app/network/interceptors/on_response_interceptor.dart';

abstract class ApiClientBase {
  String get baseUrl;

  int get defaultConnectTimeout;

  int get defaultReceiveTimeout;

  final Dio client;

  ApiClientBase(this.client);

  void initialise() {
    client.options
      ..baseUrl = baseUrl
      ..validateStatus = isStatusCodeValid
      ..connectTimeout = Duration(milliseconds: defaultConnectTimeout)
      ..receiveTimeout = Duration(milliseconds: defaultConnectTimeout);
    client.interceptors.addAll([
      OnRequestInterceptor(),
      OnResponseInterceptor(),
      OnErrorInterceptor(),
    ]);
  }

  @protected
  Future<T?> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  @protected
  Future<T?> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  @protected
  Future<T?> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  @protected
  Future<T?> patch<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  @protected
  Future<T?> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });
}
