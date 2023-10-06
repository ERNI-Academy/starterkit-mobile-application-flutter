A `DataObject` is a class that represents a table in the database.

```dart
import 'package:isar/isar.dart';

abstract class DataObject {
  @Id()
  int id = 0;
}
```

- Base class of all data objects.
- `@Id` is used to specify the primary key of the table. This is needed for Isar to automatically increment the id of the object.

```dart
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
```

- `@Collection` is used to specify that the annotated class will be created as a schema in the database. The `accessor` parameter is used as the name of the property extension on an `Isar` instance to access the collection.
- `@Index(unique: true)` is used to specify that the annotated property will be indexed and unique. Annotating a property with `@Index` helps improve the performance of queries that uses the annotated property for filtering. See Isar's documentation about [Indexes](https://isar.dev/indexes.html#what-are-indexes) for more information.
  
:bulb: **<span style="color: green">TIP</span>**

Use the code snippet shortcut `dbo` to create a data object class.