import 'package:isar/isar.dart';
import 'package:starterkit_app/core/data/database/isar_local_data_source.dart';
import 'package:starterkit_app/core/domain/models/data_object.dart';

part 'test_local_data_source.g.dart';

class TestLocalDataSource extends IsarLocalDataSource<TestDataObject> {
  TestLocalDataSource(super._isarDatabaseFactory);

  @override
  IsarGeneratedSchema get schema => TestDataObjectSchema;
}

@collection
class TestDataObject implements DataObject<int> {
  const TestDataObject(this.id);

  @override
  final int id;
}
