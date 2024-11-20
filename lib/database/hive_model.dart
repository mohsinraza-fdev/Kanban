abstract class HiveModel<T> {
  T get primaryKey;

  Map<String, dynamic> toJson();
}
