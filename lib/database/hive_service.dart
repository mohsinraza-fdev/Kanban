import 'package:hive_flutter/hive_flutter.dart';
import 'package:kanban_app/database/hive_model.dart';

class HiveService {
  Future<void> initialise() async {
    await Hive.initFlutter();
  }

  String _getBoxName<T>() => T.toString().toLowerCase();

  Future<T> save<T extends HiveModel>(T value) async {
    final box = await Hive.openBox(_getBoxName<T>());
    await box.put(value.primaryKey, value.toJson());
    return value;
  }

  Future<List<T>> saveAll<T extends HiveModel>(List<T> values) async {
    if (values.isEmpty) return [];

    final box = await Hive.openBox(_getBoxName<T>());
    final entries = {for (var value in values) value.primaryKey: value.toJson()};

    await box.putAll(entries);
    return values;
  }

  Future<T?> get<T extends HiveModel>(
    dynamic key,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final box = await Hive.openBox(_getBoxName<T>());
    final json = box.get(key);
    if (json == null) return null;
    return fromJson(Map<String, dynamic>.from(json));
  }

  Future<List<T>> getAll<T extends HiveModel>(
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final box = await Hive.openBox(_getBoxName<T>());
    return box.values.map((json) => fromJson(Map<String, dynamic>.from(json))).toList();
  }

  Future<bool> delete<T extends HiveModel>(dynamic key) async {
    final box = await Hive.openBox(_getBoxName<T>());
    if (!box.containsKey(key)) return false;
    await box.delete(key);
    return true;
  }

  Future<void> deleteAll<T extends HiveModel>() async {
    final box = await Hive.openBox(_getBoxName<T>());
    await box.clear();
  }
}
