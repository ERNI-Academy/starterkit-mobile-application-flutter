import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:starterkit_app/features/posts/data/contracts/post_contract.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';

part 'posts_mapper.g.dart';

@AutoMappr([
  MapType<PostContract, PostEntity>(),
  MapType<PostEntity, PostContract>(),
])
class PostsMapper extends $PostsMapper {
  const PostsMapper();
}
