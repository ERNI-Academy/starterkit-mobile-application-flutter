import 'package:erni_mobile/business/models/logging/app_log_event.dart';
import 'package:erni_mobile/business/models/logging/app_log_object.dart';
import 'package:erni_mobile/domain/services/logging/app_log_file_writer.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@LazySingleton(as: AppLogFileWriter)
class AppLogFileWriterImpl implements AppLogFileWriter {
  final Isar _isar;

  AppLogFileWriterImpl(this._isar);

  @override
  Future<void> write(AppLogEvent event) async {
    final appLog = event.toObject();
    await _isar.writeTxn(() async {
      await _isar.appLogObjects.put(appLog);
    });
  }
}
