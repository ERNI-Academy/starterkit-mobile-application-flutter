import 'package:flutter/widgets.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';

abstract interface class View<TViewModel extends ViewModel> {
  Widget buildView(BuildContext context, TViewModel viewModel);

  TViewModel onCreateViewModel(BuildContext context);

  void onDisposeViewModel(BuildContext context, TViewModel viewModel);
}
