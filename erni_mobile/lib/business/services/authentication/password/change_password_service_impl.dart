import 'package:erni_mobile/business/mappers/authentication/password/change_password_mapper.dart';
import 'package:erni_mobile/business/models/authentication/password/change_password_entity.dart';
import 'package:erni_mobile/common/constants/api_error_codes.dart';
import 'package:erni_mobile/common/exceptions/api_exceptions.dart';
import 'package:erni_mobile/common/exceptions/domain_exceptions.dart';
import 'package:erni_mobile/domain/apis/authentication/password_api.dart';
import 'package:erni_mobile/domain/services/authentication/password/change_password_service.dart';
import 'package:erni_mobile/domain/services/authentication/token/token_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ChangePasswordService)
class ChangePasswordServiceImpl implements ChangePasswordService {
  ChangePasswordServiceImpl(this._tokenService, this._changePasswordMapper, this._passwordApi);

  final TokenService _tokenService;
  final ChangePasswordContractFromEntityMapper _changePasswordMapper;
  final PasswordApi _passwordApi;

  @override
  Future<void> changePassword(ChangePasswordEntity entity) async {
    try {
      final contract = _changePasswordMapper.fromEntity(entity)!;
      final authToken = await _tokenService.getAuthToken();
      await _passwordApi.changePassword(authToken, contract);
    } on ApiException catch (e) {
      switch (e.errorCode) {
        case ApiErrorCodes.accountOldPasswordMismatch:
          throw const AccountOldPasswordMismatchException();
        default:
          rethrow;
      }
    }
  }
}
