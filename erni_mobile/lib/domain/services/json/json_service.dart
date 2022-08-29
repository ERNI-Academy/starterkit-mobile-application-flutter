typedef JsonConverterCallback<T> = T? Function(Map<String, dynamic> json);

abstract class JsonService {
  T? decodeToObject<T extends Object>(
    String decodable, {
    required JsonConverterCallback<T> converter,
    T? Function(Object error)? onConversionFailed,
  });

  List<T> decodeToList<T extends Object>(
    String decodable, {
    JsonConverterCallback<T>? itemConverter,
    List<T> Function(Object error)? onConversionFailed,
  });

  Object decode(String encodable);

  String encode(Object encodable);
}
