import 'package:kanban_app/core/view_models/core_view_model.dart';

class DashboardViewModel extends CoreViewModel {
  int selectedIndex = 0;
  setIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }
}
