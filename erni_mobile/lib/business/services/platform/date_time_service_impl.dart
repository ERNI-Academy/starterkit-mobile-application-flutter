import 'package:erni_mobile/domain/services/platform/date_time_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DateTimeService)
class DateTimeServiceImpl implements DateTimeService {
  @override
  DateTime localNow() => DateTime.now();

  @override
  DateTime utcNow() => DateTime.now().toUtc();
}
