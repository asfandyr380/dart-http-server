import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import '../utils/errors/request_error.dart';
import '../utils/logger.dart';
import 'body.dart';
import 'request.dart';
import 'response.dart';

class Server {
  final int port;
  final List<dynamic> routes;
  final String ip;
  Server({required this.port, this.routes = const []}) : ip = "0.0.0.0";
  Logger logger = Logger();

  Future<void> start() async {
    ServerSocket server = await ServerSocket.bind(ip, port);
    logger.info("Server started at port $port");

    await for (Socket client in server) {
      client
          .transform(utf8.decoder.cast())
          .listen((data) => _handleStream(client, data));
    }
  }

  void _handleStream(Socket client, dynamic data) async {
    try {
      final Request request = Request.parse(data);
      logger.info(
        "${request.method.name} ${request.path} ${request.version} ${client.remoteAddress.host}",
      );

      final Response response = Response(
        body: Body(data: {"sending": "data"}),
      );

      String res = response.build();
      client.write(res);
      await client.flush();
      await client.close();
    } on RequestError catch (e) {
      inspect(e);
      client.write("HTTP/1.1 404 NOT FOUND\r\n");
      await client.flush();
      await client.close();
    }
  }
}
