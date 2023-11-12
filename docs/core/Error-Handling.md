The `Result` pattern is a design pattern used to represent the outcome of an operation in a way that explicitly handles success and failure scenarios.

In the provided code, the `Result` pattern is implemented using a sealed class hierarchy:

```dart
sealed class Result<T> {
  const Result({required this.isSuccess});

  final bool isSuccess;
}
```

- `Result` is an abstract class with a single boolean property `isSuccess`. This property indicates whether the operation represented by the result was successful (`true`) or not (`false`).
- `Result` is marked as `sealed`, meaning it cannot be extended outside of its library. This allows us to use exhaustive pattern-matching using `switch-case` statements when handling the results.

Two concrete subclasses of `Result` are defined: `Success` and `Failure`.

```dart
final class Success<T> extends Result<T> {
  const Success(this.value) : super(isSuccess: true);

  final T value;
}
```

- `Success` represents a successful outcome and contains a value of type `T`. It extends `Result` and sets `isSuccess` to `true`.

```dart
final class Failure<T> extends Result<T> {
  const Failure(this.exception, [this.stackTrace]) : super(isSuccess: false);

  final Exception exception;
  final StackTrace? stackTrace;
}
```

- `Failure` represents a failure and contains an exception (and an optional stack trace) indicating why the operation failed. It extends `Result` and sets `isSuccess` to `false`.

## Usage

For example, the following function returns a `Result` instance:

```dart
Future<Result<PostEntity>> execute(int id) async {
  try {
    final PostEntity post = await _postRepository.getPost(id);

    return Success<PostEntity>(post);
  } catch (e, st) {
    return Failure<PostEntity>(Exception(e), st);
  }
}
```

- If the operation succeeds, the function returns a `Success` instance containing the post.
- If the operation fails, the function returns a `Failure` instance containing the exception and stack trace.

The caller can then handle the result as follows:

```dart
final Result<PostEntity> getPostResult = await _getPostUseCase.execute(postId);

switch (getPostResult) {
  case Success<PostEntity>():
    _post.value = getPostResult.value;

  case Failure<PostEntity>(exception: final SomeException exception):
    // Handle `SomeException` here.
    _logger.log(LogLevel.error, 'Failed to get post', exception);

  case Failure<PostEntity>():
    // It is implied that the exception is `Exception`.
    _logger.log(LogLevel.error, 'Failed to get post', getPostResult.exception, getPostResult.stackTrace);
}
```

- Since `Result` is `sealed`, we can pattern-match using an exhaustive `switch-case` statement. This ensures that all possible cases are handled.


## Benefits of the Result Pattern:

1. **Explicit Handling:** Forces developers to explicitly handle success and failure cases, reducing the likelihood of ignoring error conditions.

2. **No Unchecked Exceptions:** Unlike traditional exception handling, the `Result` pattern doesn't rely on unchecked exceptions, which can lead to runtime errors. Instead, it encapsulates the success or failure state in a well-defined structure.

3. **Immutable:** The `Result` instances are immutable, meaning their state cannot be changed once they are created. This helps in ensuring consistency and avoiding unexpected modifications.

4. **Type-Safe:** The type parameter `T` allows the `Result` instances to carry a specific type of value, ensuring type safety throughout the code.
