import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:open_file/open_file.dart';
import '../../common_library/services/model/replymessage_model.dart';
import 'chat_home.dart';
import 'chat_theme.dart';
import 'date_formater.dart';
import 'reply_message_widget.dart';

class FileCard extends StatelessWidget {
  final String time;
  final String nick_name;
  final String text;
  final String file_path;
  final String user;
  final String localUser;
  final String msgStatus;
  final int messageId;
  final VoidCallback onCancelReply;
  final MyCallback callback;
  final ReplyMessageDetails replyMessageDetails;
  const FileCard(
      {Key? key,
      required this.time,
      required this.nick_name,
      required this.text,
      required this.file_path,
      required this.user,
      required this.localUser,
      required this.msgStatus,
      required this.messageId,
      required this.replyMessageDetails,
      required this.onCancelReply,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      borderColor: Colors.blueGrey,
      borderWidth: 1,
      elevation: 4,
      margin: BubbleEdges.only(top: 10),
      alignment: Alignment.topLeft,
    );

    const styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      borderColor: Colors.blue,
      borderWidth: 1,
      elevation: 4,
      margin: BubbleEdges.only(top: 10),
      alignment: Alignment.topRight,
    );

    return Container(
      margin: localUser == user
          ? EdgeInsets.fromLTRB(100, 0, 10, 10)
          : EdgeInsets.fromLTRB(10, 0, 100, 10),
      child: Bubble(
          style: localUser == user ? styleMe : styleSomebody,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* new Text(messageId.toString().toUpperCase(),
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.redAccent,
                  )),*/
              new Text(nick_name,
                  // nick_name != ''
                  //     ? nick_name
                  //         .split(" ")
                  //         .map((str) =>
                  //             "${nick_name[0].toUpperCase()}${nick_name.substring(1).toLowerCase()}")
                  //         .join(" ")
                  //     : nick_name,
                  style: MyTheme.heading2.copyWith(fontSize: 13)),
              file_path != ''
                  ? replyMessageDetails.reply_to_id == 0
                      ? Container(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              OpenFile.open(file_path);
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.7,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                //crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(Icons.file_copy),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: text.length > 20
                                        ? Text(
                                            text.substring(0, 20) +
                                                '.' +
                                                text.split('.').last,
                                            overflow: TextOverflow.ellipsis,
                                            style: MyTheme.bodyText1,
                                          )
                                        : Text(
                                            text,
                                            overflow: TextOverflow.ellipsis,
                                            style: MyTheme.bodyText1,
                                          ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Icon(Icons.download),
                                ],
                              ),
                            ),
                          ),
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
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.file_copy),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: text.length > 20
                                            ? Text(
                                                text.substring(0, 20) +
                                                    '.' +
                                                    text.split('.').last,
                                                overflow: TextOverflow.ellipsis,
                                                style: MyTheme.bodyText1,
                                              )
                                            : Text(
                                                text,
                                                overflow: TextOverflow.ellipsis,
                                                style: MyTheme.bodyText1,
                                              ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(Icons.download),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                  : Container(
                      child: Center(
                          child: Text(
                        'No File From Server',
                        style: MyTheme.bodyText1,
                      )),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      "." + text.split('.').last,
                      style: MyTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  localUser == user
                      ? Row(
                          children: [
                            Text(
                              DateFormatter().getVerboseDateTimeRepresentation(
                                  DateTime.parse(time)),
                              //DateFormat('hh:mm:ss').format(DateTime.parse(time)),
                              style: MyTheme.bodyTextTime,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            getStatusIcon(msgStatus)
                          ],
                        )
                      : Row(
                          children: [
                            Text(
                              DateFormatter().getVerboseDateTimeRepresentation(
                                  DateTime.parse(time)),
                              //DateFormat('hh:mm:ss').format(DateTime.parse(time)),
                              style: MyTheme.bodyTextTime,
                            )
                          ],
                        ),
                ],
              ),
            ],
          )),
    );
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

  Widget getStatusIcon(String status) {
    int timeInMinutes =
        DateTime.now().difference(DateTime.parse(time)).inMinutes;
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
}
