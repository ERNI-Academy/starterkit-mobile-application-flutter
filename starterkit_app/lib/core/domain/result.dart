typedef Result<T> = _Result<T, Exception>;

sealed class _Result<T, E extends Exception> {
  final bool isSuccess;

  _Result({required this.isSuccess});
}

final class Success<T, E extends Exception> extends _Result<T, E> {
  final T value;

  Success(this.value) : super(isSuccess: true);
}

final class Failure<T, E extends Exception> extends _Result<T, E> {
  final E error;
  final StackTrace? stackTrace;

  Failure(this.error, [this.stackTrace]) : super(isSuccess: false);
}
