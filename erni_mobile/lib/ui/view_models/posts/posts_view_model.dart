import 'package:erni_mobile/business/models/posts/posts_list_state.dart';
import 'package:erni_mobile/domain/services/async/rx_provider.dart';
import 'package:erni_mobile/domain/services/posts/posts_service.dart';
import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class PostsViewModel extends ViewModel {
  final RxProvider _rxProvider;
  final PostsService _postsService;
  late final BehaviorSubject<PostsListState> _postsState =
      _rxProvider.createSeededSubject(const PostsListLoadingState(), sync: true);

  PostsViewModel(this._rxProvider, this._postsService);

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
    try {
      _postsState.value = const PostsListLoadingState();
      final posts = await _postsService.getPosts();
      _postsState.value = PostsListLoadedState(posts);
    } catch (e) {
      final previousLoadedState = _postsState.firstWhere(
        (s) => s is PostsListLoadedState,
        orElse: () => const PostsListLoadedState([]),
      ) as PostsListLoadedState;

      _postsState.value = PostsListErrorState(e, previousLoadedState.posts);
    }
  }
}
