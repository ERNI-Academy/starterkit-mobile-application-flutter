import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/core/reflection.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';

@injectable
@navigatable
class PostDetailsViewModel extends ViewModel {
  @postParam
  PostEntity post = const PostEntity.empty();
}

const QueryParam postParam = QueryParam('post');
