import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_observer.dart';
import 'package:starterkit_app/core/presentation/view_models/app_life_cycle_aware_mixin.dart';
import 'package:starterkit_app/core/presentation/view_models/disposable.dart';
import 'package:starterkit_app/core/presentation/view_models/first_renderable.dart';
import 'package:starterkit_app/core/presentation/view_models/initializable.dart';
import 'package:starterkit_app/core/presentation/view_models/route_aware_mixin.dart';
import 'package:starterkit_app/core/presentation/views/view_model_provider.dart';
import 'package:starterkit_app/core/service_locator.dart';

typedef ViewModelWidgetBuilder<TViewModel> = Widget Function(BuildContext context, TViewModel viewModel);

class AutoViewModelBuilder<TViewModel extends Object> extends StatelessWidget {
  final ViewModelWidgetBuilder<TViewModel> builder;
  final void Function(BuildContext context, TViewModel viewModel)? onCreate;
  final void Function(BuildContext context, TViewModel viewModel)? onDispose;

  const AutoViewModelBuilder({
    required this.builder,
    this.onCreate,
    this.onDispose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TViewModel>(
      create: (BuildContext context) {
        final TViewModel viewModel = ServiceLocator.get<TViewModel>();
        onCreate?.call(context, viewModel);

        return viewModel;
      },
      builder: builder,
      onDispose: onDispose,
    );
  }
}

class ViewModelBuilder<TViewModel> extends StatefulWidget {
  final TViewModel Function(BuildContext context) create;
  final ViewModelWidgetBuilder<TViewModel> builder;
  final void Function(BuildContext context, TViewModel viewModel)? onDispose;

  const ViewModelBuilder({
    required this.create,
    required this.builder,
    this.onDispose,
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
  void initState() {
    super.initState();

    final TViewModel viewModel = widget.create(context);

    if (viewModel is AppLifeCycleAwareMixin) {
      WidgetsBinding.instance.addObserver(viewModel.appLifeCycleObserver);
    }

    if (viewModel is FirstRenderable) {
      WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(viewModel.onFirstRender()));
    }

    if (viewModel is Initializable) {
      final Object? parameter = context.routeData.args;
      unawaited(_tryInitializeViewModel(viewModel, parameter));
    }

    _currentViewModel = viewModel;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final TViewModel viewModel = _viewModel; // assign to local variable to allow type promotion
    final ModalRoute<Object?>? route = ModalRoute.of(context);

    if (viewModel is RouteAwareMixin && route != null) {
      final NavigationObserver navigationObserver = ServiceLocator.get<NavigationObserver>();
      navigationObserver.unsubscribe(viewModel);
      navigationObserver.subscribe(viewModel, route);
    }
  }

  @override
  void dispose() {
    final TViewModel viewModel = _viewModel; // assign to local variable to allow type promotion

    if (viewModel is RouteAwareMixin) {
      final NavigationObserver navigationObserver = ServiceLocator.get<NavigationObserver>();
      navigationObserver.unsubscribe(viewModel);
    }

    if (viewModel is AppLifeCycleAwareMixin) {
      WidgetsBinding.instance.removeObserver(viewModel.appLifeCycleObserver);
    }

    if (viewModel is Disposable) {
      viewModel.dispose();
    }

    widget.onDispose?.call(context, _viewModel);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<TViewModel>(
      viewModel: _viewModel,
      child: widget.builder(context, _viewModel),
    );
  }

  static Future<void> _tryInitializeViewModel(Initializable initializable, Object? parameter) async {
    try {
      await initializable.onInitialize(parameter);
    } on TypeError {
      throw StateError('Failed to initialize ViewModel ${initializable.runtimeType} with parameter: $parameter');
    }
  }
}
