import 'package:intl/intl.dart';

class DateFormatterUtility {
  static String formatDate(String? dateString) {
    if (dateString == null) return 'Not set';
    final date = DateTime.parse(dateString);
    return DateFormat('MMM d, yyyy').format(date);
  }

  static String formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    return '${duration.inHours}h ${duration.inMinutes % 60}m ${duration.inSeconds % 60}s';
  }
}
