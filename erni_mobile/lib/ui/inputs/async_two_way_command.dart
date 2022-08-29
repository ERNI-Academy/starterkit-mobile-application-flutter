import 'package:erni_mobile/ui/inputs/async_command.dart';

abstract class AsyncTwoWayCommand<TIn extends Object, TOut extends Object> extends AsyncCommand<TIn> {
  AsyncTwoWayCommand();

  factory AsyncTwoWayCommand.withoutParam(Future<TOut?> Function() execute) {
    return _AsyncTwoWayCommandImplWithoutParams(execute) as AsyncTwoWayCommand<TIn, TOut>;
  }

  factory AsyncTwoWayCommand.withParam(Future<TOut?> Function(TIn?) execute) {
    return _AsyncTwoWayCommandImplWithParams(execute);
  }

  @override
  Future<TOut?> call([TIn? parameter]);
}

class _AsyncTwoWayCommandImplWithoutParams<TOut extends Object> extends AsyncTwoWayCommand<Object, TOut> {
  _AsyncTwoWayCommandImplWithoutParams(this._execute);

  final Future<TOut?> Function() _execute;

  @override
  Future<TOut?> call([Object? parameter]) async {
    if (canExecute.value) {
      return _internalExecute();
    }

    return null;
  }

  Future<TOut?> _internalExecute() async {
    try {
      isExecuting.value = true;

      return await _execute();
    } finally {
      isExecuting.value = false;
    }
  }
}

class _AsyncTwoWayCommandImplWithParams<TIn extends Object, TOut extends Object> extends AsyncTwoWayCommand<TIn, TOut> {
  _AsyncTwoWayCommandImplWithParams(this._execute);

  final Future<TOut?> Function(TIn?) _execute;

  @override
  Future<TOut?> call([TIn? parameter]) async {
    if (canExecute.value) {
      return _internalExecute(parameter);
    }

    return null;
  }

  Future<TOut?> _internalExecute([TIn? parameter]) async {
    try {
      isExecuting.value = true;

      return await _execute(parameter);
    } finally {
      isExecuting.value = false;
    }
  }
}
