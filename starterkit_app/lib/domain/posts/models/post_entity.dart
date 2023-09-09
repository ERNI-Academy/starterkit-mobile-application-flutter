import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_entity.freezed.dart';

@freezed
class PostEntity with _$PostEntity {
  static const PostEntity empty = PostEntity(
    userId: 0,
    id: 0,
    title: '',
    body: '',
  );

  const factory PostEntity({
    required int userId,
    required int id,
    required String title,
    required String body,
  }) = _PostEntity;
}
