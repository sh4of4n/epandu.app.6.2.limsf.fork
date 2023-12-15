import 'dart:io';
import 'package:flutter/material.dart';
import '../../common_library/services/model/replymessage_model.dart';
import '../../common_library/utils/capitalize_firstletter.dart';
import 'chat_room.dart';
import 'chat_theme.dart';
import 'date_formater.dart';
import 'full_image.dart';
import 'message_status.dart';
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
        // margin: localUser == user
        //     ? const EdgeInsets.fromLTRB(100, 0, 0, 0)
        //     : const EdgeInsets.fromLTRB(0, 0, 100, 0),
        child: getImageCard(context));
  }

  Widget getImageCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        localUser == user ? 64.0 : 16.0,
        3,
        localUser == user ? 16.0 : 64.0,
        3,
      ),
      child: Align(
        alignment:
            localUser == user ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: localUser == user
                ? Colors.blueAccent.withOpacity(0.3)
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (roomDesc.toUpperCase().contains("GROUP") &&
                      localUser != user)
                    Text(
                      CapitalizeFirstLetter().capitalizeFirstLetter(nickName),
                      style: MyTheme.heading2.copyWith(fontSize: 13),
                    ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImagePage(
                            imageUrl: filePath,
                            heroTag: filePath.split('/').last,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: filePath != ''
                          ? replyMessageDetails.replyToId == 0
                              ? Hero(
                                  tag: filePath.split('/').last,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.file(
                                      File(filePath),
                                      fit: BoxFit.cover,
                                      height: 300,
                                      width: 250,
                                    ),
                                  ),
                                )
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
                                        child: Hero(
                                          tag: filePath.split('/').last,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              child: Image.file(File(filePath),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                          : Center(
                              child: Text('No Image from server',
                                  style: MyTheme.bodyText1)),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 10, right: 10, bottom: 5, top: 10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Expanded(
                  //         child: Text(
                  //           text,
                  //           style: MyTheme.bodyText1,
                  //           overflow: TextOverflow.ellipsis,
                  //         ),
                  //       ),
                  //       localUser == user
                  //           ? Row(
                  //               children: [
                  //                 Text(
                  //                   DateFormatter()
                  //                       .getVerboseDateTimeRepresentation(
                  //                           DateTime.parse(time)),
                  //                   style: MyTheme.isMebodyTextTime,
                  //                 ),
                  //                 const SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 StatusIcon(
                  //                   status: msgStatus,
                  //                   sentTime: time,
                  //                 ),
                  //               ],
                  //             )
                  //           : Row(
                  //               children: [
                  //                 Text(
                  //                   DateFormatter()
                  //                       .getVerboseDateTimeRepresentation(
                  //                           DateTime.parse(time)),
                  //                   style: MyTheme.bodyTextTime,
                  //                 ),
                  //               ],
                  //             ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: localUser == user
                      ? Row(
                          children: [
                            Text(
                              DateFormatter().getVerboseDateTimeRepresentation(
                                  DateTime.parse(time)),
                              style: localUser == user
                                  ? MyTheme.isMebodyTextTime
                                      .copyWith(color: Colors.white)
                                  : MyTheme.bodyTextTime,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            StatusIcon(
                              status: msgStatus,
                              sentTime: time,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Text(
                              DateFormatter().getVerboseDateTimeRepresentation(
                                  DateTime.parse(time)),
                              style: MyTheme.bodyTextTime
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                ),
              ),
            ],
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

Future<double> getImageHeight(String filePath) async {
  File image = File(filePath);
  var decodedImage = await decodeImageFromList(image.readAsBytesSync());
  return decodedImage.height.toDouble();
}
