import 'package:erni_mobile_core/src/mvvm/inputs/async_command.dart';

abstract class AsyncRelayCommand<T extends Object> extends AsyncCommand<T> {
  AsyncRelayCommand();

  factory AsyncRelayCommand.withoutParam(Future<void> Function() execute) {
    return _AsyncRelayCommandImplWithoutParams(execute) as AsyncRelayCommand<T>;
  }

  factory AsyncRelayCommand.withParam(Future<void> Function(T?) execute) {
    return _AsyncRelayCommandImplWithParams(execute);
  }
}

class _AsyncRelayCommandImplWithoutParams extends AsyncRelayCommand<Object> {
  _AsyncRelayCommandImplWithoutParams(this._execute);

  final Future<void> Function() _execute;

  @override
  Future<void> call([Object? parameter]) async {
    if (canExecute.value) {
      await _internalExecute();
    }
  }

  Future<void> _internalExecute() async {
    try {
      isExecuting.value = true;
      await _execute();
    } finally {
      isExecuting.value = false;
    }
  }
}

class _AsyncRelayCommandImplWithParams<T extends Object> extends AsyncRelayCommand<T> {
  _AsyncRelayCommandImplWithParams(this._execute);

  final Future<void> Function(T?) _execute;

  @override
  Future<void> call([T? parameter]) async {
    if (canExecute.value) {
      await _internalExecute(parameter);
    }
  }

  Future<void> _internalExecute([T? parameter]) async {
    try {
      isExecuting.value = true;
      await _execute(parameter);
    } finally {
      isExecuting.value = false;
    }
  }
}
