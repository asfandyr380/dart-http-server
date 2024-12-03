import '../utils/enums.dart';
import '../utils/errors/request_error.dart';
import 'body.dart';
import 'headers.dart';

class Request {
  final Method method;
  final String path;
  final String version = "HTTP/1.1";
  Headers? headers;
  Body? body;

  Request({
    required this.method,
    required this.path,
    this.headers,
    this.body,
  });

  static Request parse(String rawReq) {
    List<String> reqLines = rawReq.split("\r\n");
    List<String> request = reqLines.first.split(" ");
    late Request req;
    late Method mth;

    try {
      mth = Method.parseMethod(request[0]);
    } on FormatException catch (e) {
      throw RequestError(e.message);
    }

    String path = request[1];
    req = Request(method: mth, path: path);

    Headers? hdr = Headers.parse([...reqLines]..removeAt(0));
    if (hdr == null)
      throw RequestError("invalid request headers cannot be null", req);
    
    req.headers = hdr;

    if (!ContentType.isValidType(hdr.value["Content-Type"]))
      throw RequestError("invalid content-type not supported", req);

    req.body = Body.parse(reqLines.last, hdr);

    return req;
  }
}
