import 'package:starterkit_app/core/data/json/json_serializable_object.dart';

part 'post_contract.g.dart';

@JsonSerializable()
class PostContract extends JsonSerializableObject {
  const PostContract({required this.userId, required this.id, required this.title, required this.body});

  factory PostContract.fromJson(Map<String, dynamic> json) => _$PostContractFromJson(json);

  final int userId;
  final int id;
  final String title;
  final String body;

  @override
  Map<String, dynamic> toJson() => _$PostContractToJson(this);
}
