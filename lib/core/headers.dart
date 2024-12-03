import '../utils/enums.dart';

class Headers {
  Map<String, String> value = {};
  late ContentType contentType;

  /// used to parse the raw header [String] into a map
  /// PS: pass only the header part of the raw data into the function as [List] of [String]
  static Headers? parse(List<String> data) {
    if (data.isEmpty) return null;

    Headers headers = Headers();
    for (var i = 0; i < data.length; i++) {
      String header = data[i];
      if (header.isEmpty) break;
      List<String> headerKeyValue = header.split(": ");
      headers.value[headerKeyValue.first] = headerKeyValue.last;
    }
    headers.contentType =
        ContentType.getType(headers.value["Content-Type"]) ?? ContentType.plain;
    return headers;
  }

  static Headers standard() {
    return Headers()
      ..contentType = ContentType.plain
      ..value = {"Content-Type": "text/plain"};
  }

  String build() {
    var buffer = StringBuffer();
    value.forEach((key, value) {
      buffer.write('$key: $value\r\n');
    });
    return buffer.toString();
  }
}
