import 'package:flutter/material.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';

class AppChip extends StatelessWidget {
  final AppChipSize size;
  final String label;
  final TextStyle? labelStyle;
  final VoidCallback? onTap;
  final double? iconSize;
  final Widget? leading;
  final Widget? trailing;
  final Color? color;
  final double borderWidth;
  final double borderRadius;
  final Color? borderColor;

  const AppChip({
    super.key,
    required this.size,
    required this.label,
    this.labelStyle,
    this.onTap,
    this.iconSize,
    this.leading,
    this.trailing,
    this.color,
    this.borderWidth = 1,
    this.borderRadius = 100,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _height,
        padding: _padding,
        decoration: BoxDecoration(
          color: color ?? Colors.transparent,
          border: Border.all(
            width: borderWidth,
            color: borderColor ?? Theme.of(context).colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              leading!,
              if (size == AppChipSize.medium) const SizedBox(width: 4),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                label,
                style: labelStyle ?? _defaultLabelStyle(context),
              ),
            ),
            if (trailing != null) ...[
              if (size == AppChipSize.medium) const SizedBox(width: 4),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }

  double get _height => size == AppChipSize.small ? 24 : 32;

  EdgeInsetsGeometry get _padding => EdgeInsets.symmetric(
        horizontal: size == AppChipSize.small ? 4 : 8,
      );

  TextStyle _defaultLabelStyle(BuildContext context) {
    return (size == AppChipSize.small
        ? AppTextStyles.r10(AppTheme.colors(context).secondary)
        : AppTextStyles.r12(AppTheme.colors(context).secondary));
  }
}

enum AppChipSize {
  small,
  medium,
}
