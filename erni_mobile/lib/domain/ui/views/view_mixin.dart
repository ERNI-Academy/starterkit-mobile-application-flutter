import 'package:auto_route/auto_route.dart';
import 'package:erni_mobile/business/services/ui/navigation/navigation_observer.dart';
import 'package:erni_mobile/dependency_injection.dart';
import 'package:erni_mobile/domain/ui/view_models/app_lifecycle_aware_mixin.dart';
import 'package:erni_mobile/domain/ui/view_models/route_aware_mixin.dart';
import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:erni_mobile/domain/ui/views/view.dart';
import 'package:erni_mobile/reflection.dart';
import 'package:flutter/widgets.dart';
import 'package:reflectable/reflectable.dart';

/// Configures a [StatelessWidget] or [State] as a view.
///
/// This will locate and initialize the view model [TViewModel], then it can be used to build the layout.
abstract class ViewMixin<TViewModel extends ViewModel> implements View<TViewModel> {
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    return _ViewModelBuilder<TViewModel>(
      create: () => onCreateViewModel(context),
      dispose: onDisposeViewModel,
      builder: (context, viewModel) {
        _tryGetQueryParams(context, viewModel);

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

    _initializeViewModel(context, viewModel);

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

  static void _initializeViewModel<TViewModel extends ViewModel>(BuildContext context, TViewModel viewModel) {
    _tryGetQueryParams(context, viewModel);
    WidgetsBinding.instance.addPostFrameCallback((_) => viewModel.onFirstRender());
    viewModel.onInitialize();
  }

  static void _tryGetQueryParams<TViewModel extends ViewModel>(BuildContext context, TViewModel viewModel) {
    if (reflectable.canReflect(viewModel) && reflectable.canReflectType(TViewModel)) {
      final route = context.routeData;
      final instanceMirror = reflectable.reflect(viewModel);
      final typeMirror = reflectable.reflectType(TViewModel) as ClassMirror;

      Map<String, Object?>.from(route.queryParams.rawMap).forEach((key, value) {
        bool predicate(DeclarationMirror element) => element.metadata.any((m) => m is QueryParam && m.name == key);

        if (typeMirror.declarations.values.any(predicate)) {
          final matchingDeclaration = typeMirror.declarations.values.firstWhere(predicate);
          instanceMirror.invokeSetter(matchingDeclaration.simpleName, value);
        }
      });
    }
  }
}

/// Configures a [StatelessWidget] or [State] as a child view of another.
///
/// Provides the view model [TViewModel] that is located in the parent view.
abstract class ChildViewMixin<TViewModel extends ViewModel> implements View<TViewModel> {
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    return _ViewModelBuilder<TViewModel>(
      create: () => onCreateViewModel(context),
      dispose: onDisposeViewModel,
      builder: buildView,
    );
  }

  @protected
  @override
  @mustCallSuper
  TViewModel onCreateViewModel(BuildContext context) => ViewModel.of<TViewModel>(context);

  @protected
  @override
  void onDisposeViewModel(BuildContext context, TViewModel viewModel) {}
}

class ViewModelHolder<T extends ViewModel> extends InheritedWidget {
  const ViewModelHolder({
    super.key,
    required super.child,
    required this.viewModel,
  });

  final T viewModel;

  static ViewModelHolder<T>? of<T extends ViewModel>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ViewModelHolder<T>>();
  }

  @override
  bool updateShouldNotify(ViewModelHolder<T> oldWidget) {
    return false;
  }
}

class _ViewModelBuilder<TViewModel extends ViewModel> extends StatefulWidget {
  const _ViewModelBuilder({
    required this.create,
    required this.builder,
    this.dispose,
    super.key,
  });

  final TViewModel Function() create;
  final Widget Function(BuildContext, TViewModel) builder;
  final void Function(BuildContext, TViewModel)? dispose;

  @override
  State<StatefulWidget> createState() => _ViewModelBuilderState<TViewModel>();
}

class _ViewModelBuilderState<TViewModel extends ViewModel> extends State<_ViewModelBuilder<TViewModel>> {
  late final TViewModel _currentViewModel;

  @override
  void initState() {
    super.initState();

    _currentViewModel = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _currentViewModel,
      builder: (context, child) {
        return ViewModelHolder<TViewModel>(
          viewModel: _currentViewModel,
          child: widget.builder(context, _currentViewModel),
        );
      },
    );
  }

  @override
  void dispose() {
    widget.dispose?.call(context, _currentViewModel);
    super.dispose();
  }
}
