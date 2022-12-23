// coverage:ignore-file

import 'package:erni_mobile/domain/models/json/json_encodable_mixin.dart';
import 'package:meta/meta.dart';

@immutable
abstract class JsonEncodable with JsonEncodableMixin {
  const JsonEncodable();
}
