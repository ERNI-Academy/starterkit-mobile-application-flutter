// coverage:ignore-file

import 'package:erni_mobile/domain/models/json/json_encodable.dart';
import 'package:meta/meta.dart';

export 'package:json_annotation/json_annotation.dart';

@immutable
abstract class DataContract extends JsonEncodable {
  const DataContract();
}
