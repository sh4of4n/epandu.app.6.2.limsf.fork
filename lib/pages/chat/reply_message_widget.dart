import 'dart:io';
import 'package:flutter/material.dart';
import '../../common_library/services/model/replymessage_model.dart';
import '../../common_library/utils/capitalize_firstletter.dart';
import 'chat_theme.dart';

class ReplyMessageWidget extends StatefulWidget {
  final ReplyMessageDetails messageDetails;
  final VoidCallback onCancelReply;
  final String type;
  const ReplyMessageWidget(
      {super.key,
      required this.messageDetails,
      required this.onCancelReply,
      required this.type});

  @override
  State<ReplyMessageWidget> createState() => _ReplyMessageWidgetState();
}

class _ReplyMessageWidgetState extends State<ReplyMessageWidget> {
  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          children: [
            Container(
              color: Colors.green,
              width: 4,
            ),
            const SizedBox(width: 8),
            Expanded(child: buildReplyMessage()),
          ],
        ),
      );
  Widget buildReplyMessage() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  CapitalizeFirstLetter()
                      .capitalizeFirstLetter(widget.messageDetails.nickName!),
                  style: MyTheme.heading2.copyWith(fontSize: 13),
                ),
              ),
              if (widget.type != "MESSAGE")
                GestureDetector(
                  onTap: widget.onCancelReply,
                  child: const Icon(Icons.close, size: 16),
                )
            ],
          ),
          const SizedBox(height: 8),
          getChild(widget.messageDetails),
          const SizedBox(height: 10),
        ],
      );

  Widget getChild(ReplyMessageDetails replyMessageDetails) {
    if (replyMessageDetails.filePath == '') {
      return Expanded(
        child: Text(
          widget.messageDetails.msgBody!,
          style: MyTheme.bodyText1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else if (replyMessageDetails.filePath?.split('.').last.toUpperCase() ==
            "PNG" ||
        replyMessageDetails.filePath?.split('.').last.toUpperCase() == "JPG" ||
        replyMessageDetails.filePath?.split('.').last.toUpperCase() == "JPEG") {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.file(
            File(replyMessageDetails.filePath!),
            fit: BoxFit.fill,
            height: 100,
            width: 100,
          ),
        ],
      );
    } else if (replyMessageDetails.filePath?.split('.').last.toUpperCase() ==
        "MP3") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.mic,
            size: 30,
          ),
          Text('Audio File', style: MyTheme.bodyText1)
        ],
      );
    } else if (replyMessageDetails.filePath?.split('.').last.toUpperCase() ==
        "MP4") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.videocam_sharp,
            size: 30,
          ),
          Text(
            'video File',
            style: MyTheme.bodyText1,
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Icon(
            Icons.file_copy,
            size: 30,
          ),
          Text(
            'File',
            style: MyTheme.bodyText1,
          )
        ],
      );
    }
  }
}
