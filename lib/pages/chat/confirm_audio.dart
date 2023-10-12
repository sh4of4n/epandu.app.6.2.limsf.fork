import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/util/flutter_sound_helper.dart';

typedef Fn = void Function();

class ConfirmAudioWidget extends StatefulWidget {
  final String filePath;
  final VoidCallback onCancelAudio;
  const ConfirmAudioWidget(
      {Key? key, required this.filePath, required this.onCancelAudio})
      : super(key: key);

  @override
  State<ConfirmAudioWidget> createState() => _ConfirmAudioWidgetState();
}

class _ConfirmAudioWidgetState extends State<ConfirmAudioWidget> {
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
      setState(() {
        _mPlayerIsInited = true;
      });
    });
  }

  Future<void> init() async {
    /*Duration d  = await flutterSoundHelper.duration(widget.file_path) ?? Duration.zero;
    duration=d;*/
    print('${widget.filePath}_$duration');
    await _mPlayer.openPlayer();
    await _mPlayer.setSubscriptionDuration(const Duration(milliseconds: 10));
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
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          children: [
            Container(
              color: Colors.green,
              width: 4,
            ),
            const SizedBox(width: 8),
            Expanded(child: buildConfirmAudio()),
          ],
        ),
      );
  Widget buildConfirmAudio() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: widget.onCancelAudio,
              child: const Icon(Icons.close, size: 16),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          getChild(widget.filePath),
        ],
      );

  Widget getChild(String filePath) {
    if (filePath != "") {
      return Container(
        height: 50,
        alignment: Alignment.centerLeft,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(8),
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
                  _mPlayer.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 40,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    isPlaying
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(pos.toString().split('.')[0],
                                  style:
                                      const TextStyle(color: Colors.black45)),
                              const SizedBox(
                                width: 50,
                              ),
                              Text((pos - duration).toString().split('.')[0],
                                  style:
                                      const TextStyle(color: Colors.black45)),
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
      );
    } else {
      return const Text('No Audio recorded.');
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
        fromURI: widget.filePath,
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
      /* print('pos '+pos.toString());
      print('duration '+d.toString() +'-'+duration.toString());*/
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
