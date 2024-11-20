import 'package:flutter/material.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';

class CardShell extends StatelessWidget {
  final Widget child;
  const CardShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.colors(context).surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 1,
          color: AppTheme.colors(context).border,
        ),
      ),
      child: child,
    );
  }
}
