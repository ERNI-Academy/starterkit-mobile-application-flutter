import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/infrastructure/mapping/modules/posts/post_mapper.dart';

part 'object_mapper.g.dart';

abstract interface class ObjectMapper {
  T convert<S, T>(S? model);

  Iterable<T> convertIterable<S, T>(Iterable<S?> model);
}

@LazySingleton(as: ObjectMapper)
@AutoMappr(
  [],
  modules: [
    PostMapper(),
  ],
)
class ObjectMapperImpl extends $ObjectMapperImpl implements ObjectMapper {}
