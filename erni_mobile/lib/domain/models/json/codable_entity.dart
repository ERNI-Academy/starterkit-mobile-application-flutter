// coverage:ignore-file

import 'package:erni_mobile/domain/models/entity.dart';
import 'package:erni_mobile/domain/models/json/json_encodable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CodableEntity extends JsonEncodable implements Entity {
  const CodableEntity();
}
