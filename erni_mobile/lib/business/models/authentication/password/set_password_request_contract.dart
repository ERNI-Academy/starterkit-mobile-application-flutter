import 'package:erni_mobile/domain/models/data_contracts/data_contract.dart';

abstract class SetPasswordContract extends DataContract {
  const SetPasswordContract({required this.newPassword, required this.confirmPassword, this.confirmationCode});

  @JsonKey(includeIfNull: false)
  final String? confirmationCode;

  final String newPassword;
  final String confirmPassword;
}
