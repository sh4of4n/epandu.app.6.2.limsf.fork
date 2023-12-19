import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSeparator extends StatelessWidget {
  final DateTime date;

  const DateSeparator({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(date);

    String formattedDate;
    if (difference.inDays == 0) {
      // If the message is from today, display "Today"
      formattedDate = 'Today';
    } else if (difference.inDays < 7) {
      // If the date is within the current week, display the day name
      formattedDate = DateFormat('EEEE').format(date); // Day name
    } else {
      // Otherwise, display the full date
      formattedDate = DateFormat('MMMM dd, yyyy').format(date);
    }
    return Align(
      alignment: Alignment.center,
      child: Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              color: Colors.grey,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            formattedDate,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
