import 'package:erni_mobile_core/src/mvvm/inputs/command.dart';

abstract class RelayCommand<T extends Object> extends Command<T> {
  RelayCommand();

  factory RelayCommand.withoutParam(void Function() execute) {
    return _RelayCommandImplWithoutParams(execute) as RelayCommand<T>;
  }

  factory RelayCommand.withParam(void Function(T?) execute) {
    return _RelayCommandImplWithParams(execute);
  }
}

class _RelayCommandImplWithoutParams extends RelayCommand<Object> {
  _RelayCommandImplWithoutParams(this._execute);

  final void Function() _execute;

  @override
  void call([Object? parameter]) {
    if (canExecute.value) {
      _execute();
    }
  }
}

class _RelayCommandImplWithParams<T extends Object> extends RelayCommand<T> {
  _RelayCommandImplWithParams(this._execute);

  final void Function(T?) _execute;

  @override
  void call([T? parameter]) {
    if (canExecute.value) {
      _execute(parameter);
    }
  }
}
