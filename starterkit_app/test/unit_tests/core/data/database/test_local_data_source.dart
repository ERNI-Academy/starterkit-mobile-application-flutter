import 'package:isar/isar.dart';
import 'package:starterkit_app/core/data/database/isar_local_data_source.dart';
import 'package:starterkit_app/core/domain/models/data_object.dart';

part 'test_local_data_source.g.dart';

class TestLocalDataSource extends IsarLocalDataSource<TestDataObject> {
  TestLocalDataSource(super._isarDatabaseFactory);

  @override
  IsarGeneratedSchema get schema => TestDataObjectSchema;

  Future<TestDataObject?> getByTestId(int testId) async {
    final Isar isar = await getIsar();
    final TestDataObject? object = isar.read((Isar i) {
      return i.testDataObjects.where().testIdEqualTo(testId).findFirst();
    });

    return object;
  }
}

@Collection()
class TestDataObject extends DataObject {
  TestDataObject(this.testId);

  @Index(unique: true)
  final int testId;
}
