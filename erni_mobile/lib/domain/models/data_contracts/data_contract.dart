// coverage:ignore-file

import 'package:erni_mobile_core/json.dart';
import 'package:meta/meta.dart';

export 'package:json_annotation/json_annotation.dart';

@immutable
abstract class DataContract extends JsonEncodable {
  const DataContract();
}
