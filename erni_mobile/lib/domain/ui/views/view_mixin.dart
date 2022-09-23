import 'package:erni_mobile/business/services/ui/navigation/navigation_observer.dart';
import 'package:erni_mobile/dependency_injection.dart';
import 'package:erni_mobile/domain/ui/view_models/app_lifecycle_aware_mixin.dart';
import 'package:erni_mobile/domain/ui/view_models/route_aware_mixin.dart';
import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:erni_mobile/domain/ui/views/view.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Configures a [StatelessWidget] or [State] as a view.
///
/// This will locate and initialize the view model [TViewModel], then it can be used to build the layout.
abstract class ViewMixin<TViewModel extends ViewModel> implements View<TViewModel> {
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    return ListenableProvider<TViewModel>(
      create: (_) => onCreateViewModel(context),
      dispose: onDisposeViewModel,
      builder: (context, child) {
        final viewModel = context.watch<TViewModel>();

        return buildView(context, viewModel);
      },
    );
  }

  @protected
  @override
  @mustCallSuper
  TViewModel onCreateViewModel(BuildContext context) {
    final viewModel = ServiceLocator.instance<TViewModel>();
    final route = ModalRoute.of(context);

    if (route != null && viewModel is RouteAwareMixin) {
      NavigationObserver.instance.subscribe(viewModel, route);
    }

    if (viewModel is AppLifeCycleAwareMixin) {
      WidgetsBinding.instance.addObserver(viewModel.appLifeCycleObserver);
    }

    _initializeViewModel(viewModel, route?.settings.name, route?.settings.arguments);

    return viewModel;
  }

  @protected
  @override
  @mustCallSuper
  void onDisposeViewModel(BuildContext context, TViewModel viewModel) {
    viewModel.dispose();

    if (viewModel is RouteAwareMixin) {
      NavigationObserver.instance.unsubscribe(viewModel);
    }

    if (viewModel is AppLifeCycleAwareMixin) {
      WidgetsBinding.instance.removeObserver(viewModel.appLifeCycleObserver);
    }
  }

  static void _initializeViewModel<TViewModel extends ViewModel>(
    TViewModel viewModel,
    String? routeName,
    Object? parameter,
  ) {
    final queries = <String, String>{};

    if (routeName != null) {
      final routeUri = Uri.parse(routeName);
      queries.addAll(routeUri.queryParameters);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => viewModel.onFirstRender(parameter, queries));
    viewModel.onInitialize(parameter, queries);
  }
}

/// Configures a [StatelessWidget] or [State] as a child view of another.
///
/// Provides the view model [TViewModel] that is located in the parent view.
abstract class ChildViewMixin<TViewModel extends ViewModel> implements View<TViewModel> {
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: onCreateViewModel,
      dispose: onDisposeViewModel,
      builder: (context, child) {
        final viewModel = context.watch<TViewModel>();

        return buildView(context, viewModel);
      },
    );
  }

  @protected
  @override
  @mustCallSuper
  TViewModel onCreateViewModel(BuildContext context) => Provider.of<TViewModel>(context, listen: false);

  @protected
  @override
  void onDisposeViewModel(BuildContext context, TViewModel viewModel) {}
}
