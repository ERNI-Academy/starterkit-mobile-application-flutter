import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_parameter.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/core/reflection.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';

@injectable
@navigatable
class PostDetailsViewModel extends ViewModel {
  @postParam
  PostEntity post = PostEntity.empty;
}

const NavigationQueryParam postParam = NavigationQueryParam('post');
