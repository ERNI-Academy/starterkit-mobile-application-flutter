# Views

A view is a collection of visible elements that receives user inputs.

```dart
@Named(RouteNames.splash)
@Injectable(as: Widget)
class SplashView extends StatelessWidget with ViewMixin<SplashViewModel> {
  const SplashView() : super(key: const Key(RouteNames.splash));

  @override
  Widget buildView(BuildContext context, SplashViewModel viewModel) {
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

- `@Named` is part of `injectable`, meaning that this class can be resolved using a constant string value. In this case, the name will be the `RouteName.splash`. Later on, the same constant value will be used if we want to navigate to this route. More details about navigation [here](navigation.md).
- `@Injectable` is used to tell `injectable` that this will be resolved as the type `Widget`, and an new instance is returned everytime it is resolved.

:bulb: **<span style="color: green">TIP</span>**

Use the snippet shortcut `vsl` to create a view using a `StatelessWidget`, and `vsf` to use `StatefulWidget`.

### ViewMixin and ChildViewMixin

`ViewMixin` is used when a view is the main presenter (i.e. the current route). Using this will always resolve a new view model.

Use `ChildViewMixin` if you want a view to be a child of a parent view. This will look-up the nearest `TViewModel` above the tree.

:exclamation: **<span style="color: red">DON'T</span>**

Do not use two `ViewMixin` when trying to split your view:

```dart
@Named(RouteNames.login)
@Injectable(as: Widget)
class LoginView extends StatelessWidget with ViewMixin<LoginViewModel> {
  const LoginView() : super(key: const Key(RouteNames.login));

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
  const _LoginFormSection({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context, LoginViewModel viewModel) {
    ...
  }
}

class _RegisterForgotPasswordSection extends StatelessWidget with ViewMixin<LoginViewModel> { // DON'T!
  const _RegisterForgotPasswordSection({Key? key}) : super(key: key);

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
  const _LoginFormSection({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context, LoginViewModel viewModel) {
    ...
  }
}

class _RegisterForgotPasswordSection extends StatelessWidget with ChildViewMixin<LoginViewModel> { // DO
  const _RegisterForgotPasswordSection({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context, LoginViewModel viewModel) {
    ...
  }
}
```

### Lifecycle

```dart
@Named(RouteNames.splash)
@Injectable(as: Widget)
class SplashView extends StatelessWidget with ViewMixin<SplashViewModel> {
  const SplashView() : super(key: const Key(RouteNames.splash));

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
        child: Assets.graphics.icErniLogo.image(width: 128),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
```

- `onCreateViewModel`, similar to `State.initState`, is called only once. Override this method in your view to do additional initialization logic that depends on the view model.
- `onDisposeViewModel`, similar to `State.dispose`, is called when `ViewModel.dispose` was called, this happens when the view is removed from the tree. Override this method to do cleanup in your view.
