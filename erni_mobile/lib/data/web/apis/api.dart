import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

export 'package:dio/dio.dart' hide Headers;
export 'package:erni_mobile/data/web/apis/dio_provider_impl.dart';
export 'package:retrofit/retrofit.dart';

const Named apiBaseUrl = Named('apiBaseUrl');

class AuthHeader extends Header {
  const AuthHeader() : super('Authorization');
}
