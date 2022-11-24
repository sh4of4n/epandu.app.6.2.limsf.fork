import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../common_library/services/model/replymessage_model.dart';
import 'chat_home.dart';
import 'chat_theme.dart';
import 'date_formater.dart';
import 'reply_message_widget.dart';

class MessageCard extends StatelessWidget {
  const MessageCard(
      {Key? key,
      required this.messageDetails,
      required this.localUser,
      required this.replyMessageDetails,
      required this.onCancelReply,
      required this.callback,
      required this.resendCallback})
      : super(key: key);

  final MessageDetails messageDetails;
  final String localUser;
  final VoidCallback onCancelReply;
  final MyCallback callback;
  final ResendCallback resendCallback;
  final ReplyMessageDetails replyMessageDetails;
  @override
  Widget build(BuildContext context) {
    // int timeInMinutes =
    //     DateTime.now().difference(DateTime.parse(messageDetails.send_datetime!)).inMinutes;
    // return getMessage();
    return Container(
        margin: localUser == messageDetails.user_id
            ? EdgeInsets.fromLTRB(50, 0, 10, 10)
            : EdgeInsets.fromLTRB(10, 0, 50, 10),
        child: getMessage()
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   mainAxisAlignment:
        //       localUser == user ? MainAxisAlignment.end : MainAxisAlignment.start,
        //   children: [
        //     timeInMinutes > 1 && msgStatus == "SENDING"
        //         ? InkWell(
        //             onTap: () {
        //               resendCallback(messageId);
        //             },
        //             child: Icon(Icons.send),
        //           )
        //         : SizedBox.shrink(),
        //     getMessage()
        //   ],
        // ),
        );
  }

  Widget getMessage() {
    const styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      borderColor: Colors.blue,
      borderWidth: 1,
      elevation: 4,
      margin: BubbleEdges.only(top: 10),
      alignment: Alignment.topRight,
    );
    const styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      borderColor: Colors.blueGrey,
      borderWidth: 1,
      elevation: 4,
      margin: BubbleEdges.only(top: 10),
      alignment: Alignment.topLeft,
    );

    return Bubble(
      style: localUser == messageDetails.user_id! ? styleMe : styleSomebody,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Text(
            messageDetails.nick_name!
            // .split(" ")
            // .map((str) =>
            //     "${nick_name[0].toUpperCase()}${nick_name.substring(1).toLowerCase()}")
            // .join(" ")
            ,
            style: MyTheme.heading2.copyWith(fontSize: 13),
          ),
          replyMessageDetails.reply_to_id == 0
              ? Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Text(messageDetails.msg_body!,
                      style: MyTheme.bodyText1),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildReplyMessage(replyMessageDetails),
                    Divider(
                      color: Colors.grey[500],
                      height: 20,
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: new Text(messageDetails.msg_body!,
                            style: MyTheme.bodyText1),
                      ),
                    )
                  ],
                ),
          localUser == messageDetails.user_id!
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (messageDetails.edit_datetime != '')
                      Icon(
                        Icons.edit,
                        size: 20,
                        semanticLabel: "Edited",
                      ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormatter().getVerboseDateTimeRepresentation(
                          DateTime.parse(messageDetails.send_datetime!)),
                      style: MyTheme.bodyTextTime,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    getStatusIcon(
                      messageDetails.msgStatus!,
                      messageDetails.send_datetime!,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormatter().getVerboseDateTimeRepresentation(
                          DateTime.parse(messageDetails.send_datetime!)),
                      style: MyTheme.bodyTextTime,
                    )
                  ],
                ),
        ],
      ),
    );
  }

  Widget getStatusIcon(String status, String sentTime) {
    int timeInMinutes =
        DateTime.now().difference(DateTime.parse(sentTime)).inMinutes;
    if (timeInMinutes == 1 && status == "SENDING") {
      return Icon(
        Icons.sms_failed_outlined,
        size: 20,
        semanticLabel: "Failed",
      );
    }
    if (status == "SENDING") {
      return JumpingDots(
        color: Colors.yellow,
        radius: 10,
        numberOfDots: 3,
        animationDuration: Duration(milliseconds: 200),
      );
    } else if (status == "SENT") {
      return Icon(
        Icons.done,
        size: 20,
      );
    } else {
      return Icon(
        Icons.done_all,
        color: Colors.blue,
        size: 20,
      );
    }
  }

  Widget buildReplyMessage(ReplyMessageDetails replyMessageDetails) {
    if (replyMessageDetails.reply_to_id == 0) {
      return Container();
    } else {
      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        margin: EdgeInsets.only(bottom: 8),
        child: InkWell(
          onTap: () {
            callback(replyMessageDetails.reply_to_id!);
          },
          child: ReplyMessageWidget(
              messageDetails: replyMessageDetails,
              onCancelReply: onCancelReply,
              type: "MESSAGE"),
        ),
      );
    }
  }
}
