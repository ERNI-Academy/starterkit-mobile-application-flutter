import 'package:flutter/widgets.dart' hide View;
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/core/presentation/views/view.dart';
import 'package:starterkit_app/core/presentation/views/view_life_cycle_handler.dart';
import 'package:starterkit_app/core/presentation/views/view_model_builder.dart';

mixin ViewRouteMixin<TViewModel extends ViewModel> implements View<TViewModel> {
  @mustCallSuper
  Widget build(BuildContext context) {
    return ViewModelBuilder<TViewModel>(
      create: () {
        final TViewModel viewModel = onCreateViewModel(context);
        ViewLifeCycleHandler.tryGetNavigationParams(context, viewModel);

        return viewModel;
      },
      builder: buildView,
      dispose: onDisposeViewModel,
    );
  }

  @protected
  @override
  @mustCallSuper
  TViewModel onCreateViewModel(BuildContext context) {
    return ViewLifeCycleHandler.onCreateViewModel<TViewModel>(context, getNavigationParams: true);
  }

  @protected
  @override
  @mustCallSuper
  void onDisposeViewModel(BuildContext context, TViewModel viewModel) {
    ViewLifeCycleHandler.onDisposeViewModel(context, viewModel);
  }
}
