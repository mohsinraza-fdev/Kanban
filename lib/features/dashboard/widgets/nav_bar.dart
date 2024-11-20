import 'package:flutter/material.dart';
import 'package:kanban_app/core/view_models/core_view_model_widget.dart';
import 'package:kanban_app/features/dashboard/dashboard_view_model.dart';
import 'package:kanban_app/features/dashboard/widgets/nav_item.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/utils/ui_helpers.dart';

class NavBar extends CoreViewModelWidget<DashboardViewModel> {
  const NavBar({
    super.key,
  });

  final icons = const [
    Icons.home_rounded,
    Icons.task_alt,
    Icons.timer_rounded,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Container(
      height: 64 + screenBottomPadding(context),
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: screenBottomPadding(context)),
      decoration: BoxDecoration(
        color: AppTheme.colors(context).surface,
        border: Border.all(
          width: 1,
          color: AppTheme.colors(context).border,
        ),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...List.generate(icons.length, (index) {
            return NavItem(
              icon: icons[index],
              isDisabled: viewModel.selectedProject == null && [1, 2].contains(index),
              isSelected: viewModel.selectedIndex == index,
              onTap: () => viewModel.setIndex(index),
            );
          }),
        ],
      ),
    );
  }
}
