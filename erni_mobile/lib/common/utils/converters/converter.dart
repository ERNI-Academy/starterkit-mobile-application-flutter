// coverage:ignore-file

import 'package:meta/meta.dart';

@immutable
abstract class Converter<T, S> {
  const Converter();

  T convert(S value);

  S convertBack(T value);
}
