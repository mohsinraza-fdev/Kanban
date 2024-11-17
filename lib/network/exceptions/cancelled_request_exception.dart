class CancelledRequestException implements Exception {
  final String message;

  const CancelledRequestException({
    required this.message,
  });
}
