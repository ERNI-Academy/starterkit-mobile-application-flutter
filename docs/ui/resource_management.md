# Resource Management

```dart
import 'package:starterkit_app/core/resources/assets.gen.dart';

@override
Widget buildView(BuildContext context, SplashViewModel viewModel) {
  return Scaffold(
    appBar: AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: Center(
      child: Assets.graphics.icErniLogo.image(width: 128), // conveniently get `assets/graphics/ic_erni_logo.png`
    ),
    extendBodyBehindAppBar: true,
  );
}
```

The project uses [`flutter_gen`](https://pub.dev/packages/flutter_gen) package that generates files under `resources` folder.  This will map to the files we added in the project's `assets` folder.

The package uses `build_runner`, read more about code generation [here](../../code_generation.md).