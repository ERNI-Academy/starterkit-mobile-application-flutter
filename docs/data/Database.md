Database is one of the (local) data sources of our application. It is responsible for persisting data on the device. This is important if you plan to support offline functionality in your application.

The project is using [Isar](https://isar.dev/) as the database.

## Creating the Database

The database file is saved in the application's cache directory. `IsarDatabaseFactory` is responsible for opening the database when we are going read or write data.

## Creating a Data Object
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

## Creating a Local Data Source

`LocalDataSource` is an interface that defines the operations that can be done in the database. We use this interface to hide the implementation details of the database to the consumers of the data source.

```dart
abstract interface class LocalDataSource<T extends DataObject> {
  Future<T?> get(int id);

  Future<Iterable<T>> getAll();

  Future<void> addOrUpdate(T object);

  Future<void> addOrUpdateAll(Iterable<T> objects);

  Future<void> delete(T object);

  Future<void> deleteAll();
}
```

Once you have created your data object, you can now create your local data source by extending `IsarLocalDataSource`.

```dart
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

abstract interface class PostLocalDataSource implements LocalDataSource<PostDataObject> {}

@LazySingleton(as: PostLocalDataSource)
class PostLocalDataSourceImpl extends IsarLocalDataSource<PostDataObject> implements PostLocalDataSource {
  const PostLocalDataSourceImpl(super._isarDatabaseFactory);

  @override
  IsarGeneratedSchema get schema => PostDataObjectSchema;
}
```

- `@LazySingleton` is used to register the data source as a lazy singleton. We don't need to worry about sharing the same instance since all transactions will be using a different database instance from `IsarDatabaseFactory`.
- `IsarLocalDataSource` is a base class that implements `LocalDataSource`. It is responsible for opening the database and executing transactions.
- `PostDataObjectSchema` is generated after running the `build_runner`. It is used to point the schema to use when opening the database.
- It is important that we only implement `LocalDataSource<PostDataObject>` to `PostLocalDataSource`. This will hide the unecessary implementation details of `IsarLocalDataSource` to the consumers of `PostLocalDataSource`. 

:bulb: **<span style="color: green">TIP</span>**

- Use the snippet shortcut `locd` to create a local data source.