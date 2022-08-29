// coverage:ignore-file

import 'package:erni_mobile/domain/models/json/json_encodable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BaseException extends JsonEncodable implements Exception {
  const BaseException();
}
