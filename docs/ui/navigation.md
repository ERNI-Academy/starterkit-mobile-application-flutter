#Navigation

## Push Navigation

Push to route named `/user/verify`.

```dart
final isUserVerified = await navigation.push<bool>('/user/verify');
```
## Passing Parameter

Push to route named `/user/verify?lang=en` and pass a `String` parameter.

```dart
const userId = 'asda-123-asd';

// One way
final isUserVerified = await navigation.push<bool>('/user/verify?lang=en', parameter: userId);

// Or
final isUserVerified = await navigation.push<bool>('/user/verify', parameter: userId, queries: {'lang': 'en'});
```

You can get the parameter and queries passed by using either:

- `ViewModel.onInitialize` during initialization

  ```dart
  class UserVerificationViewModel extends ViewModel<String> {
    @override
    Future<void> onInitialize([String? parameter, Queries queries = const {}]) async {
      if (parameter != null) {
        print(parameter); // prints `asda-123-asd`
      }
      if (queries.containsKey('lang')) {
        print(queries['lang']); // prints 'en'
      }
    }
  }
  ```

- `ViewModel.onFirstRender` after the first frame has been rendered by the view

  ```dart
  class UserVerificationViewModel extends ViewModel<String> {
    @override
    Future<void> onFirstRender([String? parameter, Queries queries = const {}]) async {
      ...
    }
  }
  ```
## Pop Navigation

Pop current route named `/user/verify?lang=en` and return `true` to previous route.

```dart
await navigation.pop(true);
```