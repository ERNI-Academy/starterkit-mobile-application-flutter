import 'package:erni_mobile/domain/models/data_contract.dart';
import 'package:meta/meta.dart';

part 'post_item_contract.g.dart';

@immutable
@JsonSerializable()
class PostItemContract extends DataContract {
  const PostItemContract({required this.userId, required this.id, required this.title, required this.body});

  factory PostItemContract.fromJson(Map<String, dynamic> json) => _$PostItemContractFromJson(json);

  final int userId;
  final int id;
  final String title;
  final String body;

  @override
  Map<String, dynamic> toJson() => _$PostItemContractToJson(this);
}
