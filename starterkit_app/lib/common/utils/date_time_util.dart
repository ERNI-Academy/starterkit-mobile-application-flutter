// coverage:ignore-file

import 'package:injectable/injectable.dart';

abstract interface class DateTimeUtil {
  DateTime get now;
}

@LazySingleton(as: DateTimeUtil)
class DateTimeUtilImpl implements DateTimeUtil {
  const DateTimeUtilImpl();

  @override
  DateTime get now => DateTime.now();
}
