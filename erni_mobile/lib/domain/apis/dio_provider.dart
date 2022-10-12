import 'package:dio/dio.dart';

abstract class DioProvider {
  Dio create(String apiName);
}
