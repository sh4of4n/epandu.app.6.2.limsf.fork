import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter();

  String getVerboseDateTimeRepresentation(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(const Duration(seconds: 5));
    DateTime localDateTime = dateTime.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return 'Just now';
    }
    String roughTimeString = DateFormat('jm').format(dateTime);

    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Today,$roughTimeString';
    }

    DateTime yesterday = now.subtract(const Duration(days: 1));

    if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Yesterday ${DateFormat('jm').format(dateTime)}';
    }

    return '${DateFormat('dd MMM, yyyy').format(dateTime)} $roughTimeString';
  }

  String getDateTimeRepresentation(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(const Duration(seconds: 5));
    DateTime localDateTime = dateTime.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return 'Just now';
    }
    String roughTimeString = DateFormat('jm').format(dateTime);

    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return roughTimeString;
    }

    DateTime yesterday = now.subtract(const Duration(days: 1));

    if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Yesterday ';
    }

    return DateFormat('MM-dd-yy').format(dateTime);
  }
}
