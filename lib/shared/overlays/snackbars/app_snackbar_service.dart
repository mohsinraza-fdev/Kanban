import 'package:flutter/material.dart';
import 'package:kanban_app/shared/overlays/snackbars/widgets/error_snackbar.dart';
import 'package:kanban_app/shared/overlays/snackbars/widgets/success_snackbar.dart';
import 'package:stacked_services/stacked_services.dart';

class AppSnackbarService {
  showErrorSnackbar({
    String? title,
    required String message,
    VoidCallback? onTap,
  }) {
    final context = StackedService.navigatorKey?.currentContext;
    if (context == null) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ErrorSnackbar(
          title: title,
          message: message,
          onTap: onTap,
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          left: 0,
          right: 0,
          bottom: 40,
        ),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(milliseconds: 5500),
      ),
    );
  }

  showSuccessSnackbar({
    String? title,
    required String message,
    VoidCallback? onTap,
  }) {
    final context = StackedService.navigatorKey?.currentContext;
    if (context == null) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SuccessSnackbar(
          title: title,
          message: message,
          onTap: onTap,
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          left: 0,
          right: 0,
          bottom: 40,
        ),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(milliseconds: 5500),
      ),
    );
  }
}
