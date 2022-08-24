// coverage:ignore-file

import 'package:erni_mobile/domain/models/entities/entity.dart';
import 'package:erni_mobile_core/json.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CodableEntity extends JsonEncodable implements Entity {
  const CodableEntity();
}
