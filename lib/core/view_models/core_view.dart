import 'package:flutter/material.dart';
import 'package:kanban_app/core/view_models/core_view_model_base.dart';
import 'package:stacked/stacked.dart';

abstract class CoreView<T extends CoreViewModelBase> extends StackedView<T> {
  const CoreView({super.key});

  // Build
  Widget buildView(BuildContext context, T viewModel, Widget? child);

  @override
  Widget builder(BuildContext context, T viewModel, Widget? child) {
    viewModel.setViewModelContext(context);
    return buildView(context, viewModel, child);
  }

  // Initialize
  @override
  void onViewModelReady(T viewModel) {
    viewModel.initialise();
    super.onViewModelReady(viewModel);
  }
}
