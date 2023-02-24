import 'package:erni_mobile/business/models/logging/app_log_event.dart';
import 'package:erni_mobile/business/models/logging/app_log_object.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/domain/services/logging/app_log_sentry_exception_writer.dart';
import 'package:erni_mobile/domain/services/platform/environment_config.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
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
    final eventsBefore = await _takeEventsBeforeThis(event.uid, event.sessionId);
    final breadCrumbs = eventsBefore.map(
      (e) {
        return Breadcrumb(
          message: e.message,
          timestamp: e.createdAt,
          level: SentryLevel.fromName(e.level.name),
          category: e.owner,
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
    final eventsForSession =
        _appLogObjectBox.values.where((e) => e.sessionId == sessionId && e.level != LogLevel.debug).toList();
    final index = eventsForSession.indexWhere((e) => e.uid == eventId);

    return eventsForSession.sublist(0, index);
  }
}
