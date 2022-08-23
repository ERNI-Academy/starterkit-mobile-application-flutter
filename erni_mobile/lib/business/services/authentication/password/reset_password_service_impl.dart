import 'package:erni_mobile/business/mappers/authentication/password/reset_password_mapper.dart';
import 'package:erni_mobile/business/models/authentication/password/reset_password_entity.dart';
import 'package:erni_mobile/common/constants/api_error_codes.dart';
import 'package:erni_mobile/common/exceptions/api_exceptions.dart';
import 'package:erni_mobile/common/exceptions/domain_exceptions.dart';
import 'package:erni_mobile/domain/apis/authentication/password_api.dart';
import 'package:erni_mobile/domain/services/authentication/password/reset_password_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ResetPasswordService)
class ResetPasswordServiceImpl implements ResetPasswordService {
  ResetPasswordServiceImpl(this._resetPasswordMapper, this._passwordApi);

  final ResetPasswordContractFromEntityMapper _resetPasswordMapper;
  final PasswordApi _passwordApi;

  @override
  Future<void> resetPassword(ResetPasswordEntity entity) async {
    try {
      final contract = _resetPasswordMapper.fromEntity(entity)!;
      await _passwordApi.resetPassword(contract);
    } on ApiException catch (e) {
      switch (e.errorCode) {
        case ApiErrorCodes.accountResetPasswordLinkUsedOrExpired:
          throw const LinkUsedOrExpiredException();
        default:
          rethrow;
      }
    }
  }
}
