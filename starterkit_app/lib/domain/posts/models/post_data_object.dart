import 'package:isar/isar.dart';
import 'package:starterkit_app/core/domain/models/data_object.dart';

part 'post_data_object.g.dart';

@Collection(accessor: 'posts')
class PostDataObject implements DataObject<int> {
  const PostDataObject({required this.userId, required this.id, required this.title, required this.body});

  final int userId;

  @override
  final int id;

  final String title;

  final String body;
}
