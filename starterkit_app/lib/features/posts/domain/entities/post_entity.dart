import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;

  @override
  List<Object> get props => [userId, id, title, body];

  const PostEntity({required this.userId, required this.id, required this.title, required this.body});

  const PostEntity.empty({this.userId = 0, this.id = 0, this.title = '', this.body = ''});
}
