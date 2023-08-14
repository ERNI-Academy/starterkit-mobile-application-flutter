abstract interface class ObjectMapper {
  T convert<S, T>(S? model);
}
