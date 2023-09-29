import 'package:meta/meta.dart';

@optionalTypeArgs
abstract interface class DataObject<T extends Object> {
  T get id;
}
