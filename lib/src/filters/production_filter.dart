import '../logger.dart';
import '../log_filter.dart';

/// Prints all logs with `level >= Logger.level` even in production.
class ProductionFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return event.level.index >= Logger.level.index;
  }
}
