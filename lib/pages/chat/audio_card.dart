import 'dart:async';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/util/flutter_sound_helper.dart';
import 'package:jumping_dot/jumping_dot.dart';
import '../../common_library/services/model/replymessage_model.dart';
import 'chat_home.dart';
import 'chat_theme.dart';
import 'date_formater.dart';
import 'reply_message_widget.dart';

typedef Fn = void Function();

class AudioCard extends StatefulWidget {
  final String time;
  final String nick_name;
  final String text;
  final String file_path;
  final String user;
  final String localUser;
  final String msgStatus;
  final int messageId;
  final VoidCallback onCancelReply;
  final ReplyMessageDetails replyMessageDetails;
  final MyCallback callback;
  const AudioCard(
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
      required this.callback})
      : super(key: key);

  @override
  State<AudioCard> createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
  bool isPlaying = false;
  Duration duration = new Duration();
  final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  final FlutterSoundHelper flutterSoundHelper = FlutterSoundHelper();
  bool _mPlayerIsInited = false;
  StreamSubscription? _mPlayerSubscription;
  Duration pos = new Duration();
  @override
  void initState() {
    super.initState();
    init().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });
  }

  Future<void> init() async {
    /*Duration d  = await flutterSoundHelper.duration(widget.file_path) ?? Duration.zero;
    duration=d;*/
    //print(widget.file_path + '_' + duration.toString());
    await _mPlayer.openPlayer();
    await _mPlayer.setSubscriptionDuration(Duration(milliseconds: 10));
    _mPlayerSubscription = _mPlayer.onProgress!.listen((e) {
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
      margin: widget.localUser == widget.user
          ? EdgeInsets.fromLTRB(50, 0, 10, 10)
          : EdgeInsets.fromLTRB(10, 0, 50, 10),
      // width:  MediaQuery.of(context).size.width * 0.5,
      child: Bubble(
          style: widget.localUser == widget.user ? styleMe : styleSomebody,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text(
                widget.nick_name,
                // widget.nick_name != ''
                //     ? widget.nick_name,
                //         .split(" ")
                //         .map((str) =>
                //             "${widget.nick_name[0].toUpperCase()}${widget.nick_name.substring(1).toLowerCase()}")
                //         .join(" ")
                //     : widget.nick_name,
                style: MyTheme.heading2.copyWith(fontSize: 13),
              ),
              widget.file_path != ''
                  ? widget.replyMessageDetails.reply_to_id == 0
                      ? Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                                                    style: TextStyle(
                                                        color: Colors.black45)),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                Text(
                                                    (pos - duration)
                                                        .toString()
                                                        .split('.')[0],
                                                    style: TextStyle(
                                                        color: Colors.black45)),
                                              ],
                                            )
                                          : Container(),
                                      Flexible(
                                        child: Slider(
                                          value: pos.inSeconds.toDouble(),
                                          min: 0.0,
                                          max: duration.inSeconds.toDouble(),
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
                            buildReplyMessage(widget.replyMessageDetails),
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
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: getPlaybackFn(_mPlayer),
                                          child: Icon(
                                            Icons.play_arrow,
                                            size: 30,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Flexible(
                                              child: Slider(
                                                value: 0,
                                                min: 0.0,
                                                max: 0,
                                                onChanged: (double value) {},
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
                  : Container(
                      child: Center(
                        child: Text('No Audio From Server',
                            style: MyTheme.bodyText1),
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      widget.text,
                      style: MyTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  widget.localUser == widget.user
                      ? Row(
                          children: [
                            Text(
                              DateFormatter().getVerboseDateTimeRepresentation(
                                  DateTime.parse(widget.time)),
                              //DateFormat('hh:mm:ss').format(DateTime.parse(widget.time)),
                              style: MyTheme.bodyTextTime,
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
                              DateFormatter().getVerboseDateTimeRepresentation(
                                  DateTime.parse(widget.time)),
                              //DateFormat('hh:mm:ss').format(DateTime.parse(widget.time)),
                              style: MyTheme.bodyTextTime,
                            ),
                          ],
                        ),
                ],
              ),
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
            widget.callback(replyMessageDetails.reply_to_id!);
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
    await player!.startPlayer(
        fromURI: widget.file_path,
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
      print('pos_ {$pos}');
      print('duration {$duration}');
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
