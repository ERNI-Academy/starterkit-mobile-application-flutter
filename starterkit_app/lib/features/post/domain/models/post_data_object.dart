import 'package:isar/isar.dart';
import 'package:starterkit_app/core/domain/models/data_object.dart';

part 'post_data_object.g.dart';

@Collection(accessor: 'posts')
class PostDataObject extends DataObject {
  PostDataObject({
    required this.postId,
    required this.userId,
    required this.title,
    required this.body,
  });

  @Index(unique: true)
  final int postId;

  final int userId;

  final String title;

  final String body;
}
