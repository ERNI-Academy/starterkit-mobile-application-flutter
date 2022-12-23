# Data Objects

Data Objects classes are models that represents a table in your database.

Here is a definition of the table named `Posts`, which will generate a companion data class name called `PostObject`:

```dart
@DataClassName('PostObject')
class Posts extends DataTable {
  @override
  TextColumn get id => text()();

  TextColumn get userId => text()();

  TextColumn get userAvatarUrl => text().nullable()();

  TextColumn get userFullName => text()();

  TextColumn get content => text()();

  DateTimeColumn get updatedAt => dateTime()();
}
```

Data table classes are used as an ORM to transact the database.


:bulb: **<span style="color: green">TIP</span>**

Use the code snippet `dtbl` to create a data table