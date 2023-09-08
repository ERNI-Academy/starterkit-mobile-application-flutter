import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:starterkit_app/core/domain/models/data_object.dart';

part 'post_data_object.freezed.dart';
part 'post_data_object.g.dart';

@Collection(accessor: 'posts')
@freezed
class PostDataObject with _$PostDataObject implements DataObject {
  const factory PostDataObject({
    required int userId,
    required int id,
    required String title,
    required String body,
  }) = _PostDataObject;
}
