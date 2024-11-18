import 'package:flutter/material.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/features/dashboard/dashboard_view_model.dart';
import 'package:kanban_app/features/dashboard/widgets/nav_bar.dart';

class DashboardView extends CoreView<DashboardViewModel> {
  const DashboardView({super.key});

  @override
  Widget buildView(BuildContext context, DashboardViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SizedBox.shrink(),
          ),
          const NavBar(),
        ],
      ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) {
    return DashboardViewModel();
  }
}
