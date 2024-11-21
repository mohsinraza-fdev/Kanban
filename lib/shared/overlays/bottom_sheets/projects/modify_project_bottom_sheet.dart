import 'package:flutter/material.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/utils/ui_helpers.dart';
import 'package:kanban_app/shared/widgets/app_button.dart';
import 'package:kanban_app/shared/widgets/app_input_field.dart';

class ModifyProjectBottomSheet extends StatefulWidget {
  final String? id;
  final String name;
  final Future<bool> Function(String name) onConfirm;
  const ModifyProjectBottomSheet({
    super.key,
    this.id,
    required this.name,
    required this.onConfirm,
  });

  @override
  State<ModifyProjectBottomSheet> createState() => _ModifyProjectBottomSheetState();
}

class _ModifyProjectBottomSheetState extends State<ModifyProjectBottomSheet> {
  late final controller = TextEditingController(text: widget.name);
  final focusNode = FocusNode();

  bool isLoading = false;
  bool get isPromaryButtonEnabled => controller.text.isNotEmpty;

  _confirm(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await widget.onConfirm(controller.text);
      if (res == true && context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      null;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.colors(context).surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(12),
          ),
          border: Border.all(
            width: 1,
            color: AppTheme.colors(context).border,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.id == null ? 'Create Project' : 'Update Project',
                      style: AppTextStyles.m18(AppTheme.colors(context).text),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: AppTheme.colors(context).text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AppInputField.text(
                controller: controller,
                focusNode: focusNode,
                hint: 'Enter project name',
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 20),
              AppButton.primary(
                size: AppButtonSize.large,
                width: double.maxFinite,
                label: widget.id == null ? 'Create' : 'Update',
                isLoading: isLoading,
                isDisabled: !isPromaryButtonEnabled,
                onTap: () => _confirm(context),
              ),
              SizedBox(height: isKeyboardOpen(context) ? 24 : 40),
            ],
          ),
        ),
      ),
    );
  }
}
