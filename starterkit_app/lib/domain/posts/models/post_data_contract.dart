import 'package:starterkit_app/core/domain/models/json_serializable_object.dart';

part 'post_data_contract.g.dart';

@JsonSerializable()
class PostDataContract extends JsonSerializableObject {
  const PostDataContract({required this.userId, required this.id, required this.title, required this.body});

  factory PostDataContract.fromJson(Map<String, dynamic> json) => _$PostDataContractFromJson(json);

  final int userId;
  final int id;
  final String title;
  final String body;

  @override
  Map<String, dynamic> toJson() => _$PostDataContractToJson(this);
}
