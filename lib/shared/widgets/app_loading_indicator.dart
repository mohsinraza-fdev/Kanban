import 'package:flutter/material.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppTheme.colors(context).primary,
      ),
    );
  }
}
