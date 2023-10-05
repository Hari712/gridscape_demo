import 'package:gridscape_demo/utils/class_maps.dart';

class JsonTypeParser {
  static dynamic decode<T>(entity) {
    if (entity is Iterable) return _decodeList<T>(entity);
    if (entity is Map<String, dynamic>) return _decodeMap<T>(entity);
    return entity;
  }

  static T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      throw Exception(T.toString());
    }
    return jsonFactory(values);
  }

  static List<T> _decodeList<T>(Iterable values) => values.where((v) => v != null).map<T>((v) => decode<T>(v)).toList();
}
