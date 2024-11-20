import 'package:flutter/material.dart';
import 'package:kanban_app/shared/assets_gen/assets.gen.dart';
import 'package:kanban_app/shared/theme/app_colors.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';

class ErrorSnackbar extends StatelessWidget {
  final String? title;
  final String message;
  final VoidCallback? onTap;

  const ErrorSnackbar({
    super.key,
    this.title,
    required this.message,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: title == null ? 8 : 12,
          ),
          decoration: BoxDecoration(
            color: AppTheme.colors(context).critical,
            borderRadius: BorderRadius.circular(8),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 6,
                color: Colors.black.withOpacity(0.08),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Assets.icons.info.image(
                  width: 24,
                  height: 24,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: AppTextStyles.m14(AppColors.white),
                      ),
                    Text(
                      message,
                      style: AppTextStyles.l12(AppColors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
