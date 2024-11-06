abstract interface class ObjectMapper {
  T convert<S, T>(S? object);

  Iterable<T> convertIterable<S, T>(Iterable<S> objects);

  List<T> convertList<S, T>(List<S> objects);
}
