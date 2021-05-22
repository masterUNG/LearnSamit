import 'package:logger/logger.dart';

class AppLogger extends Logger {

  static AppLogger _instance;

  factory AppLogger()  {
    _instance ??= AppLogger._internal();
    return _instance;
  }

  AppLogger._internal() : super(
    printer: PrettyPrinter(
      printEmojis: false,
      methodCount: 0,
    ),
  );

  static AppLogger get instance {
    return _instance;
  }
}
