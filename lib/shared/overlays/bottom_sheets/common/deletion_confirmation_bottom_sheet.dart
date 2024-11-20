import 'package:flutter/material.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/widgets/app_button.dart';

class DeletionConfirmationBottomSheet extends StatefulWidget {
  final String title;
  final Future<bool> Function() onDelete;
  const DeletionConfirmationBottomSheet({
    super.key,
    required this.title,
    required this.onDelete,
  });

  @override
  State<DeletionConfirmationBottomSheet> createState() => _DeletionConfirmationBottomSheetState();
}

class _DeletionConfirmationBottomSheetState extends State<DeletionConfirmationBottomSheet> {
  bool isDeleting = false;

  _delete(BuildContext context) async {
    setState(() {
      isDeleting = true;
    });
    try {
      final res = await widget.onDelete();
      if (res == true && context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      null;
    }
    setState(() {
      isDeleting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.colors(context).surface,
          borderRadius: BorderRadius.circular(12),
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
                      widget.title,
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
              Text(
                'Are you sure that you wish to delete? This action is irreversable',
                style: AppTextStyles.r14(AppTheme.colors(context).text),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton.outline(
                    label: 'Cancel',
                    size: AppButtonSize.medium,
                    onTap: Navigator.of(context).pop,
                  ),
                  const SizedBox(width: 8),
                  AppButton.danger(
                    size: AppButtonSize.medium,
                    label: 'Delete',
                    isLoading: isDeleting,
                    onTap: () => _delete(context),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
