import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kanban_app/network/client/client_utils.dart';

class OnRequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      "Authorization": 'Bearer c88dea1445f5374897729a0a8bedb712fc79df3c',
    });
    log('Request\nEndpoint:${options.path}');
    log('--> REQUEST HEADERS <--');
    logJson(options.headers);
    log('--> REQUEST BODY <--');
    logJson(options.data);
    super.onRequest(options, handler);
  }
}
