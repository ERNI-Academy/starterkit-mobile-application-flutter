A view is a collection of visible elements that receives user inputs.

### ViewRouteMixin, ViewMixin, and ChildViewMixin

These can be used with `StatelessWidget` or `State`. They provide these three methods that represents the lifecycle of a view:

```dart
abstract interface class View<TViewModel extends ViewModel> {
  Widget buildView(BuildContext context, TViewModel viewModel);

  TViewModel onCreateViewModel(BuildContext context);

  void onDisposeViewModel(BuildContext context, TViewModel viewModel);
}
```

Implementations of the `View` interface are the `ViewRouteMixin`, `ViewMixin`, and `ChildViewMixin`. They use at their very core a combination of `ListenableBuilder` and `InheritedWidget`.

For more information about the implementation details, see `ViewModelBuilder` and `ViewModelHolder` widgets.

### Lifecycle

```dart
@RoutePage()
class SplashView extends StatelessWidget with ViewRouteMixin<SplashViewModel> {
  const SplashView() : super(key: const Key(SplashViewRoute.name));

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
  Widget buildView(BuildContext context, SplashViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Assets.graphics.icAppLogo.image(width: 128),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
```

- `buildView` is called whenever the view needs to be rebuilt. This is called inside the widget's `build` method. You need to override `buildView` rather than the `build` method.
- `onCreateViewModel`, similar to `State.initState`, is called only once. Override this method in your view to do additional initialization logic that depends on the view model.
- `onDisposeViewModel`, similar to `State.dispose`, is called when `ViewModel.dispose` was called, this happens when the view is removed from the tree. Override this method to do cleanup in your view.

#### ViewRouteMixin
It is used when a view is navigatable. Using this will always resolve a new view model.

```dart
@RoutePage()
class SplashView extends StatelessWidget with ViewRouteMixin<SplashViewModel> {
  const SplashView() : super(key: const Key(SplashViewRoute.name));

  @override
  Widget buildView(BuildContext context, SplashViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Assets.graphics.icAppLogo.image(width: 128),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
```

### ViewMixin
It is used when you want a view that is not navigatable, but needs to be a parent view. It will resolve its own view model.

```dart
class HomeView extends StatelessWidget with ViewMixin<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget buildView(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ValueListenableBuilder<int>(
        valueListenable: viewModel.count,
        builder: (context, count, child) {
          return Text('Count value: $count');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### ChildViewMixin
Use this if you want a view to be a child of a view that is a `ViewRouteMixin` or `ViewMixin`. This will look-up the nearest `TViewModel` above the tree.

```dart
@RoutePage()
class LoginView extends StatelessWidget with ViewRouteMixin<LoginViewModel> {
  const LoginView() : super(key: const Key(LoginViewRoute.name));

  @override
  Widget buildView(BuildContext context, LoginViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(title: Text(l10n.loginTitle)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 512),
            child: _LoginFormSection(),
          ),
        ),
      ),
    );
  }
}

class _LoginFormSection extends StatelessWidget with ChildViewMixin<LoginViewModel> { // DO
  const _LoginFormSection({super.key});

  @override
  Widget buildView(BuildContext context, LoginViewModel viewModel) {
    ...
  }
}
```

:bulb: **<span style="color: green">TIP</span>**

- Use the snippet shortcut `vrsl` to create a navigatable view using a `StatelessWidget`. 
- Use the snippet shortcut `vsl` to create a view using a `StatelessWidget`, and `vsf` to use `StatefulWidget`.
- Use the snippet shortcut `cvsl` to create a child view using a `StatelessWidget`.
- Run `build_runner` first before you can reference the route's name as the view's `Key`. See [navigation](navigation) for more details.

:exclamation: **<span style="color: red">DON'T</span>**

Do not use two `ViewRouteMixin` or `ViewMixin` when trying to split your view and still use the same view model:

```dart
@RoutePage()
class LoginView extends StatelessWidget with ViewRouteMixin<LoginViewModel> {
  const LoginView() : super(key: const Key(LoginViewRoute.name));

  @override
  Widget buildView(BuildContext context, LoginViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(title: Text(l10n.loginTitle)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 512),
            child: SpacedColumn(
              spacing: 16,
              children: const [
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

class _LoginFormSection extends StatelessWidget with ViewRouteMixin<LoginViewModel> { // DON'T!
  const _LoginFormSection({super.key});

  @override
  Widget buildView(BuildContext context, LoginViewModel viewModel) {
    ...
  }
}

class _RegisterForgotPasswordSection extends StatelessWidget with ViewRouteMixin<LoginViewModel> { // DON'T!
  const _RegisterForgotPasswordSection({super.key});

  @override
  Widget buildView(BuildContext context, LoginViewModel viewModel) {
    ...
  }
}
```

:bulb: **<span style="color: green">DO</span>**

Use `ChildViewMixin` instead for `_LoginFormSection` and `_RegisterForgotPasswordSection`:

```dart
class _LoginFormSection extends StatelessWidget with ChildViewMixin<LoginViewModel> { // DO
  const _LoginFormSection({super.key});

  @override
  Widget buildView(BuildContext context, LoginViewModel viewModel) {
    ...
  }
}

class _RegisterForgotPasswordSection extends StatelessWidget with ChildViewMixin<LoginViewModel> { // DO
  const _RegisterForgotPasswordSection({super.key});

  @override
  Widget buildView(BuildContext context, LoginViewModel viewModel) {
    ...
  }
}
```

:bulb: **<span style="color: red">IMPORTANT</span>**

When navigating to a view that uses a `Hero` widget, make sure to use `Hero.flightShuttleBuilder`
s `toContext` parameter to get the correct `BuildContext` when resolving the view model:

```dart
class CarDetailsView extends StatelessWidget with ViewRouteMixin<CarDetailsViewModel> {
  CarDetailsView({@carParam Car? car}) : super(key: const Key(CarDetailsViewRoute.name));

  @override
  Widget buildView(BuildContext context, CarDetailsViewModel viewModel) {
    // This is a workaround for the issue with Hero transition when looking up for the ViewModel in the widget tree
    return Hero(
      tag: viewModel.car.hashCode,
      flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
        return _CarDetailsContent(toHeroContext);
      },
      child: _CarDetailsContent(),
    );
  }
}

class _CarDetailsContent extends StatelessWidget with ChildViewMixin<CarDetailsViewModel> {
  _CarDetailsContent([this.context]);

  final BuildContext? context;

  @override
  CarDetailsViewModel onCreateViewModel(BuildContext context) {
    return super.onCreateViewModel(this.context ?? context);
  }

  @override
  Widget buildView(BuildContext context, CarDetailsViewModel viewModel) {
    ...
  }
}
```