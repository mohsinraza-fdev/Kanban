class ClientException implements Exception {
  final String message;
  final int statusCode;
  final Map<String, dynamic>? responseData;

  const ClientException({
    required this.message,
    required this.statusCode,
    this.responseData,
  });
}
