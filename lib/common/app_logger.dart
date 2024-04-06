import 'package:logger/logger.dart';

class AppLogger {
  const AppLogger._();

  static final _logger = Logger();

  static void d(String message) {
    _logger.d(message);
  }

  static Future<void> e(String message, {Object? error, StackTrace? stackTrace}) async {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
