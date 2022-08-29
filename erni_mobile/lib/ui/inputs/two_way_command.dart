import 'package:erni_mobile/ui/inputs/command.dart';

abstract class TwoWayCommand<TIn extends Object, TOut extends Object> extends Command<TIn> {
  TwoWayCommand();

  factory TwoWayCommand.withoutParam(TOut? Function() execute) {
    return _TwoWayCommandImplWithoutParams(execute) as TwoWayCommand<TIn, TOut>;
  }

  factory TwoWayCommand.withParam(TOut? Function(TIn?) execute) {
    return _TwoWayCommandImplWithParams(execute);
  }

  @override
  TOut? call([TIn? parameter]);
}

class _TwoWayCommandImplWithoutParams<TOut extends Object> extends TwoWayCommand<Object, TOut> {
  _TwoWayCommandImplWithoutParams(this._execute);

  final TOut? Function() _execute;

  @override
  TOut? call([Object? parameter]) {
    if (canExecute.value) {
      return _execute();
    }

    return null;
  }
}

class _TwoWayCommandImplWithParams<TIn extends Object, TOut extends Object> extends TwoWayCommand<TIn, TOut> {
  _TwoWayCommandImplWithParams(this._execute);

  final TOut? Function(TIn?) _execute;

  @override
  TOut? call([TIn? parameter]) {
    if (canExecute.value) {
      return _execute(parameter);
    }

    return null;
  }
}
