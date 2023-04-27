import 'package:equatable/equatable.dart';
import 'package:starterkit_app/features/posts/data/contracts/post_contract.dart';

class PostEntity extends Equatable {
  static const PostEntity empty = PostEntity(userId: 0, id: 0, title: '', body: '');

  final int userId;
  final int id;
  final String title;
  final String body;

  @override
  List<Object> get props => [userId, id, title, body];

  const PostEntity({required this.userId, required this.id, required this.title, required this.body});

  factory PostEntity.fromContract(PostContract contract) {
    return PostEntity(
      userId: contract.userId,
      id: contract.id,
      title: contract.title,
      body: contract.body,
    );
  }
}
