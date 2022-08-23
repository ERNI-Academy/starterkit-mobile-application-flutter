import 'package:erni_mobile/business/mappers/logging/app_log_object_from_entity_mapper.dart';
import 'package:erni_mobile/business/models/logging/app_log_event_entity.dart';
import 'package:erni_mobile/domain/repositories/logging/app_log_repository.dart';
import 'package:erni_mobile/domain/services/logging/app_log_file_writer.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppLogFileWriter)
class AppLogFileWriterImpl implements AppLogFileWriter {
  AppLogFileWriterImpl(this._appLogRepository, this._appLogObjectMapper);

  final AppLogObjectFromEntityMapper _appLogObjectMapper;
  final AppLogRepository _appLogRepository;

  @override
  Future<void> write(AppLogEventEntity event) async {
    final appLog = _appLogObjectMapper.fromEntity(event)!;
    await _appLogRepository.add(appLog);
  }
}
