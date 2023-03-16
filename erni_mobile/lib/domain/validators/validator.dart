import 'package:meta/meta.dart';

@immutable
abstract class Validator<T> {
  const Validator();

  String get errorMessage;

  bool checkIsValid(T value);
}
