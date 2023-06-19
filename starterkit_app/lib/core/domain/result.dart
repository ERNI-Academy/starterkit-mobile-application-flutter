sealed class Result<T> {
  final bool isSuccess;

  const Result({required this.isSuccess});
}

final class Success<T> extends Result<T> {
  final T value;

  const Success(this.value) : super(isSuccess: true);
}

final class Failure<T> extends Result<T> {
  final Exception error;
  final StackTrace? stackTrace;

  const Failure(this.error, [this.stackTrace]) : super(isSuccess: false);
}
