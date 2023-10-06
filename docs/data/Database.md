Database is one of the (local) data sources of our application. It is responsible for persisting data on the device. This is important if you plan to support offline functionality in your application.

The project is using [Isar](https://isar.dev/) as the database.

## Creating the Database

The database file is saved in the application's cache directory. `IsarDatabaseFactory` is responsible for opening the database when we are going read or write data.

## Creating a Data Object
A `DataObject` is a class that represents a table in the database.

See [Data Objects](data-objects) for more details.

## Creating a Local Data Source

`LocalDataSource` is an interface that defines the operations that can be done in the database. We use this interface to hide the implementation details of the database to the consumers of the data source.

```dart
abstract interface class LocalDataSource<T extends DataObject> {
  Future<T?> get(int id);

  Future<Iterable<T>> getAll({required int offset, required int limit});

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

  @protected
  @override
  @visibleForTesting
  IsarGeneratedSchema get schema => PostDataObjectSchema;
}
```

- `@LazySingleton` is used to register the data source as a lazy singleton. We don't need to worry about sharing the same instance since all transactions will be using a different database instance from `IsarDatabaseFactory`.
- `IsarLocalDataSource` is a base class that implements `LocalDataSource`. It is responsible for opening the database and executing transactions.
- `PostDataObjectSchema` is generated after running the `build_runner`. It is used to point the schema to use when opening the database.
- It is important that we only implement `LocalDataSource<PostDataObject>` to `PostLocalDataSource`. This will hide the unecessary implementation details of `IsarLocalDataSource` to the consumers of `PostLocalDataSource`.

:bulb: **<span style="color: green">TIP</span>**

- Use the snippet shortcut `locd` to create a local data source.

## Extending the Local Data Source

If you need to support other queries to your data source, you can add update your own interface that implements `LocalDataSource`.

```dart
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

abstract interface class PostLocalDataSource implements LocalDataSource<PostDataObject> {
  Future<PostDataObject?> getPost(int postId);
}

@LazySingleton(as: PostLocalDataSource)
class PostLocalDataSourceImpl extends IsarLocalDataSource<PostDataObject> implements PostLocalDataSource {
  PostLocalDataSourceImpl(super._isarDatabaseFactory);

  @protected
  @override
  @visibleForTesting
  IsarGeneratedSchema get schema => PostDataObjectSchema;

  @override
  Future<PostDataObject?> getPost(int postId) async {
    final Isar isar = await getIsar();
    final PostDataObject? object = isar.read((Isar i) {
      return i.posts.where().postIdEqualTo(postId).findFirst();
    });

    return object;
  }
}
```

- In the example above, we added `getPost` which uses `Isar`'s generated collection extension on an instance of `Isar` for our `PostDataObject` called `posts`. It provides additional filter options for each of the properties of the data object, for this example we used `postIdEqualTo` to filter the posts by `postId`.


:bulb: **<span style="color: green">TIP</span>**

- As stated in Isar's documentation about [Indexes](https://isar.dev/indexes.html#what-are-indexes), using `@Index()` improves the performance of your queries if you are to use the annotated property for filtering.