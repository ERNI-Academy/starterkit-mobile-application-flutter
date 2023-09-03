abstract interface class ObjectMapper {
  T mapObject<S, T>(S? object);

  Iterable<T> mapObjects<S, T>(Iterable<S> objects);
}
