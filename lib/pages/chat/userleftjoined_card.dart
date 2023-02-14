import 'package:flutter/material.dart';

import '../../common_library/services/model/chat_mesagelist.dart';

class UserLeftJoinedCard extends StatelessWidget {
  const UserLeftJoinedCard({
    Key? key,
    required this.messageDetails,
  }) : super(key: key);

  final MessageDetails messageDetails;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding: EdgeInsets.all(10.0),
          child: Text(
            messageDetails.msg_body!,
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
