# Navigation

The project uses [auto_route](https://pub.dev/packages/auto_route) as the navigation solution. It is based on Flutter's Navigator 2.0 and provides the following feature:

- Declarative routing
- Route guards
- Nested navigation
- Similar API compared to Flutter's Navigator 1.0, including as passing argument and result

See [`NavigationService`](../../mobii/lib/domain/services/ui/navigation/navigation_service.dart) and its implementing class for more details.

## Push Navigation

```dart
final isUserVerified = await navigation.push<bool>(const UserVerificationViewRoute());
```

## Passing Parameter

For example, you want to pass `userId` to `UserVerificationView`.

**Updating a route to receive parameter**

In your view model, annotate it with `@reflectable` and add your parameter:

```dart
const userIdParam = QueryParam('userId');

@reflectable // be sure to annotate your view model using this
class UserVerificationViewModel extends ViewModel {
  @userIdParam
  String? userId;
}
```

And in your view

```dart
class UserVerificationView extends StatelessWidget with ViewRouteMixin<UserVerificationViewModel> {
  const UserVerificationView({@userIdParam String? userId}) : super(key: const Key(UserVerificationViewRoute.name));
}
```

Run `build_runner` and `UserVerificationViewRoute` will have an optional parameter named `userId`.

When navigating and supplying a value to `userId`, `UserVerificationViewModel.userId` will be automatically set.

```dart
final isUserVerified = await navigation.push<bool>(const UserVerificationRoute(userId: 'asda-123-asd'));
```

## Pop Navigation

Pop current route and return `true` to previous route.

```dart
await navigation.pop(true);
```

:bulb: **<span style="color: red">IMPORTANT</span>**

- Be sure to annotate your view model with `@reflectable`
- Be sure to annotate your expected parameter with `@QueryParam('name')` or a custom one