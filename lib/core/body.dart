import 'dart:convert';
import '../utils/enums.dart';
import 'headers.dart';

class Body {
  final dynamic data;

  const Body({required this.data});

  /// the [parse] method takes the raw body string and converts
  /// it into an object based on the the ContentType in the headers
  /// PS pass only the body part of the raw request
  static Body? parse(String rawBody, Headers headers) {
    if (rawBody.isEmpty) return null;

    ContentType contentType = headers.contentType;
    dynamic parsedData;

    switch (contentType) {
      case ContentType.json:
        parsedData = json.decode(rawBody) as Map<dynamic, dynamic>?;
        break;
      case ContentType.multipart:
        break;
      case ContentType.urlencoded:
        List<String> urlencodedListData = rawBody.split("&");
        parsedData = {};
        urlencodedListData.forEach((d) {
          List<String> keyValue = d.split("=");
          parsedData[keyValue[0]] = keyValue[1];
        });
        break;
      case ContentType.plain:
        parsedData = rawBody;
        break;
    }

    return Body(data: parsedData);
  }
}
