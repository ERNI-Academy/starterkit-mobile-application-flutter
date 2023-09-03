import 'package:isar/isar.dart';
import 'package:starterkit_app/core/domain/models/data_object.dart';

part 'post_data_object.g.dart';

@Collection(accessor: 'posts')
class PostDataObject implements DataObject {
  PostDataObject({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  int id;

  int userId;
  String title;
  String body;
}
