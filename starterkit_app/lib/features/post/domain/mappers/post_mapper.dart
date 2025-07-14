// coverage:ignore-file

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/data/database/app_database.dart';
import 'package:starterkit_app/core/domain/mapping/object_mapper.dart';
import 'package:starterkit_app/features/post/domain/mappers/post_mapper.auto_mappr.dart';
import 'package:starterkit_app/features/post/domain/models/post_data_contract.dart';
import 'package:starterkit_app/features/post/domain/models/post_entity.dart';
import 'package:uuid/uuid.dart';

abstract interface class PostMapper implements ObjectMapper {}

@AutoMappr(<MapType<Object, Object>>[
  MapType<PostDataContract, PostEntity>(),
  MapType<PostDataContract, PostDataObject>(
    fields: <Field>[
      Field.custom('id', custom: PostMapperImpl.id),
      Field.from('postId', from: 'id'),
    ],
  ),
  MapType<PostDataObject, PostEntity>(
    fields: <Field>[
      Field.from('id', from: 'postId'),
    ],
  ),
])
@LazySingleton(as: PostMapper)
class PostMapperImpl extends $PostMapperImpl implements PostMapper {
  const PostMapperImpl();

  static String id() => const Uuid().v4();
}
