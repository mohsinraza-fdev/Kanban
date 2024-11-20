import 'package:flutter/material.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/features/dashboard/dashboard_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/home/home_view.dart';
import 'package:kanban_app/features/dashboard/modules/settings/settings_view.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_view.dart';
import 'package:kanban_app/features/dashboard/modules/time_tracker/time_tracker_view.dart';
import 'package:kanban_app/features/dashboard/widgets/nav_bar.dart';

class DashboardView extends CoreView<DashboardViewModel> {
  const DashboardView({super.key});

  @override
  Widget buildView(BuildContext context, DashboardViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _getViewFromNavIndex(viewModel.selectedIndex),
          ),
          const NavBar(),
        ],
      ),
    );
  }

  Widget _getViewFromNavIndex(int index) {
    return switch (index) {
      0 => const HomeView(),
      1 => const TaskBoardView(),
      2 => const TimeTrackerView(),
      3 => const SettingsView(),
      _ => const SizedBox.shrink(),
    };
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) {
    return DashboardViewModel();
  }
}
