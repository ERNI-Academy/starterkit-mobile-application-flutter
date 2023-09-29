The project uses [`flutter_gen`](https://pub.dev/packages/flutter_gen) package that generates files under `resources` folder.  This will map to the files we added in the project's `assets` folder.

Given that you have the following folder structure:

```
- assets
  - graphics
    - ic_erni_logo.png
- lib
```

And you imported in your `pubspec.yaml` the following:

```yaml
flutter:
  assets:
    - assets/graphics/
```

You can now use the generated `Assets` class to access the files in the `assets/graphics` folder.

```dart
import 'package:starterkit_app/common/resources/assets.gen.dart';

@override
Widget buildView(BuildContext context, SplashViewModel viewModel) {
  return Scaffold(
    appBar: AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: Center(
      child: Assets.graphics.icLogo.image(width: 128), // conveniently get `assets/graphics/icLogo.png`
    ),
    extendBodyBehindAppBar: true,
  );
}
```

The package uses `build_runner`, read more about code generation [here](code-generation).