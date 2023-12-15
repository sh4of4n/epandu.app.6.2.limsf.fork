import 'package:flutter/material.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../common_library/services/model/replymessage_model.dart';
import '../../common_library/utils/capitalize_firstletter.dart';
import 'chat_room.dart';
import 'chat_theme.dart';
import 'date_formater.dart';
import 'message_status.dart';
import 'reply_message_widget.dart';

class MessageCard extends StatelessWidget {
  const MessageCard(
      {super.key,
      required this.messageDetails,
      required this.localUser,
      required this.replyMessageDetails,
      required this.onCancelReply,
      required this.callback,
      required this.resendCallback,
      required this.roomDesc,
      required this.searchKey,
      required this.isSearching});

  final MessageDetails messageDetails;
  final String localUser;
  final VoidCallback onCancelReply;
  final MyCallback callback;
  final ResendCallback resendCallback;
  final ReplyMessageDetails replyMessageDetails;
  final String roomDesc;
  final String searchKey;
  final bool isSearching;

  @override
  Widget build(BuildContext context) {
    return Container(child: getMessage(context));
  }

  Widget getMessage(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        localUser == messageDetails.userId! ? 64.0 : 16.0,
        3,
        localUser == messageDetails.userId! ? 16.0 : 64.0,
        3,
      ),
      child: Align(
        alignment: localUser == messageDetails.userId!
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 150, // Set a minimum width for the ConstrainedBox
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
            ),
            //margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: localUser == messageDetails.userId!
                    ? Colors.blueAccent.withOpacity(0.3)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (roomDesc.toUpperCase().contains("GROUP") &&
                          localUser != messageDetails.userId!)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 5,
                            right: 30,
                          ),
                          child: Text(
                            CapitalizeFirstLetter().capitalizeFirstLetter(
                                messageDetails.nickName!),
                            style: MyTheme.heading2.copyWith(fontSize: 13),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 2,
                          bottom: 5,
                        ),
                        child: replyMessageDetails.replyToId == 0
                            ? isSearching && searchKey != ''
                                ? buildRichText(
                                    searchKey,
                                    messageDetails.msgBody!,
                                    localUser,
                                    messageDetails.userId!)
                                : Text(
                                    messageDetails.msgBody!,
                                    style: MyTheme.bodyText1.copyWith(
                                        color: Colors.black87,
                                        fontSize: 14.0 * textScaleFactor),
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
                                      child: Text(messageDetails.msgBody!,
                                          style: MyTheme.bodyText1
                                              .copyWith(color: Colors.black87)),
                                    ),
                                  )
                                ],
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 5,
                        ),
                        child: localUser == messageDetails.userId!
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (messageDetails.editDateTime != '' &&
                                      messageDetails.editDateTime != null)
                                    const Icon(
                                      Icons.edit,
                                      size: 20,
                                      semanticLabel: "Edited",
                                    ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    DateFormatter()
                                        .getVerboseDateTimeRepresentation(
                                            DateTime.parse(
                                                messageDetails.sendDateTime!)),
                                    style: MyTheme.isMebodyTextTime,
                                  ),
                                  const SizedBox(width: 5),
                                  StatusIcon(
                                    status: messageDetails.msgStatus!,
                                    sentTime: messageDetails.sendDateTime!,
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    DateFormatter()
                                        .getVerboseDateTimeRepresentation(
                                            DateTime.parse(
                                                messageDetails.sendDateTime!)),
                                    style: MyTheme.bodyTextTime,
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Old Code
  // Widget getMessage() {
  //   return Padding(
  //     // asymmetric padding
  //     padding: EdgeInsets.fromLTRB(
  //       localUser == messageDetails.userId! ? 64.0 : 16.0,
  //       3,
  //       localUser == messageDetails.userId! ? 16.0 : 64.0,
  //       3,
  //     ),
  //     child: Align(
  //       // align the child within the container
  //       alignment: localUser == messageDetails.userId!
  //           ? Alignment.centerRight
  //           : Alignment.centerLeft,
  //       child: Container(
  //         decoration: BoxDecoration(
  //           // border: localUser != messageDetails.userId!
  //           //     ? Border.all(
  //           //         color: Colors.blueAccent,
  //           //       )
  //           //     : Border.all(color: Colors.grey),
  //           borderRadius: BorderRadius.circular(17),
  //         ),
  //         child: DecoratedBox(
  //           // chat bubble decoration
  //           decoration: BoxDecoration(
  //             color: localUser == messageDetails.userId!
  //                 ? Colors.blueAccent.withOpacity(0.3)
  //                 : Colors.grey[300],
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(12),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 if (roomDesc.toUpperCase().contains("GROUP"))
  //                   if (localUser != messageDetails.userId!)
  //                     Text(
  //                       CapitalizeFirstLetter()
  //                           .capitalizeFirstLetter(messageDetails.nickName!),
  //                       style: MyTheme.heading2.copyWith(fontSize: 13),
  //                     ),
  //                 replyMessageDetails.replyToId == 0
  //                     ? isSearching && searchKey != ''
  //                         ? buildRichText(searchKey, messageDetails.msgBody!,
  //                             localUser, messageDetails.userId!)
  //                         : Text(
  //                             messageDetails.msgBody!,
  //                             style: MyTheme.bodyText1.copyWith(
  //                                 color: localUser == messageDetails.userId!
  //                                     ? Colors.black87
  //                                     : Colors.black87),
  //                           )
  //                     : Column(
  //                         crossAxisAlignment: CrossAxisAlignment.end,
  //                         children: [
  //                           buildReplyMessage(replyMessageDetails),
  //                           const Divider(
  //                             color: Colors.white,
  //                             height: 20,
  //                             thickness: 2,
  //                             indent: 10,
  //                             endIndent: 10,
  //                           ),
  //                           Align(
  //                             alignment: Alignment.centerLeft,
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(5.0),
  //                               child: Text(messageDetails.msgBody!,
  //                                   style: MyTheme.bodyText1),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                 localUser == messageDetails.userId!
  //                     ? Align(
  //                         alignment: Alignment.bottomRight,
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             if (messageDetails.editDateTime != '' &&
  //                                 messageDetails.editDateTime != null)
  //                               const Icon(
  //                                 Icons.edit,
  //                                 size: 20,
  //                                 semanticLabel: "Edited",
  //                               ),
  //                             const SizedBox(
  //                               width: 5,
  //                             ),
  //                             Text(
  //                               DateFormatter()
  //                                   .getVerboseDateTimeRepresentation(
  //                                       DateTime.parse(
  //                                           messageDetails.sendDateTime!)),
  //                               style: MyTheme.isMebodyTextTime,
  //                             ),
  //                             const SizedBox(
  //                               width: 5,
  //                             ),
  //                             StatusIcon(
  //                               status: messageDetails.msgStatus!,
  //                               sentTime: messageDetails.sendDateTime!,
  //                             ),
  //                           ],
  //                         ),
  //                       )
  //                     : Align(
  //                         alignment: Alignment.bottomRight,
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             Text(
  //                               DateFormatter()
  //                                   .getVerboseDateTimeRepresentation(
  //                                       DateTime.parse(
  //                                           messageDetails.sendDateTime!)),
  //                               style: MyTheme.bodyTextTime,
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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

  RichText buildRichText(String searchText, String fullText, String localUserId,
      String messageUserId) {
    List<InlineSpan> textSpans = [];
    final RegExp regex = RegExp(searchText, caseSensitive: false);
    int startIndex = 0;

    for (final match in regex.allMatches(fullText)) {
      final String beforeMatch = fullText.substring(startIndex, match.start);
      final String matchingText = fullText.substring(match.start, match.end);

      if (beforeMatch.isNotEmpty) {
        textSpans.add(TextSpan(text: beforeMatch));
      }

      textSpans.add(
        WidgetSpan(
          child: Text(
            matchingText,
            style: const TextStyle(
                backgroundColor: Colors.grey, color: Colors.black87),
          ),
        ),
      );

      startIndex = match.end;
    }

    if (startIndex < fullText.length) {
      final String remainingText = fullText.substring(startIndex);
      textSpans.add(TextSpan(
          text: remainingText, style: const TextStyle(color: Colors.black87)));
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }
}
