import 'package:erni_mobile/business/models/logging/app_log_event.dart';
import 'package:erni_mobile/business/models/logging/app_log_object.dart';
import 'package:erni_mobile/domain/services/logging/app_log_file_writer.dart';
import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';

@LazySingleton(as: AppLogFileWriter)
class AppLogFileWriterImpl implements AppLogFileWriter {
  AppLogFileWriterImpl(this.appLogBox);

  final Box<AppLogObject> appLogBox;

  @override
  Future<void> write(AppLogEvent event) async {
    final appLog = event.toObject();
    await appLogBox.putAsync(appLog);
  }
}
