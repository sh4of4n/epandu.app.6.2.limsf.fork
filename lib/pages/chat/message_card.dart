import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../common_library/services/model/replymessage_model.dart';
import '../../common_library/utils/capitalize_firstletter.dart';
import 'chat_room.dart';
import 'chat_theme.dart';
import 'date_formater.dart';
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
    return Container(
        margin: localUser == messageDetails.userId
            ? const EdgeInsets.fromLTRB(100, 0, 10, 10)
            : const EdgeInsets.fromLTRB(10, 0, 100, 10),
        child: getMessage());
  }

  Widget getMessage() {
    return Padding(
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        localUser == messageDetails.userId! ? 64.0 : 16.0,
        4,
        localUser == messageDetails.userId! ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        // align the child within the container
        alignment: localUser == messageDetails.userId!
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            border: localUser != messageDetails.userId!
                ? Border.all(
                    color: Colors.blueAccent,
                  )
                : Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(17),
          ),
          child: DecoratedBox(
            // chat bubble decoration
            decoration: BoxDecoration(
              color: localUser == messageDetails.userId!
                  ? Colors.blueAccent
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (roomDesc.toUpperCase().contains("GROUP"))
                    if (localUser != messageDetails.userId!)
                      Text(
                        CapitalizeFirstLetter()
                            .capitalizeFirstLetter(messageDetails.nickName!),
                        style: MyTheme.heading2.copyWith(fontSize: 13),
                      ),
                  replyMessageDetails.replyToId == 0
                      ? isSearching && searchKey != ''
                          ? buildRichText(searchKey, messageDetails.msgBody!,
                              localUser, messageDetails.userId!)
                          : Text(
                              messageDetails.msgBody!,
                              style: MyTheme.bodyText1.copyWith(
                                  color: localUser == messageDetails.userId!
                                      ? Colors.white
                                      : Colors.black87),
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
                                    style: MyTheme.bodyText1),
                              ),
                            )
                          ],
                        ),
                  localUser == messageDetails.userId!
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
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
                              const SizedBox(
                                width: 5,
                              ),
                              getStatusIcon(
                                messageDetails.msgStatus!,
                                messageDetails.sendDateTime!,
                              ),
                            ],
                          ),
                        )
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                DateFormatter()
                                    .getVerboseDateTimeRepresentation(
                                        DateTime.parse(
                                            messageDetails.sendDateTime!)),
                                style: MyTheme.bodyTextTime,
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getStatusIcon(String status, String sentTime) {
    int timeInMinutes =
        DateTime.now().difference(DateTime.parse(sentTime)).inMinutes;
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
    } else if (status == "UNREAD") {
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
          style: TextStyle(
              backgroundColor: Colors.grey,
              color:
                  localUserId == messageUserId ? Colors.white : Colors.black87),
        ),
      ),
    );

    startIndex = match.end;
  }

  if (startIndex < fullText.length) {
    final String remainingText = fullText.substring(startIndex);
    textSpans.add(TextSpan(
        text: remainingText,
        style: TextStyle(
            color:
                localUserId == messageUserId ? Colors.white : Colors.black87)));
  }

  return RichText(
    text: TextSpan(
      children: textSpans,
    ),
  );
}
