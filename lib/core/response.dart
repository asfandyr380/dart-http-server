import 'dart:convert';

import '../utils/enums.dart';
import 'body.dart';
import 'headers.dart';

class Response {
  ResponseCode code;
  Headers headers;
  final Body body;

  Response({
    this.code = ResponseCode.OK,
    required this.body,
  }) : this.headers = Headers.standard();

  String build() {
    String hdr = headers.build();
    var buffer = StringBuffer()
      ..write("HTTP/1.1 ${code.code} ${code.message}\r\n$hdr");
    buffer.write("\r\n${json.encode(body.data)}");

    return buffer.toString();
  }
}
