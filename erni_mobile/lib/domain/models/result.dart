abstract class Result<T> {
  factory Result.succeeded([T? value]) = _SuccessResult;

  factory Result.failed(Object error, [T? value]) = _FailedResult;

  Result._({required this.value, required this.isSuccess, this.error});

  final T? value;
  final bool isSuccess;
  final Object? error;
}

class _SuccessResult<T> extends Result<T> {
  _SuccessResult([T? value]) : super._(value: value, isSuccess: true);
}

class _FailedResult<T> extends Result<T> {
  _FailedResult(Object error, [T? value]) : super._(value: value, isSuccess: false, error: error);
}
