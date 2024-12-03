enum Method {
  GET,
  POST,
  DELETE,
  PUT;

  static Method parseMethod(String method) {
    switch (method) {
      case "GET":
        return GET;
      case "POST":
        return POST;
      case "DELETE":
        return DELETE;
      case "PUT":
        return PUT;

      default:
        throw new FormatException("Method $method is not allowed");
    }
  }
}

enum ResponseCode {
  OK(code: 200, message: "OK"),
  NotFound(code: 404, message: "Not Found"),
  InternalServerError(code: 500, message: "Internal Server Error");

  const ResponseCode({required this.code, required this.message});

  final String message;
  final int code;
}

enum ContentType {
  json(value: "application/json"),
  multipart(value: "multipart/form-data"),
  urlencoded(value: "application/x-www-form-urlencoded"),
  plain(value: "text/plain");

  const ContentType({required this.value});
  final String value;

  static bool isValidType(String? contentType) {
    if (contentType == null) return false;

    for (ContentType type in ContentType.values)
      if (contentType.contains(type.value)) return true;

    return false;
  }

  static ContentType? getType(String? type) {
    if(type == null) return null;
    for (ContentType t in ContentType.values) {
      if (type.contains(t.value)) return t;
    }

    return null;
  }
}
