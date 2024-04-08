import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:starterkit_app/core/presentation/view_models/initializable.dart';
import 'package:starterkit_app/core/presentation/views/view_model_provider.dart';
import 'package:starterkit_app/core/service_locator.dart';

class AutoViewModelBuilder<TViewModel extends Object> extends StatelessWidget {
  final Widget Function(BuildContext context, TViewModel viewModel)? builder;
  final Object Function()? initializationParameter;
  final void Function(BuildContext context, TViewModel viewModel)? dispose;
  final Widget? child;

  const AutoViewModelBuilder({
    this.builder,
    this.child,
    this.initializationParameter,
    this.dispose,
    super.key,
  })  : assert(builder != null || child != null, 'builder or child must be provided'),
        assert(builder == null || child == null, 'only one of builder or child must be provided');

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TViewModel>(
      create: (_) => ServiceLocator.get<TViewModel>(),
      builder: (BuildContext context, TViewModel viewModel) {
        return builder?.call(context, viewModel) ?? child!;
      },
      initializationParameter: initializationParameter,
      dispose: dispose,
    );
  }
}

class ViewModelBuilder<TViewModel> extends StatefulWidget {
  const ViewModelBuilder({
    required this.create,
    required this.builder,
    this.initializationParameter,
    this.dispose,
    super.key,
  });

  final TViewModel Function(BuildContext context) create;
  final Widget Function(BuildContext context, TViewModel viewModel) builder;
  final Object Function()? initializationParameter;
  final void Function(BuildContext context, TViewModel viewModel)? dispose;

  @override
  State<StatefulWidget> createState() => _ViewModelBuilderState<TViewModel>();
}

class _ViewModelBuilderState<TViewModel> extends State<ViewModelBuilder<TViewModel>> {
  TViewModel? _currentViewModel;

  TViewModel get _viewModel {
    if (_currentViewModel == null) {
      throw StateError('ViewModel is not initialized');
    }

    return _currentViewModel!;
  }

  @override
  void initState() {
    super.initState();

    final TViewModel viewModel = widget.create(context);

    if (viewModel is Initializable) {
      final Object? parameter = widget.initializationParameter?.call();
      unawaited(viewModel.onInitialize(parameter));
    }

    _currentViewModel = viewModel;
  }

  @override
  void dispose() {
    widget.dispose?.call(context, _viewModel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<TViewModel>(
      viewModel: _viewModel,
      child: widget.builder(context, _viewModel),
    );
  }
}
