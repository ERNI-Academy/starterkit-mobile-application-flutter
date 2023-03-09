import 'package:dio/dio.dart';

abstract class DioProvider {
  Dio createFor<T>();
}
