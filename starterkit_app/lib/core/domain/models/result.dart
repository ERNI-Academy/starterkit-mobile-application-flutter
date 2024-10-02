sealed class Result<T> {
  const Result({required this.isSuccess});

  final bool isSuccess;
}

final class Success<T> extends Result<T> {
  const Success(this.value) : super(isSuccess: true);

  final T value;
}

final class Failure<T> extends Result<T> {
  const Failure(this.exception) : super(isSuccess: false);

  final Exception exception;
}
