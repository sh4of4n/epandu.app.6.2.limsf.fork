import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

class StatusIcon extends StatefulWidget {
  const StatusIcon({
    super.key,
    required this.status,
    required this.sentTime,
  });
  final String status;
  final String sentTime;
  @override
  State<StatusIcon> createState() => _StatusIconState();
}

class _StatusIconState extends State<StatusIcon> {
  @override
  Widget build(BuildContext context) {
    return getStatusIcon(widget.status, widget.sentTime);
  }

  Widget getStatusIcon(String status, String sentTime) {
    int timeInMinutes =
        DateTime.now().difference(DateTime.parse(sentTime)).inMinutes;
    if (timeInMinutes == 1 && status == "SENDING") {
      return const Icon(
        Icons.sms_failed_outlined,
        size: 15,
        semanticLabel: "Failed",
      );
    }
    if (status == "SENDING") {
      return JumpingDots(
        color: Colors.yellow,
        radius: 10,
        numberOfDots: 3,
        animationDuration: const Duration(milliseconds: 200),
      );
    } else if (status == "SENT") {
      return const Icon(
        Icons.done,
        size: 15,
      );
    } else if (status == "UNREAD") {
      return const Icon(
        Icons.done,
        size: 15,
      );
    } else {
      return const Icon(
        Icons.done_all,
        color: Colors.black,
        size: 15,
      );
    }
  }
}
