class GetPostsException implements Exception {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  const GetPostsException(this.message, [this.error, this.stackTrace]);
}
