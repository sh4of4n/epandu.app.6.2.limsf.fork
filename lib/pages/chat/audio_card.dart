import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/util/flutter_sound_helper.dart';
import 'package:jumping_dot/jumping_dot.dart';
import '../../common_library/services/model/replymessage_model.dart';
import '../../common_library/utils/capitalize_firstletter.dart';
import 'chat_room.dart';
import 'chat_theme.dart';
import 'date_formater.dart';
import 'reply_message_widget.dart';

typedef Fn = void Function();

class AudioCard extends StatefulWidget {
  final String time;
  final String nickName;
  final String text;
  final String filePath;
  final String user;
  final String localUser;
  final String msgStatus;
  final String roomDesc;
  final int messageId;
  final VoidCallback onCancelReply;
  final ReplyMessageDetails replyMessageDetails;
  final MyCallback callback;
  const AudioCard(
      {super.key,
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
      required this.roomDesc});

  @override
  State<AudioCard> createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
  bool isPlaying = false;
  Duration duration = const Duration();
  final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  final FlutterSoundHelper flutterSoundHelper = FlutterSoundHelper();
  bool _mPlayerIsInited = false;
  StreamSubscription? _mPlayerSubscription;
  Duration pos = const Duration();
  @override
  void initState() {
    super.initState();
    init().then((value) {
      if (mounted) {
        setState(() {
          _mPlayerIsInited = true;
        });
      }
    });
  }

  Future<void> init() async {
    /*Duration d  = await flutterSoundHelper.duration(widget.file_path) ?? Duration.zero;
    duration=d;*/
    //print(widget.file_path + '_' + duration.toString());
    await _mPlayer.openPlayer();
    await _mPlayer.setSubscriptionDuration(const Duration(milliseconds: 10));
    _mPlayerSubscription = _mPlayer.onProgress?.listen((e) {
      duration = e.duration;
      setPos(e.position);
      setState(() {});
    });
  }

  @override
  void dispose() {
    stopPlayer(_mPlayer);
    cancelPlayerSubscriptions();
    _mPlayer.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: getAudio());
  }

  Widget getAudio() {
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
                  : Colors.grey[200],
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
                          Text(
                            CapitalizeFirstLetter()
                                .capitalizeFirstLetter(widget.nickName),
                            style: MyTheme.heading2.copyWith(fontSize: 13),
                          ),
                      widget.filePath != ''
                          ? widget.replyMessageDetails.replyToId == 0
                              ? Container(
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: getPlaybackFn(_mPlayer),
                                          child: Icon(
                                            _mPlayer.isPlaying
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            size: 40,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              isPlaying
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            pos
                                                                .toString()
                                                                .split('.')[0],
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black45)),
                                                        const SizedBox(
                                                          width: 50,
                                                        ),
                                                        Text(
                                                            (pos - duration)
                                                                .toString()
                                                                .split('.')[0],
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black45)),
                                                      ],
                                                    )
                                                  : Container(),
                                              Flexible(
                                                child: Slider(
                                                  value:
                                                      pos.inSeconds.toDouble(),
                                                  min: 0.0,
                                                  max: duration.inSeconds
                                                      .toDouble(),
                                                  onChanged: seek,
                                                  //divisions: 100
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    buildReplyMessage(
                                        widget.replyMessageDetails),
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
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap:
                                                      getPlaybackFn(_mPlayer),
                                                  child: const Icon(
                                                    Icons.play_arrow,
                                                    size: 30,
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Flexible(
                                                      child: Slider(
                                                        value: 0,
                                                        min: 0.0,
                                                        max: 0,
                                                        onChanged:
                                                            (double value) {},
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                          : Center(
                              child: Text('No Audio From Server',
                                  style: MyTheme.bodyText1),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              // widget.text,
                              '',
                              style: MyTheme.bodyText1.copyWith(
                                  color: widget.localUser == widget.user
                                      ? Colors.white
                                      : Colors.black87),
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
                                      //DateFormat('hh:mm:ss').format(DateTime.parse(widget.time)),
                                      style: MyTheme.isMebodyTextTime,
                                    ),
                                    const SizedBox(
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
                                      //DateFormat('hh:mm:ss').format(DateTime.parse(widget.time)),
                                      style: MyTheme.bodyTextTime,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ])),
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
            widget.callback(replyMessageDetails.replyToId!);
          },
          child: ReplyMessageWidget(
              messageDetails: replyMessageDetails,
              onCancelReply: widget.onCancelReply,
              type: "MESSAGE"),
        ),
      );
    }
  }

  Widget getStatusIcon(String status) {
    int timeInMinutes =
        DateTime.now().difference(DateTime.parse(widget.time)).inMinutes;
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

  Fn? getPlaybackFn(FlutterSoundPlayer? player) {
    if (!_mPlayerIsInited) {
      return null;
    }

    return player!.isStopped
        ? () {
            setState(() {
              isPlaying = true;
            });
            play(player);
          }
        : () {
            stopPlayer(player).then((value) => setState(() {
                  isPlaying = false;
                }));
          };
  }

  void play(FlutterSoundPlayer? player) async {
    File file = File(widget.filePath);
    Uint8List uint8list = await file.readAsBytes();
    await player!.startPlayer(
        // fromURI: widget.filePath,
        fromDataBuffer: uint8list,
        whenFinished: () {
          setState(() {
            isPlaying = false;
          });
        });
    setState(() {});
  }

  Future<void> stopPlayer(FlutterSoundPlayer player) async {
    await player.stopPlayer();
  }

  Future<void> setPos(Duration d) async {
    if (d > duration) {
      d = duration;
    }
    setState(() {
      pos = d;
      // print('pos_ {$pos}');
      // print('duration {$duration}');
    });
  }

  Future<void> seek(double d) async {
    await _mPlayer.seekToPlayer(Duration(milliseconds: d.floor()));
    await setPos(Duration(milliseconds: d.floor()));
  }

  void cancelPlayerSubscriptions() {
    if (_mPlayerSubscription != null) {
      _mPlayerSubscription!.cancel();
      _mPlayerSubscription = null;
    }
  }
}
