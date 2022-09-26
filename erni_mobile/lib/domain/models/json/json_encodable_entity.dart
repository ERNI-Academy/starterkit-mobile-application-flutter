import 'package:erni_mobile/domain/models/entity.dart';
import 'package:erni_mobile/domain/models/json/json_encodable_mixin.dart';
import 'package:meta/meta.dart';

@immutable
abstract class JsonEncodableEntity with JsonEncodableMixin implements Entity {
  const JsonEncodableEntity();
}
