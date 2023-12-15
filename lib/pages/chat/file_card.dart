import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import '../../common_library/services/model/replymessage_model.dart';
import '../../common_library/utils/capitalize_firstletter.dart';
import 'chat_room.dart';
import 'chat_theme.dart';
import 'date_formater.dart';
import 'message_status.dart';
import 'reply_message_widget.dart';

class FileCard extends StatelessWidget {
  final String time;
  final String roomDesc;
  final String nickName;
  final String text;
  final String filePath;
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
    return Container(child: getFileCard(context));
  }

  Widget getFileCard(BuildContext context) {
    return Padding(
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        localUser == user ? 64.0 : 16.0,
        3,
        localUser == user ? 16.0 : 64.0,
        3,
      ),
      child: Align(
        // align the child within the container
        alignment:
            localUser == user ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            // border: localUser != user
            //     ? Border.all(color: Colors.blueAccent)
            //     : Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(17),
          ),
          child: DecoratedBox(
            // chat bubble decoration
            decoration: BoxDecoration(
              color: localUser == user
                  ? Colors.blueAccent.withOpacity(0.3)
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (roomDesc.toUpperCase().contains("GROUP"))
                      if (localUser != user)
                        Text(
                            CapitalizeFirstLetter()
                                .capitalizeFirstLetter(nickName),
                            style: MyTheme.heading2.copyWith(fontSize: 13)),
                    filePath != ''
                        ? replyMessageDetails.replyToId == 0
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    OpenFile.open(filePath);
                                  },
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      //crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const Icon(Icons.file_copy),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: text.length > 20
                                              ? Text(
                                                  '${text.substring(0, 20)}.${text.split('.').last}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: MyTheme.bodyText1,
                                                )
                                              : Text(
                                                  text,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: MyTheme.bodyText1,
                                                ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        const Icon(Icons.download),
                                      ],
                                    ),
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
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            const Icon(Icons.file_copy),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: text.length > 20
                                                  ? Text(
                                                      '${text.substring(0, 20)}.${text.split('.').last}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: MyTheme.bodyText1,
                                                    )
                                                  : Text(
                                                      text,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: MyTheme.bodyText1,
                                                    ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            const Icon(Icons.download),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                        : Center(
                            child: Text(
                            'No File From Server',
                            style: MyTheme.bodyText1,
                          )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 5, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              ".${text.split('.').last}",
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
                                      style: MyTheme.isMebodyTextTime,
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
                                      DateFormatter()
                                          .getVerboseDateTimeRepresentation(
                                              DateTime.parse(time)),
                                      //DateFormat('hh:mm:ss').format(DateTime.parse(time)),
                                      style: MyTheme.bodyTextTime,
                                    )
                                  ],
                                ),
                        ],
                      ),
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
