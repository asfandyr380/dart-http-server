import '../lib/core/server.dart';
import '../lib/utils/logger.dart';

void main() async {
  await Logger().initialize("logs/server.log"); 
  final server = Server(port: 3000);
  await server.start();
}