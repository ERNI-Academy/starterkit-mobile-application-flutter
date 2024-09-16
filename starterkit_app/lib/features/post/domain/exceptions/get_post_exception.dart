class GetPostException implements Exception {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  const GetPostException(this.message, [this.error, this.stackTrace]);
}
