import 'package:erni_mobile/business/models/logging/app_log_event.dart';
import 'package:erni_mobile/business/models/logging/app_log_object.dart';
import 'package:erni_mobile/domain/services/logging/app_log_file_writer.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppLogFileWriter)
class AppLogFileWriterImpl implements AppLogFileWriter {
  final Box<AppLogObject> _appLogObjectBox;

  AppLogFileWriterImpl(this._appLogObjectBox);

  @override
  Future<void> write(AppLogEvent event) async {
    final appLog = event.toObject();
    await _appLogObjectBox.add(appLog);
  }
}
