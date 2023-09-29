// coverage:ignore-file

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/domain/mapping/object_mapper.dart';
import 'package:starterkit_app/domain/posts/mappers/post_mapper.auto_mappr.dart';
import 'package:starterkit_app/domain/posts/models/post_data_contract.dart';
import 'package:starterkit_app/domain/posts/models/post_data_object.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';

abstract interface class PostMapper implements ObjectMapper {}

@AutoMappr(<MapType<Object, Object>>[
  MapType<PostDataContract, PostEntity>(),
  MapType<PostDataContract, PostDataObject>(),
  MapType<PostDataObject, PostEntity>(),
])
@LazySingleton(as: PostMapper)
class PostMapperImpl extends $PostMapperImpl implements PostMapper {
  @override
  T mapObject<S, T>(S? object) => convert(object);

  @override
  Iterable<T> mapObjects<S, T>(Iterable<S> objects) => convertIterable(objects);
}
