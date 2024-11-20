import 'package:flutter/material.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';

class AppRadioButton extends StatelessWidget {
  final double size;
  final bool isSelected;
  final VoidCallback? onTap;

  const AppRadioButton({
    super.key,
    this.size = 20,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: size,
        width: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppTheme.colors(context).surface.withOpacity(0),
          shape: BoxShape.circle,
          border: _border(context),
        ),
      ),
    );
  }

  BoxBorder _border(BuildContext context) {
    switch (isSelected) {
      case true:
        return Border.all(
          width: (size / 3).truncate().toDouble(),
          color: AppTheme.colors(context).primary,
        );
      case false:
        return Border.all(
          width: 2,
          color: AppTheme.colors(context).border,
        );
    }
  }
}
