import 'dart:io';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:jumping_dot/jumping_dot.dart';

import '../../common_library/services/model/replymessage_model.dart';
import '../../common_library/utils/capitalize_firstletter.dart';
import 'chat_home.dart';
import 'chat_theme.dart';
import 'date_formater.dart';
import 'reply_message_widget.dart';

class ImageCard extends StatelessWidget {
  final String time;
  final String nickName;
  final String text;
  final String filePath;
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
      required this.nickName,
      required this.text,
      required this.filePath,
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
    return Container(
        margin: localUser == user
            ? const EdgeInsets.fromLTRB(100, 0, 10, 10)
            : const EdgeInsets.fromLTRB(10, 0, 100, 10),
        child: getImageCard());
  }

  Widget getImageCard() {
    return Padding(
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        localUser == user ? 64.0 : 16.0,
        4,
        localUser == user ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        // align the child within the container
        alignment:
            localUser == user ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            border: localUser != user
                ? Border.all(color: Colors.blueAccent)
                : Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(17),
          ),
          child: DecoratedBox(
            // chat bubble decoration
            decoration: BoxDecoration(
              color: localUser == user ? Colors.blueAccent : Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (roomDesc.toUpperCase().contains("GROUP"))
                      if (localUser != user)
                        Text(
                          CapitalizeFirstLetter()
                              .capitalizeFirstLetter(nickName),
                          style: MyTheme.heading2.copyWith(fontSize: 13),
                        ),
                    Container(
                        //height: 200,
                        // width: 200,
                        child: filePath != ''
                            ? replyMessageDetails.replyToId == 0
                                ? FullScreenWidget(
                                    child: Center(
                                    child: Hero(
                                      tag: filePath.split('/').last,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.file(
                                            File(filePath),
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
                                      const Divider(
                                        color: Colors.white,
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
                                              tag: filePath.split('/').last,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.file(
                                                      File(filePath),
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
                              )),
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
                                    style: MyTheme.isMebodyTextTime,
                                  ),
                                  const SizedBox(
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
                                    style: MyTheme.bodyTextTime,
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget buildReplyMessage(ReplyMessageDetails replyMessageDetails) {
    if (replyMessageDetails.replyToId == 0) {
      return Container();
    } else {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        margin: const EdgeInsets.only(bottom: 8),
        child: InkWell(
          onTap: () {
            callback(replyMessageDetails.replyToId!);
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
    return const Icon(
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
      animationDuration: const Duration(milliseconds: 200),
    );
  } else if (status == "SENT") {
    return const Icon(
      Icons.done,
      size: 20,
    );
  } else {
    return const Icon(
      Icons.done_all,
      color: Colors.black,
      size: 20,
    );
  }
}

Future<double> getImageHeight(String filePath) async {
  File image = File(filePath);
  var decodedImage = await decodeImageFromList(image.readAsBytesSync());
  return decodedImage.height.toDouble();
}
