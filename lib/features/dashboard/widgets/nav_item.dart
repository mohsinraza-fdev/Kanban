import 'package:flutter/material.dart';
import 'package:kanban_app/shared/theme/app_colors.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final bool isDisabled;
  final bool isSelected;
  final VoidCallback? onTap;
  const NavItem({
    super.key,
    required this.icon,
    this.isDisabled = false,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDisabled,
      child: GestureDetector(
        onTap: onTap,
        child: Opacity(
          opacity: isDisabled ? 0.6 : 1,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isSelected ? AppTheme.colors(context).primary : Colors.transparent,
            ),
            child: Icon(
              icon,
              size: 24,
              color: isSelected ? AppColors.white : AppTheme.colors(context).secondary,
            ),
          ),
        ),
      ),
    );
  }
}
