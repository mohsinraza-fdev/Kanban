import 'package:flutter/material.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/sheets/deletion_confirmation_bottom_sheet.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/sheets/modify_project_bottom_sheet.dart';
import 'package:stacked_services/stacked_services.dart';

class AppBottomSheetService {
  showModifyProjectBottomSheet({
    String? id,
    required String name,
    required Future<bool> Function(String name) onConfirm,
  }) async {
    final context = StackedService.navigatorKey?.currentContext;
    if (context == null) return;
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ModifyProjectBottomSheet(
          id: id,
          name: name,
          onConfirm: onConfirm,
        ),
      ),
    );
  }

  showDeleteConfirmationBottomSheet({
    required String title,
    required Future<bool> Function() onDelete,
  }) async {
    final context = StackedService.navigatorKey?.currentContext;
    if (context == null) return;
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DeletionConfirmationBottomSheet(
          title: title,
          onDelete: onDelete,
        ),
      ),
    );
  }
}
