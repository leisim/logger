import 'dart:convert';

import 'package:logger/src/logger.dart';
import 'package:logger/src/log_printer.dart';

/// Outputs simple log messages:
/// ```
/// [E] Log message  ERROR: Error info
/// ```
class SimplePrinter extends LogPrinter {
  static final levelPrefixes = {
    Level.verbose: '[V]',
    Level.debug: '[D]',
    Level.info: '[I]',
    Level.warning: '[W]',
    Level.error: '[E]',
    Level.wtf: '[WTF]',
  };

  final bool printTime;

  SimplePrinter({this.printTime = false});

  @override
  List<String> log(LogEvent event) {
    var messageStr = stringifyMessage(event.message);
    var errorStr = event.error != null ? "  ERROR: ${event.error}" : "";
    var timeStr = printTime ? "TIME: ${DateTime.now().toIso8601String()}" : "";
    return ["${levelPrefixes[event.level]} $timeStr $messageStr$errorStr"];
  }

  String stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      var encoder = JsonEncoder.withIndent(null);
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }
}
