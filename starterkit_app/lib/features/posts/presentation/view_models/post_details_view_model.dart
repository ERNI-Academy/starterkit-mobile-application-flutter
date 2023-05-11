import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';

@injectable
class PostDetailsViewModel extends ViewModel {
  @postParam
  PostEntity post = PostEntity.empty;
}

const QueryParam postParam = QueryParam('post');
