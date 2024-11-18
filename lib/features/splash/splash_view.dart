import 'package:flutter/material.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/features/splash/splash_view_model.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';

class SplashView extends CoreView<SplashViewModel> {
  const SplashView({super.key});

  @override
  Widget buildView(BuildContext context, SplashViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.track_changes,
                size: 56,
                color: AppTheme.colors(context).primary,
              ),
              const SizedBox(width: 4),
              Text(
                'KANBAN',
                style: AppTextStyles.sb56(AppTheme.colors(context).primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  SplashViewModel viewModelBuilder(BuildContext context) {
    return SplashViewModel();
  }
}
