import 'package:erni_mobile/business/models/user/user_profile_contract.dart';
import 'package:erni_mobile/data/web/apis/api.dart';
import 'package:erni_mobile/domain/apis/user/user_api.dart';

part 'user_api_impl.g.dart';

@LazySingleton(as: UserApi)
@RestApi()
abstract class UserApiImpl implements UserApi {
  @factoryMethod
  factory UserApiImpl(DioProvider dioProvider, @apiBaseUrl String baseUrl) =>
      _UserApiImpl(dioProvider.create(serviceName: 'UserApi'), baseUrl: baseUrl);

  @GET(ApiEndpoints.userProfile)
  @override
  Future<UserProfileContract> getUserProfile(@AuthHeader() String authToken);
}
