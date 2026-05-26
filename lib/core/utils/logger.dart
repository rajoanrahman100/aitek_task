import 'package:logger/logger.dart';

export 'package:logger/logger.dart';

/// Pre-configured global [Logger] instance for use throughout the project.
final logger = Logger(
  printer: PrettyPrinter(
    methodCount:
        2, // Shows 2 methods in stacktrace to trace where the log originated
    errorMethodCount: 8, // Shows 8 methods for errors
    lineLength: 90,
    colors: true,
    printEmojis: true,
  ),
);
