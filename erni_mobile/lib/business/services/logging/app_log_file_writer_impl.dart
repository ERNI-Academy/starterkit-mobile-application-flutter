import 'package:erni_mobile/business/models/logging/app_log_event.dart';
import 'package:erni_mobile/domain/repositories/logging/app_log_repository.dart';
import 'package:erni_mobile/domain/services/logging/app_log_file_writer.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppLogFileWriter)
class AppLogFileWriterImpl implements AppLogFileWriter {
  AppLogFileWriterImpl(this._appLogRepository);

  final AppLogRepository _appLogRepository;

  @override
  Future<void> write(AppLogEvent event) async {
    final appLog = event.toDatabaseObject();
    await _appLogRepository.add(appLog);
  }
}
