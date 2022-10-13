# Reflection

`dart:mirrors` is disabled in Flutter (more info [here](https://docs.flutter.dev/resources/faq#does-flutter-come-with-a-reflection--mirrors-system)). To use reflection features, the project includes the package [reflectable](https://pub.dev/packages/reflectable).

This package provides support for reflection which may be tailored to cover certain reflective features and omit others, thus reducing the resource requirements at run time.

## Scenario

The project uses `reflectable` on the view models. It extracts the query parameters from the current route and assigns the value to matchning annotated members.

```dart
@injectable
@reflectable
class MyViewModel extends ViewModel {
  @QueryParam('id')
  String? id;
}
```

Read more about passing parameters [here](ui/navigation.md#passing-parameter).