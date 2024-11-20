import 'package:flutter/material.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/utils/ui_helpers.dart';

class PrimaryAppBar extends StatelessWidget {
  final Widget? leading;
  final String title;
  final List<Widget> actions;
  const PrimaryAppBar({
    super.key,
    this.leading,
    required this.title,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64 + statusBarHeight(context),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: statusBarHeight(context), left: 16, right: 16),
      decoration: BoxDecoration(
        color: AppTheme.colors(context).surface,
        border: Border.all(
          width: 1,
          color: AppTheme.colors(context).border,
        ),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.sb22(AppTheme.colors(context).text),
            ),
          ),
          if (actions.isNotEmpty) ...[const SizedBox(width: 8), ...actions]
        ],
      ),
    );
  }
}
