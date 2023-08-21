import 'package:equatable/equatable.dart';

// export 'post_entity.dart';

class PostEntity extends Equatable {
  const PostEntity({required this.userId, required this.id, required this.title, required this.body});

  const PostEntity.empty({this.userId = 0, this.id = 0, this.title = '', this.body = ''});

  final int userId;
  final int id;
  final String title;
  final String body;

  @override
  List<Object> get props => <Object>[userId, id, title, body];
}
