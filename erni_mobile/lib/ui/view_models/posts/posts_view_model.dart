import 'package:erni_mobile/business/models/posts/posts_list_state.dart';
import 'package:erni_mobile/domain/services/posts/posts_service.dart';
import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class PostsViewModel extends ViewModel {
  final PostsService _postsService;
  final BehaviorSubject<PostsListState> _postsState = BehaviorSubject.seeded(const PostsListLoadingState(), sync: true);

  PostsViewModel(this._postsService);

  Stream<PostsListState> get postsState => _postsState.stream;

  @override
  Future<void> onInitialize() async {
    await _onGetPosts();
  }

  @override
  Future<void> dispose() async {
    await _postsState.close();
    super.dispose();
  }

  Future<void> _onGetPosts() async {
    _postsState.value = const PostsListLoadingState();

    final getPostsResult = await _postsService.getPosts();

    if (getPostsResult.isSuccess) {
      _postsState.value = PostsListLoadedState(getPostsResult.value ?? []);
    } else {
      final previousLoadedState = _postsState.firstWhere(
        (s) => s is PostsListLoadedState,
        orElse: () => const PostsListLoadedState([]),
      ) as PostsListLoadedState;

      _postsState.value = PostsListErrorState(getPostsResult.error!, previousLoadedState.posts);
    }
  }
}
