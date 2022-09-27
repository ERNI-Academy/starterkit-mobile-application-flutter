// coverage:ignore-file

import 'dart:developer';

import 'package:erni_mobile/business/models/logging/app_log_event_entity.dart';
import 'package:erni_mobile/domain/services/logging/app_log_console_writer.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppLogConsoleWriter)
class AppLogConsoleWriterImpl implements AppLogConsoleWriter {
  @override
  Future<void> write(AppLogEventEntity event) {
    log(
      event.message,
      name: event.owner,
      level: event.level.value,
      time: event.createdAt,
      error: event.error,
      stackTrace: event.stackTrace,
    );

    return Future.value();
  }
}
