// coverage:ignore-file

import 'package:erni_mobile/domain/models/json/json_encodable_mixin.dart';
import 'package:meta/meta.dart';

export 'package:json_annotation/json_annotation.dart';

@immutable
abstract class DataContract with JsonEncodableMixin {
  const DataContract();
}
