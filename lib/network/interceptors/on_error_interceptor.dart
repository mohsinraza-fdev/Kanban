import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kanban_app/network/client/client_utils.dart';
import 'package:kanban_app/network/exceptions/cancelled_request_exception.dart';
import 'package:kanban_app/network/exceptions/client_exception.dart';
import 'package:kanban_app/network/exceptions/server_exception.dart';

class OnErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.error is ClientException) {
      handler.next(err);
      return;
    }
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      log('onErrorInterceptor - Request timed out\nEndpoint: ${err.requestOptions.path}');
      err = err.copyWith(
          error: ClientException(
        message: 'connection_timed_out',
        statusCode: err.response?.statusCode ?? -1,
        responseData: err.response?.data,
      ));
      handler.next(err);
      return;
    }
    if (err.type == DioExceptionType.cancel) {
      log('onErrorInterceptor - Request Cancelled\nEndpoint: ${err.requestOptions.path}');
      err = err.copyWith(error: const CancelledRequestException(message: 'request_cancelled'));
      handler.next(err);
      return;
    }
    if (err.type == DioExceptionType.badResponse) {
      if (isResponseValid(err.response!)) {
        log('onErrorInterceptor - Valid Response\nEndpoint: ${err.requestOptions.path}\nStatusCode: ${err.response?.statusCode}');
        log('--> REQUEST HEADERS <--');
        logJson(err.requestOptions.headers);
        log('--> REQUEST BODY <--');
        logJson(err.requestOptions.data);
        log('--> RESPONSE <--');
        logJson(err.response?.data ?? '<null>');
        err = err.copyWith(
          error: ServerException(
            message: err.response?.data['message'] ?? 'invalid_error',
            statusCode: err.response?.statusCode ?? -1,
            responseData: err.response?.data,
          ),
        );
        handler.next(err);
        return;
      }
      log('onErrorInterceptor - Invalid Response\nEndpoint: ${err.requestOptions.path}\nStatusCode: ${err.response?.statusCode}\nMessage: ${err.message}');
      log('--> REQUEST HEADERS <--');
      logJson(err.requestOptions.headers);
      log('--> REQUEST BODY <--');
      logJson(err.requestOptions.data);
      log('--> RESPONSE <--');
      logJson(err.response?.data ?? '<null>');
      err = err.copyWith(
        error: ServerException(
          message: "Something went wrong",
          statusCode: err.response?.statusCode ?? -1,
        ),
      );
      handler.next(err);
      return;
    }
    if (err.type == DioExceptionType.unknown &&
        ((err.message?.contains('FormatException') ?? false) ||
            (err.message?.contains('No host specified in URI') ?? false))) {
      log('please make sure Base url is valid - ${err.message}');
      err = err.copyWith(
          error: ClientException(
        message: "Something went wrong",
        statusCode: err.response?.statusCode ?? -1,
      ));
      super.onError(err, handler);
      return;
    }
    if (err.type == DioExceptionType.unknown &&
        ((err.message?.contains('SocketException') ?? false) ||
            (err.message?.contains('No address associated with hostname') ?? false))) {
      err = err.copyWith(
          error: ClientException(
        message: "Please check your internet connection",
        statusCode: err.response?.statusCode ?? -1,
      ));
      super.onError(err, handler);
      return;
    }
    log('onErrorInterceptor - Unhandled Error -> ${err.response?.statusCode} - ${err.message}');
    err = err.copyWith(
        error: ClientException(
      message: "Something went wrong",
      statusCode: err.response?.statusCode ?? -1,
    ));
    super.onError(err, handler);
  }
}
