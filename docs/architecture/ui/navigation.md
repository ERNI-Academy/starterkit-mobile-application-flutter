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

Get the passed parameter and query using `ViewModel.onInitialize`.

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
## Pop Navigation

Pop current route named `/user/verify?lang=en` and return `true` to previous route.

```dart
await navigation.pop(true);
```