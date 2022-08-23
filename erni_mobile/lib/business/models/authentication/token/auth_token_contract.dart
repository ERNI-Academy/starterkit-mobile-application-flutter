import 'package:erni_mobile/common/utils/converters/json/json_date_time_to_iso8601_string_converter.dart';
import 'package:erni_mobile/domain/models/data_contracts/data_contract.dart';

part 'auth_token_contract.g.dart';

@JsonDateTimeToIso8601StringConverter()
@JsonSerializable()
class AuthTokenContract extends DataContract {
  const AuthTokenContract({
    required this.accessToken,
    required this.expirationDate,
    required this.isAccountConfirmed,
  });

  factory AuthTokenContract.fromJson(Map<String, dynamic> json) => _$AuthTokenContractFromJson(json);

  final String accessToken;
  final DateTime expirationDate;
  final bool isAccountConfirmed;

  @override
  Map<String, dynamic> toJson() => _$AuthTokenContractToJson(this);
}
