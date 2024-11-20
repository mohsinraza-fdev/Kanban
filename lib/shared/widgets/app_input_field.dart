import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';

enum AppInputFieldType {
  text,
  description,
}

class AppInputField extends StatefulWidget {
  final double? height;
  final AppInputFieldType fieldType;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? label;
  final String? hint;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool isDisabled;
  final bool required;
  final int? maxLength;
  final double? horizontalMargin;
  final double? borderRadius;
  final Widget? prefix;
  final Widget? suffix;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final VoidCallback? onFocusOut;

  const AppInputField._({
    super.key,
    this.height,
    required this.fieldType,
    this.textInputAction,
    required this.controller,
    required this.focusNode,
    this.label,
    this.hint,
    this.backgroundColor,
    this.borderColor,
    this.isDisabled = false,
    this.required = false,
    this.maxLength,
    this.horizontalMargin,
    this.borderRadius,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.onSubmit,
    this.onFocusOut,
  });

  factory AppInputField.text({
    Key? key,
    required TextEditingController controller,
    required FocusNode focusNode,
    TextInputAction? textInputAction,
    String? label,
    String? hint,
    Color? backgroundColor,
    Color? borderColor,
    bool isDisabled = false,
    bool required = false,
    int? maxLength,
    double? horizontalMargin,
    Widget? prefix,
    Widget? suffix,
    Function(String)? onChanged,
    Function(String)? onSubmit,
    VoidCallback? onFocusOut,
    double? borderRadius,
  }) {
    return AppInputField._(
      key: key,
      fieldType: AppInputFieldType.text,
      controller: controller,
      focusNode: focusNode,
      textInputAction: textInputAction,
      label: label,
      hint: hint,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      isDisabled: isDisabled,
      required: required,
      maxLength: maxLength,
      horizontalMargin: horizontalMargin,
      prefix: prefix,
      suffix: suffix,
      onChanged: onChanged,
      onSubmit: onSubmit,
      onFocusOut: onFocusOut,
      borderRadius: borderRadius,
    );
  }

  factory AppInputField.description({
    Key? key,
    double? height,
    required TextEditingController controller,
    required FocusNode focusNode,
    TextInputAction? textInputAction,
    String? label,
    String? hint,
    Color? backgroundColor,
    Color? borderColor,
    bool isDisabled = false,
    bool required = false,
    int? maxLength,
    double? horizontalMargin,
    Function(String)? onChanged,
    Function(String)? onSubmit,
    VoidCallback? onFocusOut,
  }) {
    return AppInputField._(
      key: key,
      fieldType: AppInputFieldType.description,
      height: height,
      controller: controller,
      focusNode: focusNode,
      textInputAction: textInputAction,
      label: label,
      hint: hint,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      isDisabled: isDisabled,
      required: required,
      maxLength: maxLength,
      horizontalMargin: horizontalMargin,
      onChanged: onChanged,
      onSubmit: onSubmit,
      onFocusOut: onFocusOut,
    );
  }

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  @override
  void initState() {
    widget.focusNode.addListener(_focusListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalMargin ?? 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Row(
              children: [
                GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(widget.focusNode),
                  child: Text(
                    widget.label!,
                    style: AppTextStyles.m14(AppTheme.colors(context).text),
                  ),
                ),
                if (widget.required)
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Text(
                      '*',
                      style: AppTextStyles.m14(AppTheme.colors(context).primary),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 8),
          ],
          GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(widget.focusNode),
            child: Container(
              height: _height(),
              alignment: _alignment(),
              padding: _padding(),
              decoration: BoxDecoration(
                color: _backgroundColor(),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                border: Border.all(
                  width: 1,
                  color: widget.focusNode.hasFocus
                      ? AppTheme.colors(context).border
                      : AppTheme.colors(context).border.withOpacity(0),
                ),
              ),
              child: _fieldContents(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldContents() {
    switch (widget.fieldType) {
      case AppInputFieldType.text:
        return _buildTextFieldContents();
      case AppInputFieldType.description:
        return _buildDescriptionFieldContents();
    }
  }

  Widget _buildTextFieldContents() {
    return Row(
      children: [
        if (widget.prefix != null) ...[
          widget.prefix!,
          const SizedBox(width: 8),
        ],
        Expanded(
          child: IgnorePointer(
            ignoring: widget.isDisabled,
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              style: AppTextStyles.r14(
                widget.isDisabled ? AppTheme.colors(context).tertiary.withOpacity(0.5) : AppTheme.colors(context).text,
              ),
              onSubmitted: widget.onSubmit,
              inputFormatters: [
                LengthLimitingTextInputFormatter(widget.maxLength),
              ],
              onChanged: widget.onChanged,
              textInputAction: widget.textInputAction,
              maxLines: 1,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: AppTextStyles.r14(
                  AppTheme.colors(context).tertiary,
                ),
              ),
            ),
          ),
        ),
        if (widget.suffix != null) ...[
          const SizedBox(width: 8),
          widget.suffix!,
        ],
      ],
    );
  }

  Widget _buildDescriptionFieldContents() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 2),
      child: IgnorePointer(
        ignoring: widget.isDisabled,
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          maxLines: null,
          textCapitalization: TextCapitalization.sentences,
          style: AppTextStyles.r14(
            widget.isDisabled ? AppTheme.colors(context).tertiary.withOpacity(0.5) : AppTheme.colors(context).text,
          ),
          textInputAction: widget.textInputAction,
          onSubmitted: widget.onSubmit,
          onChanged: widget.onChanged,
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.maxLength),
          ],
          decoration: InputDecoration(
            border: InputBorder.none,
            isCollapsed: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            hintText: widget.hint,
            hintMaxLines: 3,
            hintStyle: AppTextStyles.r14(
              AppTheme.colors(context).tertiary,
            ),
          ),
        ),
      ),
    );
  }

  double? _height() {
    if (widget.fieldType == AppInputFieldType.description) {
      return widget.height ?? 110;
    }
    return 48;
  }

  AlignmentGeometry? _alignment() {
    if (widget.fieldType == AppInputFieldType.description) {
      return Alignment.topLeft;
    }
    return Alignment.center;
  }

  EdgeInsetsGeometry _padding() {
    return const EdgeInsets.symmetric(horizontal: 16);
  }

  Color _backgroundColor() {
    if (widget.isDisabled) {
      return AppTheme.colors(context).surfaceSecondary.withOpacity(0.5);
    }
    return widget.backgroundColor ?? AppTheme.colors(context).surfaceSecondary;
  }

  void _focusListener() {
    if (!widget.focusNode.hasFocus && widget.onFocusOut != null) {
      widget.onFocusOut!();
    }
    setState(() {});
  }
}
