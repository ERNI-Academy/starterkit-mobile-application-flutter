Use cases typically refer to the specific functionalities or features that an application provides to its users. These use cases are often implemented as distinct components or classes within the application.

For example, we need to get the details of a post. We can create a `GetPostUseCase`:

```dart
abstract interface class GetPostUseCase {
  Future<Result<PostEntity>> execute(int id);
}

@Injectable(as: GetPostUseCase)
class GetPostUseCaseImpl implements GetPostUseCase {
  final PostRepository _postRepository;

  GetPostUseCaseImpl(this._postRepository);

  @override
  Future<Result<PostEntity>> execute(int id) async {
    try {
      final PostEntity post = await _postRepository.getPost(id);

      return Success<PostEntity>(post);
    } catch (e, st) {
      return Failure<PostEntity>(Exception(e), st);
    }
  }
}
```

- We have a `GetPostUseCase` interface that defines a method for getting a post by its ID.
- We use `Result` to handle the success and failure of the operation of a use case.
- Use cases are reusable, thus they can also be used in other use cases.
- Use cases should not have any state or mutable properties.