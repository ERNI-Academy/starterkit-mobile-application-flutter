import 'package:erni_mobile/business/mappers/authentication/password/set_initial_password_mapper.dart';
import 'package:erni_mobile/business/models/authentication/password/set_initial_password_entity.dart';
import 'package:erni_mobile/common/constants/api_error_codes.dart';
import 'package:erni_mobile/common/exceptions/api_exceptions.dart';
import 'package:erni_mobile/common/exceptions/domain_exceptions.dart';
import 'package:erni_mobile/domain/apis/authentication/password_api.dart';
import 'package:erni_mobile/domain/services/authentication/password/set_initial_password_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SetInitialPasswordService)
class SetInitialPasswordServiceImpl implements SetInitialPasswordService {
  SetInitialPasswordServiceImpl(this._initialPasswordMapper, this._passwordApi);

  final SetInitialPasswordContractFromEntityMapper _initialPasswordMapper;
  final PasswordApi _passwordApi;

  @override
  Future<void> setInitialPassword(SetInitialPasswordEntity entity) async {
    try {
      final contract = _initialPasswordMapper.fromEntity(entity)!;
      await _passwordApi.setInitialPassword(contract);
    } on ApiException catch (e) {
      switch (e.errorCode) {
        case ApiErrorCodes.accountAlreadyConfirmed:
          throw const AccountAlreadyConfirmedException();
        default:
          rethrow;
      }
    }
  }
}
