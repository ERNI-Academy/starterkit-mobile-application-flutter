A `DataObject` is a class that represents a table in the database.

```dart
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
```

- `@Collection` is used to specify the name of the table in the database. This is needed for Isar to generate the schema.
- `DataObject` has a definition of `id` which its implementation is required in the data object. This is used by Isar to identify the object in the database. We add the type `int` to `DataObject<int>` indicating that the `id` is an integer.