`dart:mirrors` is disabled in Flutter (more info [here](https://docs.flutter.dev/resources/faq#does-flutter-come-with-a-reflection--mirrors-system)). To use reflection features, the project includes the package [reflectable](https://pub.dev/packages/reflectable).

This package provides support for reflection which may be tailored to cover certain reflective features and omit others, thus reducing the resource requirements at run time.

## Scenarios


### Navigation

The project uses a custom annotation `navigatable` on the view models. It extracts the query parameters from the current route and assigns the value to matching annotated members.

```dart
@injectable
@navigatable
class MyViewModel extends ViewModel {
  @QueryParam('id')
  String? id;
}
```

Read more about passing parameters through navigation [here](navigation#passing-parameter).