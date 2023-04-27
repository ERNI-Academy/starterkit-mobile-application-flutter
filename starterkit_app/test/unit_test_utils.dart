// ignore_for_file: prefer_void_to_null
// ignore_for_file: prefer-static-class

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

Null anyInstanceOf<T>({String? named}) => argThat(isA<T>(), named: named);

Null captureAnyInstanceOf<T>({String? named}) => captureThat(isA<T>(), named: named);
