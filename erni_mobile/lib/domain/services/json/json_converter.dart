typedef JsonConverterCallback<T> = T? Function(Map<String, dynamic> json);

abstract class JsonConverter {
  T? decodeToObject<T extends Object>(
    String decodable, {
    required JsonConverterCallback<T> converter,
    T? Function(Object error)? onConversionFailed,
  });

  Iterable<T> decodeToCollection<T extends Object>(
    String decodable, {
    JsonConverterCallback<T>? itemConverter,
    Iterable<T> Function(Object error)? onConversionFailed,
  });

  Object decode(String encodable);

  String encode(Object encodable);
}
