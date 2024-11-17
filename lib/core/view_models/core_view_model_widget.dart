import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

abstract class CoreViewModelWidget<T extends ChangeNotifier>
    extends ViewModelWidget<T> {
  const CoreViewModelWidget({
    super.key,
    super.reactive = true,
  });
}
