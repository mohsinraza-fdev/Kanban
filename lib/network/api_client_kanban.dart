import 'package:kanban_app/network/client/api_client.dart';
import 'package:kanban_app/network/endpoints_kanban.dart';

class ApiClientKanban extends ApiClient {
  ApiClientKanban(super.client);

  @override
  String get baseUrl => EndpointsKanban.baseUrl;

  @override
  int get defaultConnectTimeout => const Duration(seconds: 100).inMilliseconds;

  @override
  int get defaultReceiveTimeout => const Duration(seconds: 100).inMilliseconds;
}
