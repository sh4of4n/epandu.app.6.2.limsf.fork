import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:video_player/video_player.dart';
import '../../common_library/services/model/replymessage_model.dart';
import '../../common_library/utils/capitalize_firstletter.dart';
import 'chat_home.dart';
import 'chat_theme.dart';
import 'date_formater.dart';
import 'package:flick_video_player/flick_video_player.dart';
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
  //late Future<VideoPlayerController> _futureController;
  // late VideoPlayerController _controller;
  late FlickManager flickManager;
  // Future<VideoPlayerController> createVideoPlayer() async {
  //   final File file = new File(widget.filePath);
  //   _controller = VideoPlayerController.file(file);
  //   await _controller.initialize();
  //   await _controller.setLooping(true);
  //   return _controller;
  // }

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.file(new File(widget.filePath)),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: getVideoCard());
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
                            ? Container(
                                child: FlickVideoPlayer(
                                  flickManager: flickManager,
                                  flickVideoWithControls:
                                      FlickVideoWithControls(
                                    controls: IconTheme(
                                        data:
                                            IconThemeData(color: Colors.white),
                                        child: FlickPortraitControls(
                                          progressBarSettings:
                                              FlickProgressBarSettings(
                                            bufferedColor:
                                                Colors.white.withOpacity(0.2),
                                            playedColor: Colors.white,
                                            handleColor: Colors.white,
                                          ),
                                        )),
                                  ),
                                  flickVideoWithControlsFullscreen:
                                      FlickVideoWithControls(
                                    controls: FlickLandscapeControls(),
                                  ),
                                ),
                              )
                            // FullScreenWidget(
                            //     child: Center(
                            //       child: AspectRatio(
                            //           aspectRatio:
                            //               _controller.value.aspectRatio,
                            //           child: Stack(
                            //             children: [
                            //               ClipRRect(
                            //                   borderRadius:
                            //                       BorderRadius.circular(8.0),
                            //                   child: VideoPlayer(_controller)),
                            //               Positioned(
                            //                   bottom: 0,
                            //                   width: MediaQuery.of(context)
                            //                       .size
                            //                       .width,
                            //                   child: VideoProgressIndicator(
                            //                     _controller,
                            //                     allowScrubbing: false,
                            //                     colors: VideoProgressColors(
                            //                         backgroundColor:
                            //                             Colors.blueGrey,
                            //                         bufferedColor:
                            //                             Colors.blueGrey,
                            //                         playedColor:
                            //                             Colors.blueAccent),
                            //                   )),
                            //               Positioned(
                            //                 bottom: 0,
                            //                 child: GestureDetector(
                            //                   onTap: () {
                            //                     setState(() {
                            //                       if (_controller
                            //                           .value.isPlaying) {
                            //                         _controller.pause();
                            //                       } else {
                            //                         // If the video is paused, play it.
                            //                         _controller.play();
                            //                       }
                            //                     });
                            //                   },
                            //                   child: Icon(
                            //                     _controller.value.isPlaying
                            //                         ? Icons.pause
                            //                         : Icons.play_arrow,
                            //                     color: Colors.white,
                            //                     size: 50,
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //           )),
                            //     ),
                            //   )
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
                                        child: Container(
                                          child: FlickVideoPlayer(
                                            flickManager: flickManager,
                                            flickVideoWithControls:
                                                FlickVideoWithControls(
                                              controls: FlickPortraitControls(),
                                            ),
                                            flickVideoWithControlsFullscreen:
                                                FlickVideoWithControls(
                                              controls:
                                                  FlickLandscapeControls(),
                                            ),
                                          ),
                                        )
                                        // FullScreenWidget(
                                        //   child: Center(
                                        //     child: AspectRatio(
                                        //         aspectRatio:
                                        //             _controller.value.aspectRatio,
                                        //         child: Stack(
                                        //           children: [
                                        //             ClipRRect(
                                        //                 borderRadius:
                                        //                     BorderRadius.circular(
                                        //                         8.0),
                                        //                 child: VideoPlayer(
                                        //                     _controller)),
                                        //             Positioned(
                                        //                 bottom: 0,
                                        //                 width:
                                        //                     MediaQuery.of(context)
                                        //                         .size
                                        //                         .width,
                                        //                 child:
                                        //                     VideoProgressIndicator(
                                        //                   _controller,
                                        //                   allowScrubbing: false,
                                        //                   colors: VideoProgressColors(
                                        //                       backgroundColor:
                                        //                           Colors.blueGrey,
                                        //                       bufferedColor:
                                        //                           Colors.blueGrey,
                                        //                       playedColor: Colors
                                        //                           .blueAccent),
                                        //                 )),
                                        //             Positioned(
                                        //               bottom: 0,
                                        //               child: GestureDetector(
                                        //                 onTap: () {
                                        //                   setState(() {
                                        //                     if (_controller.value
                                        //                         .isPlaying) {
                                        //                       _controller.pause();
                                        //                     } else {
                                        //                       // If the video is paused, play it.
                                        //                       _controller.play();
                                        //                     }
                                        //                   });
                                        //                 },
                                        //                 child: Icon(
                                        //                   _controller
                                        //                           .value.isPlaying
                                        //                       ? Icons.pause
                                        //                       : Icons.play_arrow,
                                        //                   color: Colors.white,
                                        //                   size: 50,
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         )),
                                        //   ),
                                        // ),
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
        color: Colors.black,
        size: 20,
      );
    }
  }
}
