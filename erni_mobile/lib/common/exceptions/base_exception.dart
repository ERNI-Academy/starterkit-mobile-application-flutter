// coverage:ignore-file

import 'package:erni_mobile/domain/models/json/json_encodable_mixin.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BaseException with JsonEncodableMixin implements Exception {
  const BaseException();
}
