import 'package:erni_mobile/business/models/logging/app_log_event_entity.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/data/database/logging/logging_database.dart';
import 'package:erni_mobile/domain/repositories/logging/app_log_repository.dart';
import 'package:erni_mobile/domain/services/logging/app_log_sentry_exception_writer.dart';
import 'package:erni_mobile/domain/services/platform/environment_config.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

@LazySingleton(as: AppLogSentryExceptionWriter)
class AppLogSentryExceptionWriterImpl implements AppLogSentryExceptionWriter {
  AppLogSentryExceptionWriterImpl(this._appLogRepository, this._sentryHub, this._environmentConfig);

  final AppLogRepository _appLogRepository;
  final Hub _sentryHub;
  final EnvironmentConfig _environmentConfig;

  @override
  Future<void> write(AppLogEventEntity event) async {
    if (event.error == null) {
      return;
    }

    await _internalCaptureEvent(event);
  }

  Future<void> _internalCaptureEvent(AppLogEventEntity event) async {
    final eventsBefore = await _takeEventsBeforeThis(event.id, event.sessionId);
    final breadCrumbs = eventsBefore.map(
      (e) {
        return Breadcrumb(
          message: e.message,
          timestamp: e.createdAt,
          level: SentryLevel.fromName(e.level.name),
          category: e.owner,
          data: e.extras.isNotEmpty ? e.extras : null,
        );
      },
    ).toList();
    // ignore: invalid_use_of_internal_member
    final exceptionFactory = _sentryHub.options.exceptionFactory;

    await _sentryHub.captureEvent(
      SentryEvent(
        breadcrumbs: breadCrumbs,
        environment: _environmentConfig.appEnvironment.name,
        exceptions: [exceptionFactory.getSentryException(event.error, stackTrace: event.stackTrace)],
        extra: event.extras,
        logger: event.owner,
        message: SentryMessage(event.message),
        timestamp: event.createdAt,
      ),
    );
  }

  Future<List<AppLogObject>> _takeEventsBeforeThis(String eventId, String sessionId) async {
    final events = await _appLogRepository.selectAll();
    final eventsForSession = events.where((e) => e.sessionId == sessionId && e.level != LogLevel.debug).toList();
    final index = eventsForSession.indexWhere((e) => e.id == eventId);

    return eventsForSession.sublist(0, index);
  }
}
