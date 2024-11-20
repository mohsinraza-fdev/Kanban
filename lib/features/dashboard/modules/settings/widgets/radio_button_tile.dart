import 'package:flutter/material.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/widgets/app_radio_button.dart';

class RadioButtonTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;
  const RadioButtonTile({
    super.key,
    required this.title,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.r16(AppTheme.colors(context).text),
              ),
            ),
            const SizedBox(width: 8),
            AppRadioButton(
              isSelected: isSelected,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
