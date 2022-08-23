// coverage:ignore-file

import 'package:erni_mobile_blueprint_core/json.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BaseException extends JsonEncodable implements Exception {
  const BaseException();
}
