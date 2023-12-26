import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

class StatusIcon extends StatefulWidget {
  const StatusIcon(
      {super.key,
      required this.status,
      required this.sentTime,
      required this.messageType});
  final String status;
  final String sentTime;
  final String messageType;
  @override
  State<StatusIcon> createState() => _StatusIconState();
}

class _StatusIconState extends State<StatusIcon> {
  @override
  Widget build(BuildContext context) {
    return getStatusIcon(widget.status, widget.sentTime, widget.messageType);
  }

  Widget getStatusIcon(String status, String sentTime, String messageType) {
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
      return Icon(Icons.done,
          size: 15,
          color: messageType != 'image' ? Colors.black : Colors.white);
    } else if (status == "UNREAD") {
      return Icon(Icons.done,
          size: 15,
          color: messageType != 'image' ? Colors.black : Colors.white);
    } else {
      return Icon(
        Icons.done_all,
        color: messageType != 'image' ? Colors.black : Colors.white,
        size: 15,
      );
    }
  }
}
