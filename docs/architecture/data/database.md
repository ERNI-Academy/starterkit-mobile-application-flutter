# Database

The blueprint uses [`drift`](https://pub.dev/packages/drift) as the SQLite library for persisting data on the device.

Here is a sample definition of a database:

```dart
part 'app_database.g.dart';

@DriftDatabase(tables: [Posts])
@lazySingleton
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;
}
```
- It is registered as a lazy singleton and will be injected to our repositories.
- The `QueryExecutor` is a platform-agnostic handler for opening the database.
- You can also configure here your database migrations.

## Multiple Database

For example, you want to create a database for logging feature.

### Create a custom QueryExecutor
Create a custom `QueryExecutor` that our database will use:

```dart
abstract class LoggingQueryExecutor implements QueryExecutor {}

@LazySingleton(as: LoggingQueryExecutor)
class LoggingExecutorImpl extends BaseQueryExecutor implements LoggingQueryExecutor {
  LoggingExecutorImpl() : super('db_logging');
}
```
- Register the query executor as a lazy singleton.
- Pass the preferred database name to the super constructor.

### Define your database

```dart
part 'logging_database.g.dart';

@lazySingleton
@DriftDatabase(tables: [AppLogs])
class LoggingDatabase extends _$LoggingDatabase {
  LoggingDatabase(LoggingQueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;
}
```
- Use `LoggingQueryExecutor` as the `QueryExecutor` of our database.

### Use the database in your Repository

```dart
abstract class AppLoggingRepository implements Repository<AppLogs, AppLogObject> {}

@LazySingleton(as: AppLoggingRepository)
class AppLoggingRepositoryImpl extends BaseRepository<LoggingDatabase, AppLogs, AppLogObject>
    implements AppLoggingRepository {
  AppLoggingRepositoryImpl(LoggingDatabase db) : super(db);

  @override
  TableInfo<AppLogs, AppLogObject> get table => db.appLogs;
}
```
- Use `LoggingDatabase` as the first type parameter of `BaseRepository`.