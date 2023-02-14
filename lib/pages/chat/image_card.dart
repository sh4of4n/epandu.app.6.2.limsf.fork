import 'dart:io';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:jumping_dot/jumping_dot.dart';

import '../../common_library/services/model/replymessage_model.dart';
import 'chat_home.dart';
import 'chat_theme.dart';
import 'date_formater.dart';
import 'reply_message_widget.dart';

class ImageCard extends StatelessWidget {
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
  final String roomDesc;
  final ReplyMessageDetails replyMessageDetails;
  const ImageCard(
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
      required this.callback,
      required this.roomDesc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* double imageHeight=0;
    getImageHeight(file_path).then((value) => imageHeight=value);*/
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
              if (roomDesc.toUpperCase().contains("GROUP")) ...[
                new Text(
                  nick_name,
                  style: MyTheme.heading2.copyWith(fontSize: 13),
                ),
                Container(
                    //height: 200,
                    // width: 200,
                    child: file_path != ''
                        ? replyMessageDetails.reply_to_id == 0
                            ? FullScreenWidget(
                                child: Center(
                                child: Hero(
                                  tag: file_path.split('/').last,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.file(
                                        File(file_path),
                                        fit: BoxFit.cover,
                                        height: 384,
                                        width: 384,
                                      )),
                                ),
                              ))
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
                                      child: FullScreenWidget(
                                          child: Center(
                                        child: Hero(
                                          tag: file_path.split('/').last,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.file(File(file_path),
                                                  fit: BoxFit.cover)),
                                        ),
                                      )),
                                    ),
                                  )
                                ],
                              )
                        : Container(
                            child: Center(
                                child: Text('No Image from server',
                                    style: MyTheme.bodyText1)),
                          ))

                /* FutureBuilder<double>(
                future: getImageHeight(file_path),
                builder: (context, snapshot) {
                  return Container(
                      height: snapshot.data,
                      child: Image.file(File(file_path), fit: BoxFit.cover));
                },
              )*/
                /*Image.memory(base64Decode(binary), fit: BoxFit.fitWidth):*/
                ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        style: MyTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    localUser == user
                        ? Row(
                            children: [
                              Text(
                                DateFormatter()
                                    .getVerboseDateTimeRepresentation(
                                        DateTime.parse(time)),
                                //DateFormat('hh:mm:ss').format(DateTime.parse(time)),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              getStatusIcon(msgStatus, time)
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                DateFormatter()
                                    .getVerboseDateTimeRepresentation(
                                        DateTime.parse(time)),
                                //DateFormat('hh:mm:ss').format(DateTime.parse(time)),
                                style: MyTheme.bodyTextTime,
                              ),
                            ],
                          ),
                  ],
                ),
              ] else ...[
                Container(
                    //height: 200,
                    // width: 200,
                    child: file_path != ''
                        ? replyMessageDetails.reply_to_id == 0
                            ? FullScreenWidget(
                                child: Center(
                                child: Hero(
                                  tag: file_path.split('/').last,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.file(
                                        File(file_path),
                                        fit: BoxFit.cover,
                                        // height: 384,
                                        // width: 384,
                                      )),
                                ),
                              ))
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
                                      child: FullScreenWidget(
                                          child: Center(
                                        child: Hero(
                                          tag: file_path.split('/').last,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.file(File(file_path),
                                                  fit: BoxFit.cover)),
                                        ),
                                      )),
                                    ),
                                  )
                                ],
                              )
                        : Container(
                            child: Center(
                                child: Text('No Image from server',
                                    style: MyTheme.bodyText1)),
                          ))

                /* FutureBuilder<double>(
                future: getImageHeight(file_path),
                builder: (context, snapshot) {
                  return Container(
                      height: snapshot.data,
                      child: Image.file(File(file_path), fit: BoxFit.cover));
                },
              )*/
                /*Image.memory(base64Decode(binary), fit: BoxFit.fitWidth):*/
                ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        style: MyTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    localUser == user
                        ? Row(
                            children: [
                              Text(
                                DateFormatter()
                                    .getVerboseDateTimeRepresentation(
                                        DateTime.parse(time)),
                                //DateFormat('hh:mm:ss').format(DateTime.parse(time)),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              getStatusIcon(msgStatus, time)
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                DateFormatter()
                                    .getVerboseDateTimeRepresentation(
                                        DateTime.parse(time)),
                                //DateFormat('hh:mm:ss').format(DateTime.parse(time)),
                                style: MyTheme.bodyTextTime,
                              ),
                            ],
                          ),
                  ],
                ),
              ]
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
}

Widget getStatusIcon(String status, String time) {
  int timeInMinutes = DateTime.now().difference(DateTime.parse(time)).inMinutes;
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

Future<double> getImageHeight(String filePath) async {
  File image = new File(filePath);
  var decodedImage = await decodeImageFromList(image.readAsBytesSync());
  return decodedImage.height.toDouble();
}
