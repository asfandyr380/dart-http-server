import 'dart:io';

class Logger {
  String filePath = "";
  late File _file;

  static final Logger _singleton = Logger._internal();

  factory Logger() {
    return _singleton;
  }

  Logger._internal();

  Future<void> initialize(String path) async {
    filePath = path;
    _file = File(filePath);
    if (!await _file.exists()) {
      await _file.create(recursive: true);
    }
  }

  Future<void> log(
    String message, {
    String level = 'INFO',
    bool printToConsole = true,
  }) async {
    assert(filePath.isNotEmpty, "file path cannot be empty");

    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '[$timestamp] [$level] $message';
    if (printToConsole) print(logMessage);
    await _file.writeAsString('$logMessage\n', mode: FileMode.append);
  }

  Future<void> info(String message) => log(message, level: 'INFO');
  Future<void> warning(String message) => log(message, level: 'WARNING');
  Future<void> error(String message) => log(message, level: 'ERROR');
}
