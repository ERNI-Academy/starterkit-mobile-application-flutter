import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:starterkit_app/core/presentation/view_models/app_life_cycle_aware_mixin.dart';
import 'package:starterkit_app/core/presentation/view_models/disposable.dart';
import 'package:starterkit_app/core/presentation/view_models/first_renderable.dart';
import 'package:starterkit_app/core/presentation/view_models/initializable.dart';
import 'package:starterkit_app/core/presentation/views/view_model_provider.dart';
import 'package:starterkit_app/core/service_locator.dart';

typedef ViewModelWidgetBuilder<TViewModel> = Widget Function(BuildContext context, TViewModel viewModel);

class AutoViewModelBuilder<TViewModel extends Object> extends StatelessWidget {
  final ViewModelWidgetBuilder<TViewModel>? builder;
  final Object Function()? initializeWith;
  final void Function(BuildContext context, TViewModel viewModel)? dispose;
  final Widget? child;

  const AutoViewModelBuilder({
    this.builder,
    this.child,
    this.initializeWith,
    this.dispose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TViewModel>(
      create: (_) => ServiceLocator.get<TViewModel>(),
      builder: (BuildContext context, TViewModel viewModel) {
        if (builder case final ViewModelWidgetBuilder<TViewModel> builder) {
          return builder(context, viewModel);
        }

        if (child case final Widget child) {
          return child;
        }

        throw StateError('builder or child must be provided');
      },
      initializeWith: initializeWith,
      dispose: dispose,
    );
  }
}

class ViewModelBuilder<TViewModel> extends StatefulWidget {
  final TViewModel Function(BuildContext context) create;

  final ViewModelWidgetBuilder<TViewModel> builder;
  final Object Function()? initializeWith;
  final void Function(BuildContext context, TViewModel viewModel)? dispose;
  const ViewModelBuilder({
    required this.create,
    required this.builder,
    this.initializeWith,
    this.dispose,
    super.key,
  });

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
  Widget build(BuildContext context) {
    return ViewModelProvider<TViewModel>(
      viewModel: _viewModel,
      child: widget.builder(context, _viewModel),
    );
  }

  @override
  void dispose() {
    if (_viewModel case AppLifeCycleAwareMixin(:final WidgetsBindingObserver appLifeCycleObserver)) {
      WidgetsBinding.instance.removeObserver(appLifeCycleObserver);
    }

    if (_viewModel case final Disposable disposable) {
      disposable.dispose();
    }

    widget.dispose?.call(context, _viewModel);

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final TViewModel viewModel = widget.create(context);

    if (viewModel case AppLifeCycleAwareMixin(:final WidgetsBindingObserver appLifeCycleObserver)) {
      WidgetsBinding.instance.addObserver(appLifeCycleObserver);
    }

    if (viewModel case final FirstRenderable firstRenderable) {
      WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(firstRenderable.onFirstRender()));
    }

    if (viewModel case final Initializable initializable) {
      final Object? parameter = widget.initializeWith?.call();
      unawaited(_tryInitilizeViewModel(initializable, parameter));
    }

    _currentViewModel = viewModel;
  }

  static Future<void> _tryInitilizeViewModel(Initializable initializable, Object? parameter) async {
    try {
      await initializable.onInitialize(parameter);
    } on TypeError {
      throw StateError('Failed to initialize ViewModel ${initializable.runtimeType} with parameter: $parameter');
    }
  }
}
