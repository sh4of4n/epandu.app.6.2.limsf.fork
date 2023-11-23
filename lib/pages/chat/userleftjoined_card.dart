import 'package:flutter/material.dart';

import '../../common_library/services/model/chat_mesagelist.dart';

class UserLeftJoinedCard extends StatelessWidget {
  const UserLeftJoinedCard({
    super.key,
    required this.messageDetails,
  });

  final MessageDetails messageDetails;

  @override
  Widget build(BuildContext context) {
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
            messageDetails.msgBody!,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
