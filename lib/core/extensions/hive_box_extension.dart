import 'package:hive/hive.dart';

extension HiveBoxExtensions<T> on Box<T> {
  Future<void> putAllSafe(Map<dynamic, T> entries) async {
    // Batch updates in chunks to prevent memory issues with large datasets
    const chunkSize = 500;

    for (var i = 0; i < entries.length; i += chunkSize) {
      final chunk = Map.fromEntries(
        entries.entries.skip(i).take(chunkSize),
      );
      await putAll(chunk);
    }
  }
}
