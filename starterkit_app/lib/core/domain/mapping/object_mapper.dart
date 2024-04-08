abstract interface class ObjectMapper {
  T convert<S, T>(S? object);

  Iterable<T> convertIterable<S, T>(Iterable<S> objects);
}
