import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class PreferenceService with ListenableServiceMixin {
  late final SharedPreferences instance;

  initialise() async {
    instance = await SharedPreferences.getInstance();
  }

  Future<bool> clear() async {
    return await instance.clear();
  }
}

class PreferenceKeys {
  static String get accessToken => 'access-token-key';
}
