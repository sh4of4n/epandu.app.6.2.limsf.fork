import 'dart:io';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:video_player/video_player.dart';
import '../../common_library/services/model/replymessage_model.dart';
import '../../common_library/utils/capitalize_firstletter.dart';
import 'chat_home.dart';
import 'chat_theme.dart';
import 'date_formater.dart';

import 'reply_message_widget.dart';

class VideoCard extends StatefulWidget {
  final String filePath;
  final String nickName;
  final String time;
  final String text;
  final String user;
  final String localUser;
  final String msgStatus;
  final int messageId;
  final String roomDesc;
  final MyCallback callback;
  final VoidCallback onCancelReply;
  final ReplyMessageDetails replyMessageDetails;
  const VideoCard(
      {Key? key,
      required this.filePath,
      required this.nickName,
      required this.time,
      required this.text,
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
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late Future<VideoPlayerController> _futureController;
  late VideoPlayerController _controller;

  Future<VideoPlayerController> createVideoPlayer() async {
    final File file = new File(widget.filePath);
    _controller = VideoPlayerController.file(file);
    await _controller.initialize();
    await _controller.setLooping(true);
    return _controller;
  }

  @override
  void initState() {
    _futureController = createVideoPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: widget.localUser == widget.user
        //     ? EdgeInsets.fromLTRB(100, 0, 10, 10)
        //     : EdgeInsets.fromLTRB(10, 0, 100, 10),
        child: getVideoCard()
        // Bubble(
        //     style: widget.localUser == widget.user ? styleMe : styleSomebody,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         if (widget.roomDesc.toUpperCase().contains("GROUP")) ...[
        //           Align(
        //             alignment: Alignment.topLeft,
        //             child:
        //                 /* new Text(widget.messageId.toString().toUpperCase(),
        //               style: new TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 16,
        //                 color: Colors.red[300],
        //               )),*/
        //                 new Text(widget.nick_name,
        //                     // widget.nick_name != ''
        //                     //     ? widget.nick_name
        //                     //         .split(" ")
        //                     //         .map((str) =>
        //                     //             "${widget.nick_name[0].toUpperCase()}${widget.nick_name.substring(1).toLowerCase()}")
        //                     //         .join(" ")
        //                     //     : widget.nick_name,
        //                     style: MyTheme.heading2.copyWith(fontSize: 13)),
        //           ),
        //           widget.file_path != ''
        //               ? widget.replyMessageDetails.reply_to_id == 0
        //                   ? FullScreenWidget(
        //                       child: Center(
        //                         child: AspectRatio(
        //                             aspectRatio: 16 / 9,
        //                             child: Stack(
        //                               children: [
        //                                 ClipRRect(
        //                                     borderRadius:
        //                                         BorderRadius.circular(8.0),
        //                                     child: VideoPlayer(_controller)),
        //                                 Positioned(
        //                                     bottom: 0,
        //                                     width:
        //                                         MediaQuery.of(context).size.width,
        //                                     child: VideoProgressIndicator(
        //                                       _controller,
        //                                       allowScrubbing: false,
        //                                       colors: VideoProgressColors(
        //                                           backgroundColor:
        //                                               Colors.blueGrey,
        //                                           bufferedColor: Colors.blueGrey,
        //                                           playedColor: Colors.blueAccent),
        //                                     )),
        //                                 Center(
        //                                   child: GestureDetector(
        //                                     onTap: () {
        //                                       setState(() {
        //                                         if (_controller.value.isPlaying) {
        //                                           _controller.pause();
        //                                         } else {
        //                                           // If the video is paused, play it.
        //                                           _controller.play();
        //                                         }
        //                                       });
        //                                     },
        //                                     child: Icon(
        //                                       _controller.value.isPlaying
        //                                           ? Icons.pause
        //                                           : Icons.play_arrow,
        //                                       color: Colors.white,
        //                                       size: 80,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ],
        //                             )),
        //                       ),
        //                     )
        //                   : Column(
        //                       crossAxisAlignment: CrossAxisAlignment.end,
        //                       children: [
        //                         buildReplyMessage(widget.replyMessageDetails),
        //                         Divider(
        //                           color: Colors.grey[500],
        //                           height: 20,
        //                           thickness: 2,
        //                           indent: 10,
        //                           endIndent: 10,
        //                         ),
        //                         Align(
        //                           alignment: Alignment.centerLeft,
        //                           child: Padding(
        //                             padding: const EdgeInsets.all(5.0),
        //                             child: FullScreenWidget(
        //                               child: Center(
        //                                 child: AspectRatio(
        //                                     aspectRatio: 16 / 9,
        //                                     child: Stack(
        //                                       children: [
        //                                         ClipRRect(
        //                                             borderRadius:
        //                                                 BorderRadius.circular(
        //                                                     8.0),
        //                                             child:
        //                                                 VideoPlayer(_controller)),
        //                                         Positioned(
        //                                             bottom: 0,
        //                                             width: MediaQuery.of(context)
        //                                                 .size
        //                                                 .width,
        //                                             child: VideoProgressIndicator(
        //                                               _controller,
        //                                               allowScrubbing: false,
        //                                               colors: VideoProgressColors(
        //                                                   backgroundColor:
        //                                                       Colors.blueGrey,
        //                                                   bufferedColor:
        //                                                       Colors.blueGrey,
        //                                                   playedColor:
        //                                                       Colors.blueAccent),
        //                                             )),
        //                                         Center(
        //                                           child: GestureDetector(
        //                                             onTap: () {
        //                                               setState(() {
        //                                                 if (_controller
        //                                                     .value.isPlaying) {
        //                                                   _controller.pause();
        //                                                 } else {
        //                                                   // If the video is paused, play it.
        //                                                   _controller.play();
        //                                                 }
        //                                               });
        //                                             },
        //                                             child: Icon(
        //                                               _controller.value.isPlaying
        //                                                   ? Icons.pause
        //                                                   : Icons.play_arrow,
        //                                               color: Colors.white,
        //                                               size: 80,
        //                                             ),
        //                                           ),
        //                                         ),
        //                                       ],
        //                                     )),
        //                               ),
        //                             ),
        //                           ),
        //                         )
        //                       ],
        //                     )
        //               : Container(
        //                   child: Center(
        //                       child: Text('No Video From Server',
        //                           style: MyTheme.bodyText1)),
        //                 ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Expanded(
        //                 child: Text(
        //                   widget.text,
        //                   style: MyTheme.bodyText1,
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //               ),
        //               widget.localUser == widget.user
        //                   ? Row(
        //                       children: [
        //                         Text(
        //                           DateFormatter()
        //                               .getVerboseDateTimeRepresentation(
        //                                   DateTime.parse(widget.time)),
        //                           //DateFormat('hh:mm:ss').format(DateTime.parse(widget.time).toLocal()),
        //                           style: MyTheme.bodyTextTime,
        //                         ),
        //                         SizedBox(
        //                           width: 5,
        //                         ),
        //                         getStatusIcon(widget.msgStatus)
        //                       ],
        //                     )
        //                   : Row(
        //                       children: [
        //                         Text(
        //                           DateFormatter()
        //                               .getVerboseDateTimeRepresentation(
        //                                   DateTime.parse(widget.time)),
        //                           //DateFormat('hh:mm:ss').format(DateTime.parse(widget.time).toLocal()),
        //                           style: MyTheme.bodyTextTime,
        //                         )
        //                       ],
        //                     ),
        //             ],
        //           ),
        //         ] else ...[
        //           widget.file_path != ''
        //               ? widget.replyMessageDetails.reply_to_id == 0
        //                   ? FullScreenWidget(
        //                       child: Center(
        //                         child: AspectRatio(
        //                             aspectRatio: 16 / 9,
        //                             child: Stack(
        //                               children: [
        //                                 ClipRRect(
        //                                     borderRadius:
        //                                         BorderRadius.circular(8.0),
        //                                     child: VideoPlayer(_controller)),
        //                                 Positioned(
        //                                     bottom: 0,
        //                                     width:
        //                                         MediaQuery.of(context).size.width,
        //                                     child: VideoProgressIndicator(
        //                                       _controller,
        //                                       allowScrubbing: false,
        //                                       colors: VideoProgressColors(
        //                                           backgroundColor:
        //                                               Colors.blueGrey,
        //                                           bufferedColor: Colors.blueGrey,
        //                                           playedColor: Colors.blueAccent),
        //                                     )),
        //                                 Center(
        //                                   child: GestureDetector(
        //                                     onTap: () {
        //                                       setState(() {
        //                                         if (_controller.value.isPlaying) {
        //                                           _controller.pause();
        //                                         } else {
        //                                           // If the video is paused, play it.
        //                                           _controller.play();
        //                                         }
        //                                       });
        //                                     },
        //                                     child: Icon(
        //                                       _controller.value.isPlaying
        //                                           ? Icons.pause
        //                                           : Icons.play_arrow,
        //                                       color: Colors.white,
        //                                       size: 80,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ],
        //                             )),
        //                       ),
        //                     )
        //                   : Column(
        //                       crossAxisAlignment: CrossAxisAlignment.end,
        //                       children: [
        //                         buildReplyMessage(widget.replyMessageDetails),
        //                         Divider(
        //                           color: Colors.grey[500],
        //                           height: 20,
        //                           thickness: 2,
        //                           indent: 10,
        //                           endIndent: 10,
        //                         ),
        //                         Align(
        //                           alignment: Alignment.centerLeft,
        //                           child: Padding(
        //                             padding: const EdgeInsets.all(5.0),
        //                             child: FullScreenWidget(
        //                               child: Center(
        //                                 child: AspectRatio(
        //                                     aspectRatio: 16 / 9,
        //                                     child: Stack(
        //                                       children: [
        //                                         ClipRRect(
        //                                             borderRadius:
        //                                                 BorderRadius.circular(
        //                                                     8.0),
        //                                             child:
        //                                                 VideoPlayer(_controller)),
        //                                         Positioned(
        //                                             bottom: 0,
        //                                             width: MediaQuery.of(context)
        //                                                 .size
        //                                                 .width,
        //                                             child: VideoProgressIndicator(
        //                                               _controller,
        //                                               allowScrubbing: false,
        //                                               colors: VideoProgressColors(
        //                                                   backgroundColor:
        //                                                       Colors.blueGrey,
        //                                                   bufferedColor:
        //                                                       Colors.blueGrey,
        //                                                   playedColor:
        //                                                       Colors.blueAccent),
        //                                             )),
        //                                         Center(
        //                                           child: GestureDetector(
        //                                             onTap: () {
        //                                               setState(() {
        //                                                 if (_controller
        //                                                     .value.isPlaying) {
        //                                                   _controller.pause();
        //                                                 } else {
        //                                                   // If the video is paused, play it.
        //                                                   _controller.play();
        //                                                 }
        //                                               });
        //                                             },
        //                                             child: Icon(
        //                                               _controller.value.isPlaying
        //                                                   ? Icons.pause
        //                                                   : Icons.play_arrow,
        //                                               color: Colors.white,
        //                                               size: 80,
        //                                             ),
        //                                           ),
        //                                         ),
        //                                       ],
        //                                     )),
        //                               ),
        //                             ),
        //                           ),
        //                         )
        //                       ],
        //                     )
        //               : Container(
        //                   child: Center(
        //                       child: Text('No Video From Server',
        //                           style: MyTheme.bodyText1)),
        //                 ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Expanded(
        //                 child: Text(
        //                   widget.text,
        //                   style: MyTheme.bodyText1,
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //               ),
        //               widget.localUser == widget.user
        //                   ? Row(
        //                       children: [
        //                         Text(
        //                           DateFormatter()
        //                               .getVerboseDateTimeRepresentation(
        //                                   DateTime.parse(widget.time)),
        //                           //DateFormat('hh:mm:ss').format(DateTime.parse(widget.time).toLocal()),
        //                           style: MyTheme.bodyTextTime,
        //                         ),
        //                         SizedBox(
        //                           width: 5,
        //                         ),
        //                         getStatusIcon(widget.msgStatus)
        //                       ],
        //                     )
        //                   : Row(
        //                       children: [
        //                         Text(
        //                           DateFormatter()
        //                               .getVerboseDateTimeRepresentation(
        //                                   DateTime.parse(widget.time)),
        //                           //DateFormat('hh:mm:ss').format(DateTime.parse(widget.time).toLocal()),
        //                           style: MyTheme.bodyTextTime,
        //                         )
        //                       ],
        //                     ),
        //             ],
        //           ),
        //         ]
        //       ],
        //     )),
        );
  }

  Widget getVideoCard() {
    return Padding(
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        widget.localUser == widget.user ? 64.0 : 16.0,
        4,
        widget.localUser == widget.user ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        // align the child within the container
        alignment: widget.localUser == widget.user
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            border: widget.localUser != widget.user
                ? Border.all(color: Colors.blueAccent)
                : Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(17),
          ),
          child: DecoratedBox(
            // chat bubble decoration
            decoration: BoxDecoration(
              color: widget.localUser == widget.user
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
                    if (widget.roomDesc.toUpperCase().contains("GROUP"))
                      if (widget.localUser != widget.user)
                        Align(
                          alignment: Alignment.topLeft,
                          child: new Text(
                              CapitalizeFirstLetter()
                                  .capitalizeFirstLetter(widget.nickName),
                              style: MyTheme.heading2.copyWith(fontSize: 13)),
                        ),
                    widget.filePath != ''
                        ? widget.replyMessageDetails.reply_to_id == 0
                            ? FullScreenWidget(
                                child: Center(
                                  child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: VideoPlayer(_controller)),
                                          Positioned(
                                              bottom: 0,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: VideoProgressIndicator(
                                                _controller,
                                                allowScrubbing: false,
                                                colors: VideoProgressColors(
                                                    backgroundColor:
                                                        Colors.blueGrey,
                                                    bufferedColor:
                                                        Colors.blueGrey,
                                                    playedColor:
                                                        Colors.blueAccent),
                                              )),
                                          Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (_controller
                                                      .value.isPlaying) {
                                                    _controller.pause();
                                                  } else {
                                                    // If the video is paused, play it.
                                                    _controller.play();
                                                  }
                                                });
                                              },
                                              child: Icon(
                                                _controller.value.isPlaying
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                color: Colors.white,
                                                size: 80,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  buildReplyMessage(widget.replyMessageDetails),
                                  Divider(
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
                                          child: AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: VideoPlayer(
                                                          _controller)),
                                                  Positioned(
                                                      bottom: 0,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child:
                                                          VideoProgressIndicator(
                                                        _controller,
                                                        allowScrubbing: false,
                                                        colors: VideoProgressColors(
                                                            backgroundColor:
                                                                Colors.blueGrey,
                                                            bufferedColor:
                                                                Colors.blueGrey,
                                                            playedColor: Colors
                                                                .blueAccent),
                                                      )),
                                                  Center(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (_controller.value
                                                              .isPlaying) {
                                                            _controller.pause();
                                                          } else {
                                                            // If the video is paused, play it.
                                                            _controller.play();
                                                          }
                                                        });
                                                      },
                                                      child: Icon(
                                                        _controller
                                                                .value.isPlaying
                                                            ? Icons.pause
                                                            : Icons.play_arrow,
                                                        color: Colors.white,
                                                        size: 80,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                        : Container(
                            child: Center(
                                child: Text('No Video From Server',
                                    style: MyTheme.bodyText1)),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            // widget.text,
                            '',
                            style: MyTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        widget.localUser == widget.user
                            ? Row(
                                children: [
                                  Text(
                                    DateFormatter()
                                        .getVerboseDateTimeRepresentation(
                                            DateTime.parse(widget.time)),
                                    //DateFormat('hh:mm:ss').format(DateTime.parse(widget.time).toLocal()),
                                    style: MyTheme.isMebodyTextTime,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  getStatusIcon(widget.msgStatus)
                                ],
                              )
                            : Row(
                                children: [
                                  Text(
                                    DateFormatter()
                                        .getVerboseDateTimeRepresentation(
                                            DateTime.parse(widget.time)),
                                    //DateFormat('hh:mm:ss').format(DateTime.parse(widget.time).toLocal()),
                                    style: MyTheme.bodyTextTime,
                                  )
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
    if (replyMessageDetails.reply_to_id == 0) {
      return Container();
    } else {
      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        margin: EdgeInsets.only(bottom: 8),
        child: InkWell(
            onTap: () {
              widget.callback(replyMessageDetails.reply_to_id!);
            },
            child: ReplyMessageWidget(
                messageDetails: replyMessageDetails,
                onCancelReply: widget.onCancelReply,
                type: "MESSAGE")),
      );
    }
  }

  Widget getStatusIcon(String status) {
    int timeInMinutes =
        DateTime.now().difference(DateTime.parse(widget.time)).inMinutes;
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
