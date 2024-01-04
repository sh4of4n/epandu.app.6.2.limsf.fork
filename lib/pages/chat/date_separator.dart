import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSeparator extends StatelessWidget {
  final DateTime date;

  const DateSeparator({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    //final difference = now.difference(date);

    DateTime yesterday = now.subtract(const Duration(days: 1));
    String formattedDate;
    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      formattedDate = 'Today';
    } else if (date.day == yesterday.day &&
        date.month == now.month &&
        date.year == now.year) {
      formattedDate = 'Yesterday';
    }
    // else if (difference.inDays < 7) {
    //   formattedDate = DateFormat('EEEE').format(date); // Day name
    // }
    else {
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
