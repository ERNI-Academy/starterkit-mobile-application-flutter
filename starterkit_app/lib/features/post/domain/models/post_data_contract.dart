import 'package:starterkit_app/core/domain/models/json_serializable_object.dart';

part 'post_data_contract.g.dart';

@JsonSerializable()
class PostDataContract extends JsonSerializableObject {
  final int userId;

  final int id;

  final String title;

  final String body;

  const PostDataContract({required this.userId, required this.id, required this.title, required this.body});

  factory PostDataContract.fromJson(Map<String, dynamic> json) => _$PostDataContractFromJson(json);
}
