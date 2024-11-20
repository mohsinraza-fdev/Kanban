import 'package:flutter/material.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';

double screenWidth(BuildContext context, {double multiplier = 1}) => MediaQuery.of(context).size.width * multiplier;
double screenHeight(BuildContext context, {double multiplier = 1}) => MediaQuery.of(context).size.height * multiplier;
double screenBottomPadding(BuildContext context) => MediaQuery.of(context).padding.bottom;
double statusBarHeight(BuildContext context) => MediaQuery.of(context).padding.top;

bool isKeyboardOpen(BuildContext context) => MediaQuery.of(context).viewInsets.bottom > 10;

Color taskStatusColor(BuildContext context, TaskStatus status) {
  return switch (status) {
    TaskStatus.open => AppTheme.colors(context).primary,
    TaskStatus.inProgress => AppTheme.colors(context).inProgress,
    TaskStatus.done => AppTheme.colors(context).done,
  };
}

String formatDuration(int seconds) {
  final hours = seconds ~/ 3600;
  final minutes = (seconds % 3600) ~/ 60;
  final remainingSeconds = seconds % 60;

  if (hours > 0) {
    if (minutes > 0) {
      return '$hours hr $minutes min';
    }
    return '$hours hr';
  }

  if (minutes > 0) {
    if (remainingSeconds > 0) {
      return '$minutes min $remainingSeconds sec';
    }
    return '$minutes min';
  }

  return '$remainingSeconds sec';
}
