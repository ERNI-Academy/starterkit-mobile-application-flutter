import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_data_contract.freezed.dart';
part 'post_data_contract.g.dart';

@freezed
class PostDataContract with _$PostDataContract {
  const factory PostDataContract({
    required int userId,
    required int id,
    required String title,
    required String body,
  }) = _PostDataContract;

  // coverage:ignore-start
  factory PostDataContract.fromJson(Map<String, dynamic> json) => _$PostDataContractFromJson(json);
  // coverage:ignore-end
}
