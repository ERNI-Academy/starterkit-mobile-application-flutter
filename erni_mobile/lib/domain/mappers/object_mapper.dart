abstract class ObjectMapper<TOut extends Object, TIn extends Object> {
  TOut? map(TIn? source);
}
