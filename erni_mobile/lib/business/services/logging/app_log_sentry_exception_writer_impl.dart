import 'package:erni_mobile/business/models/logging/app_log_event.dart';
import 'package:erni_mobile/business/models/logging/app_log_object.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/domain/services/logging/app_log_sentry_exception_writer.dart';
import 'package:erni_mobile/domain/services/platform/environment_config.dart';
import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

@LazySingleton(as: AppLogSentryExceptionWriter)
class AppLogSentryExceptionWriterImpl implements AppLogSentryExceptionWriter {
  final Box<AppLogObject> _appLogObjectBox;
  final Hub _sentryHub;
  final EnvironmentConfig _environmentConfig;

  AppLogSentryExceptionWriterImpl(this._appLogObjectBox, this._sentryHub, this._environmentConfig);

  @override
  Future<void> write(AppLogEvent event) async {
    if (event.error == null) {
      return;
    }

    await _internalCaptureEvent(event);
  }

  Future<void> _internalCaptureEvent(AppLogEvent event) async {
    final eventsBefore = _takeEventsBeforeThis(event.id, event.sessionId);
    final breadCrumbs = eventsBefore.map(
      (e) {
        return Breadcrumb(
          message: e.message,
          timestamp: e.createdAt,
          level: SentryLevel.fromName(e.level),
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

  List<AppLogObject> _takeEventsBeforeThis(String eventId, String sessionId) {
    final events = _appLogObjectBox.getAll();
    final eventsForSession = events.where((e) => e.sessionId == sessionId && e.level != LogLevel.debug.name).toList();
    final index = eventsForSession.indexWhere((e) => e.uid == eventId);

    return eventsForSession.sublist(0, index);
  }
}
