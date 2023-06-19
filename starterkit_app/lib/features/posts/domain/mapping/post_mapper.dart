import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/domain/mapping/object_mapper.dart';
import 'package:starterkit_app/features/posts/data/contracts/post_contract.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';

part 'post_mapper.g.dart';

abstract interface class PostMapper implements ObjectMapper {}

@AutoMappr([
  MapType<PostContract, PostEntity>(),
  MapType<PostEntity, PostContract>(),
])
@LazySingleton(as: PostMapper)
class PostMapperImpl extends $PostMapperImpl implements PostMapper {
  const PostMapperImpl();
}
