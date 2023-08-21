// ignore_for_file: prefer_void_to_null
// ignore_for_file: prefer-static-class

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Ignored for this case
// ignore: avoid-function-type-in-records
typedef Having<T> = ({Object? Function(T expected) feature, String description, Object matcher});

Null anyInstanceOf<T>({String? named, List<Having<T>> conditions = const []}) {
  var matcher = isA<T>();

  if (conditions.isNotEmpty) {
    for (final condition in conditions) {
      matcher = matcher.having(condition.feature, condition.description, condition.matcher);
    }
  }

  return argThat(matcher, named: named);
}

Null captureAnyInstanceOf<T>({String? named}) => captureThat(isA<T>(), named: named);
