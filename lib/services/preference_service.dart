import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class PreferenceService with ListenableServiceMixin {
  late final SharedPreferences instance;

  initialise() async {
    instance = await SharedPreferences.getInstance();
  }

  String? get activeProjectId {
    return instance.getString(PreferenceKeys.activeProjectId);
  }

  Future<bool> setActiveProjectId(String id) async {
    return await instance.setString(PreferenceKeys.activeProjectId, id);
  }

  Future<bool> clear() async {
    return await instance.clear();
  }
}

class PreferenceKeys {
  static String get activeProjectId => 'active-project-id-key';
}
