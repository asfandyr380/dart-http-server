import '../../core/request.dart';

class RequestError implements Exception {
  final String message;
  final Request? req;
  
  const RequestError([this.message = "", this.req]);
}

