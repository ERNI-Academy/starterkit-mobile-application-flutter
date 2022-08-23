# Views and View Models

## Views

```dart
@Named(RouteNames.splash)
@Injectable(as: Widget)
class SplashView extends StatelessWidget with ViewMixin<SplashViewModel> {
  SplashView() : super(key: const Key(RouteNames.splash));

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Assets.graphics.icErniLogo.image(width: 128),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
```

- Contains the UI.
- `@Named` is part of `injectable`, meaning that this class can be resolved using a constant string value. In this case, the name will be the `RouteName.splash`. Later on, the same constant value will be used if we want to navigate to this route. More details about navigation [here](navigation.md).
- `@Injectable` is used to tell `injectable` that this will be resolved as the type `Widget`, and an new instance is returned everytime it is resolved.

:bulb: **<span style="color: green">TIP</span>**

Use the snippet shortcut `vsl` to create a view using a `StatelessWidget`, and `vsf` to use `StatefulWidget`.

### ViewMixin and ChildViewMixin

[`ViewMixin`](../../../erni_mobile/lib/core/views/base/view.dart) is used when a view is the main presenter (i.e. the current route). Using this will always resolve a new view model.

Use [`ChildViewMixin`](../../../erni_mobile/lib/core/views/base/view.dart) if you want a view to be a child of a parent view. This will look-up the nearest `TViewModel` above the tree.

:exclamation: **<span style="color: red">DON'T</span>**

Do not use two `ViewMixin` when trying to split your view:

```dart
@Named(RouteNames.login)
@Injectable(as: Widget)
class LoginView extends StatelessWidget with ViewMixin<LoginViewModel> {
  LoginView() : super(key: const Key(RouteNames.login));

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(l10n.loginTitle)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 512),
            child: SpacedColumn(
              spacing: 16,
              children: [
                _LoginFormSection(),
                _RegisterForgotPasswordSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginFormSection extends StatelessWidget with ViewMixin<LoginViewModel> { // DON'T!
  _LoginFormSection({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    ...
  }
}

class _RegisterForgotPasswordSection extends StatelessWidget with ViewMixin<LoginViewModel> { // DON'T!
  _RegisterForgotPasswordSection({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    ...
  }
}
```

:bulb: **<span style="color: green">DO</span>**

Use `ChildViewMixin` instead for `_LoginFormSection` and `_RegisterForgotPasswordSection`:

```dart
class _LoginFormSection extends StatelessWidget with ChildViewMixin<LoginViewModel> { // DO
  _LoginFormSection({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    ...
  }
}

class _RegisterForgotPasswordSection extends StatelessWidget with ChildViewMixin<LoginViewModel> { // DO
  _RegisterForgotPasswordSection({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    ...
  }
}
```

### Lifecycle

```dart
@Named(RouteNames.splash)
@Injectable(as: Widget)
class SplashView extends StatelessWidget with ViewMixin<SplashViewModel> {
  SplashView() : super(key: const Key(RouteNames.splash));

  @override
  SplashViewModel onCreateViewModel(BuildContext context) {
    // Optionally override this method to do other initialization on the view/view model
    return super.onCreateViewModel(context);
  }

  @override
  void onDisposeViewModel(BuildContext context, SplashViewModel viewModel) {
    // Optionally override this method for cleanup
    super.onDisposeViewModel(context, viewModel);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Assets.graphics.icErniLogo.image(width: 128),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
```

- `onCreateViewModel`, similar to `State.initState`, is called only once. Override this method in your view to do additional initialization logic that depends on the view model.
- `onDisposeViewModel`, similar to `State.dispose`, is called when `ViewModel.dispose` was called, this happens when the view is removed from the tree. Override this method to do cleanup in your view.

## View Models

```dart
@injectable
class SplashViewModel extends ViewModel {
  @override
  Future<void> onInitialize([Object? parameter, Queries queries = const {}]) async {
    // your initialization logic, use parameters if any
  }
}
```

- Contains the state of the UI.
- The `ViewModel` class inherits from `ChangeNotifier`.
- A new instance is returned always whenever we resolve a view model.
- Use `onInitialize` to extract the parameters passed during navigation. More details about navigation [here](navigation.md).

:bulb: **<span style="color: green">TIP</span>**

Use the snippet shortcut `vm` to create a view model class.

:warning: **<span style="color: orange">AVOID</span>**

You can call `notifyListeners` and this will trigger a rebuild of the whole UI. This is equivalent of calling `setState` when using a `StatefulWidget`.

Use `notifyListeners` sparingly and only in situations where you really need it.

```dart
@injectable
class SplashViewModel extends ViewModel {
  bool isInitialized = false;
  
  @override
  Future<void> onInitialize([Object? parameter, Queries queries = const {}]) async {
    isInitialized = true;
    notifyListeners();
  }
}
```

Read more about the project's state management approach [here](state_management.md).

### Lifecycle

- `onInitialize` is called only once. Navigation parameters are passed here. More details about navigation [here](navigation.md).
- `dispose` is called whenever the view to which this view model is attached to is removed from the tree.

:bulb: **<span style="color: green">TIP</span>**

Use the snippet shortcut `initVm` for overriding `onInitialize`, and `dis` for `dispose`.


### Observing App Lifecycle

You can mix `AppLifeCycleAwareMixin` to your `ViewModel` class. It implements the [`WidgetsBindingObserver`](https://api.flutter.dev/flutter/widgets/WidgetsBindingObserver-class.html).

You can observe app lifecylce changes by overriding the following:

```dart
@protected
Future<void> onAppPaused() {
  // do something when app is paused
}

@protected
Future<void> onAppResumed() {
  // do something when app is resumed
}
```