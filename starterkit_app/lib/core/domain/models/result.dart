import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

sealed class Result<T> {
  const Result({required this.isSuccess});

  final bool isSuccess;
}

final class Success<T> extends Result<T> with EquatableMixin {
  const Success(this.value) : super(isSuccess: true);

  final T value;

  @protected
  @override
  List<Object?> get props => <Object?>[isSuccess, value];
}

final class Failure<T> extends Result<T> {
  const Failure(this.exception, [this.stackTrace]) : super(isSuccess: false);

  final Exception exception;
  final StackTrace? stackTrace;
}
