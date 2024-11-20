import 'package:flutter/material.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final AppButtonType type;
  final AppButtonSize size;
  final double? width;
  final double? height;
  final bool isDisabled;
  final VoidCallback? onTap;
  final String? label;
  final TextStyle? labelStyle;
  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;

  const AppButton._({
    super.key,
    required this.type,
    required this.size,
    this.width,
    this.height,
    this.isDisabled = false,
    this.onTap,
    this.label,
    this.labelStyle,
    this.leading,
    this.trailing,
    this.isLoading = false,
  });

  factory AppButton.primary({
    Key? key,
    required AppButtonSize size,
    double? width,
    double? height,
    bool isDisabled = false,
    VoidCallback? onTap,
    String? label,
    TextStyle? labelStyle,
    Widget? leading,
    Widget? trailing,
    bool isLoading = false,
  }) {
    return AppButton._(
      key: key,
      type: AppButtonType.primary,
      size: size,
      width: width,
      height: height,
      isDisabled: isDisabled,
      onTap: onTap,
      label: label,
      labelStyle: labelStyle,
      leading: leading,
      trailing: trailing,
      isLoading: isLoading,
    );
  }

  factory AppButton.outline({
    Key? key,
    required AppButtonSize size,
    double? width,
    double? height,
    bool isDisabled = false,
    VoidCallback? onTap,
    String? label,
    TextStyle? labelStyle,
    Widget? leading,
    Widget? trailing,
    bool isLoading = false,
  }) {
    return AppButton._(
      key: key,
      type: AppButtonType.outline,
      size: size,
      width: width,
      height: height,
      isDisabled: isDisabled,
      onTap: onTap,
      label: label,
      labelStyle: labelStyle,
      leading: leading,
      trailing: trailing,
      isLoading: isLoading,
    );
  }

  factory AppButton.danger({
    Key? key,
    required AppButtonSize size,
    double? width,
    double? height,
    bool isDisabled = false,
    VoidCallback? onTap,
    String? label,
    TextStyle? labelStyle,
    Widget? leading,
    Widget? trailing,
    bool isLoading = false,
  }) {
    return AppButton._(
      key: key,
      type: AppButtonType.danger,
      size: size,
      width: width,
      height: height,
      isDisabled: isDisabled,
      onTap: onTap,
      label: label,
      labelStyle: labelStyle,
      leading: leading,
      trailing: trailing,
      isLoading: isLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled || isLoading ? null : onTap,
      child: Container(
        height: height ?? _heightFromSize(size),
        width: width,
        padding: _paddingFromSize(size),
        decoration: BoxDecoration(
          color: _backgroundColor(context),
          borderRadius: BorderRadius.circular(100),
          border: _getBorder(context),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: isLoading ? 0 : 1,
              child: SizedBox(
                height: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (leading != null) ...[
                      leading!,
                      const SizedBox(width: 8),
                    ],
                    if (label != null)
                      Text(
                        label!,
                        style: labelStyle ?? _getTextStyle(context),
                      ),
                    if (trailing != null) ...[
                      const SizedBox(width: 8),
                      trailing!,
                    ],
                  ],
                ),
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: Center(
                  child: SizedBox(
                    width: _loadingSize,
                    height: _loadingSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: _textColor(context),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _backgroundColor(BuildContext context) {
    if (isDisabled) return AppTheme.colors(context).tertiary;

    switch (type) {
      case AppButtonType.primary:
        return AppTheme.colors(context).primary;
      case AppButtonType.outline:
        return Colors.transparent;
      case AppButtonType.danger:
        return AppTheme.colors(context).critical;
    }
  }

  Color _textColor(BuildContext context) {
    if (isDisabled) return AppTheme.colors(context).textTertiary;

    switch (type) {
      case AppButtonType.primary:
      case AppButtonType.danger:
        return Colors.white;
      case AppButtonType.outline:
        return AppTheme.colors(context).text;
    }
  }

  Border? _getBorder(BuildContext context) {
    return type == AppButtonType.outline ? Border.all(color: AppTheme.colors(context).border) : null;
  }

  TextStyle _getTextStyle(BuildContext context) {
    final color = _textColor(context);

    switch (size) {
      case AppButtonSize.small:
        return AppTextStyles.m12(color);
      case AppButtonSize.medium:
      case AppButtonSize.large:
        return AppTextStyles.m14(color);
    }
  }

  double get _loadingSize {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  double _heightFromSize(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return 32;
      case AppButtonSize.medium:
        return 40;
      case AppButtonSize.large:
        return 48;
    }
  }

  EdgeInsets _paddingFromSize(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 16);
    }
  }
}

enum AppButtonType {
  primary,
  outline,
  danger,
}

enum AppButtonSize {
  small,
  medium,
  large,
}
