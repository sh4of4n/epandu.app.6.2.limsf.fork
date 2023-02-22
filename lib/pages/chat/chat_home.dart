import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:epandu/pages/chat/rooms_provider.dart';
import 'package:epandu/pages/chat/socketclient_helper.dart';
import 'package:epandu/pages/chat/userleftjoined_card.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../common_library/services/model/chatsendack_model.dart';
import '../../common_library/services/model/inviteroom_response.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/services/model/readmessagebyId_model.dart';
import '../../common_library/services/model/replymessage_model.dart';
import '../../common_library/services/repository/auth_repository.dart';
import '../../common_library/utils/capitalize_firstletter.dart';
import '../../common_library/utils/custom_dialog.dart';
import '../../common_library/utils/custom_snackbar.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/DatabaseHelper.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../services/repository/chatroom_repository.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import 'audio_card.dart';
import 'camer_view.dart';
import 'camera_screen.dart';
import 'chat_files.dart';
import 'chat_history.dart';
import 'chatnotification_count.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'confirm_audio.dart';
import 'create_group.dart';
import 'file_card.dart';
import 'image_card.dart';
import 'message_card.dart';
import 'reply_message_widget.dart';
import 'room_members.dart';
import 'video_card.dart';

const theSource = AudioSource.microphone;
typedef void MyCallback(int messageId);
typedef void ResendCallback(int messageId);

class ChatHome2 extends StatefulWidget {
  const ChatHome2({
    Key? key,
    required this.Room_id,
    required this.picturePath,
    required this.roomName,
    required this.roomDesc,
    // required this.roomMembers
  }) : super(key: key);
  final String Room_id; //lowerCamelCase
  final String picturePath;
  final String roomName;
  final String roomDesc;
  // final String roomMembers;
  @override
  _ChatHome2State createState() => _ChatHome2State();
}

class _ChatHome2State extends State<ChatHome2> {
  int currentIndex = -1;
  List filteredMessages = [];
  bool isSearching = false;
  String valueText = "";
  final chatRoomRepo = ChatRoomRepo();
  List<String> deleteList = [
    'DELETE FOR ME',
    'DELETE FOR EVERYONE',
    'CANCEL',
  ];
  List<MessageDetails> myFailedList = [];
  bool _showDownArrow = false;
  TextEditingController _textFieldController = TextEditingController();
  bool _isdesiredItemViewed = false;
  int _desiredItemIndex = -1;
  Timer? timer;
  String socketStatus = '';
  List parts = [];
  bool isAudioRecording = false;
  bool isReplying = false;
  late final ValueChanged<ReplyMessageDetails> onSwipedMessage;
  ReplyMessageDetails replyMessageDetails = ReplyMessageDetails(
      msg_body: '',
      reply_to_id: 0,
      nick_name: '',
      filePath: '',
      binaryType: '');
  TextEditingController searcheditingController = TextEditingController();
  List<MessageDetails> _selectedItems = [];
  bool isMultiSelectionEnabled = false;
  final appConfig = AppConfig();
  bool updateStatus = false;
  int updateMessageId = 0;
  double custFontSize = 15;
  StreamSubscription? _recorderSubscription;
  bool isLoading = false;
  final images = ImagesConstant();
  bool isFileSizeValid = false;
  bool emojiShowing = true;
  String compressedFile = '';
  Codec _codec = Codec.aacMP4;
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mRecorderIsInited = false;
  late List<CameraDescription> cameras = [];
  late String pathToAudio = 'SentAudio';
  String filename = '';
  String audioFilPath = "";
  var dirPath = '';
  int popTime = 0;
  XFile? file;
  ImagePicker picker = ImagePicker();
  final dbHelper = DatabaseHelper.instance;
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  //ScrollController _scrollController = ScrollController();
  List<MessageDetails> getMessageDetailsList = [];
  bool _isWriting = false;
  late IO.Socket socket;
  List<RoomMembers> roomMembers = [];
  String members = '';
  String duplicateMembers = "";
  int membersCount = 0;
  String roomName = '';
  String localUserid = '';
  String localUserName = '';
  String localCaUid = '';
  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);
  TextEditingController editingController = TextEditingController();
  final authRepo = AuthRepo();
  final LocalStorage localStorage = LocalStorage();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  @override
  void initState() {
    super.initState();
    // this.members = widget.roomMembers;
    itemPositionsListener.itemPositions.addListener(() {
      if (itemPositionsListener.itemPositions.value.length > 0 &&
          itemPositionsListener.itemPositions.value.last.index >= 8) {
        setState(() {
          _showDownArrow = true;
        });
      } else {
        setState(() {
          _showDownArrow = false;
        });
      }
    });
    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _getLoginUserId();
      _getAppBarMembers();
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      Provider.of<ChatNotificationCount>(context, listen: false)
          .updateNotificationBadge(roomId: widget.Room_id, type: "DELETE");

      context.read<SocketClientHelper>().setIsEnterRoom(true);

      // context
      //     .read<SocketClientHelper>()
      //     .setRoomDetails(widget.Room_id, widget.roomName, widget.userName);
    });
    _getCameras();

    // WidgetsBinding.instance?.addPostFrameCallback((_) async {
    //   socket=(await Provider.of<SocketClientHelper>(context, listen: false).socket)!;
    // });
    // socket=( Provider.of<SocketClientHelper>(context, listen: false).socket);
    //dbHelper.deleteMsgDetail();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    socket = context.watch<SocketClientHelper>().socket;
    //bool checkSocket = context.watch<SocketClientHelper>().isSocketConnected;
    if (socket.connected) {
      onTyping();
      //sendFailedMessages('GREATER1MIN');
      if (localUserid != '') {
        List<MessageDetails> mylist = context
            .watch<ChatHistory>()
            .getMessageDetailsList
            .where((element) =>
                element.room_id == widget.Room_id &&
                element.msgStatus == "UNREAD" &&
                element.message_id != 0)
            .toList();

        mylist.forEach((messageDetails) {
          updateMessageReadBy(
              messageDetails.message_id.toString(), this.localUserid);
        });

        // timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
        getReadByChatHistory();
        // });
      }
    }
  }

  void getReadByChatHistory() {
    List<MessageDetails> getUnreadMessageDetailsList = getMessageDetailsList
        .where((element) =>
            element.user_id == localUserid &&
            element.room_id == widget.Room_id &&
            element.msgStatus == 'SENT')
        .toList();
    if (getUnreadMessageDetailsList.length > 0) {
      getUnreadMessageDetailsList.forEach((MessageDetails messageDetails) {
        if (messageDetails.message_id.toString() != '') {
          getMessageReadBy(messageDetails.message_id!);
        }
      });
    }
  }

  void _getCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }

  @override
  void dispose() {
    editingController.dispose();
    // _scrollController.dispose();
    _mRecorder!.closeRecorder();
    cancelRecorderSubscriptions();
    _mRecorder = null;
    Hive.box('ws_url').put('isInChatRoom', null);
    getMessageDetailsList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: getAppBar(context),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  getListview(),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Visibility(
                      visible: _showDownArrow,
                      child: FloatingActionButton(
                        child: Icon(Icons.arrow_downward_sharp),
                        onPressed: () {
                          itemScrollController.scrollTo(
                              index: 0,
                              duration: Duration(seconds: 2),
                              curve: Curves.easeInOutCubic);
                          // setState(() {
                          //   _showDownArrow = false;
                          // });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                if (replyMessageDetails.reply_to_id! > 0)
                                  buildReply(replyMessageDetails),
                                if (isAudioRecording) buildConfirmAudio(),
                                Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Card(
                                    margin: EdgeInsets.only(
                                        left: 2, right: 2, bottom: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: TextFormField(
                                        controller: editingController,
                                        focusNode: focusNode,
                                        style:
                                            TextStyle(fontSize: custFontSize),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.multiline,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        autocorrect: true,
                                        maxLines: 5,
                                        minLines: 1,
                                        onChanged: (value) {
                                          if (value.length > 0) {
                                            if (!_isWriting) {
                                              _isWriting = true;
                                              sendTyping(value);
                                              Future.delayed(
                                                      Duration(seconds: 2))
                                                  .whenComplete(() {
                                                _isWriting = false;
                                                sendNotTyping();
                                              });
                                            }
                                            if (mounted) {
                                              setState(() {
                                                sendButton = true;
                                              });
                                            }
                                          } else {
                                            if (mounted) {
                                              setState(() {
                                                sendButton = false;
                                              });
                                            }
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.only(
                                              topLeft: isReplying
                                                  ? Radius.zero
                                                  : Radius.circular(24),
                                              topRight: isReplying
                                                  ? Radius.zero
                                                  : Radius.circular(24),
                                              bottomLeft: Radius.circular(24),
                                              bottomRight: Radius.circular(24),
                                            ),
                                          ),
                                          hintText: "Type a message",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          prefixIcon: getEmojiIcon(),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.attach_file,
                                                  color: Colors.blue,
                                                ),
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (builder) =>
                                                          bottomSheet());
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.blue,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    popTime = 2;
                                                  });

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (builder) =>
                                                              CameraScreen(
                                                                  cameras:
                                                                      cameras,
                                                                  onImageSend:
                                                                      onImageSend)));
                                                },
                                              ),
                                            ],
                                          ),
                                          contentPadding: EdgeInsets.all(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                  icon: Icon(
                                    sendButton ? Icons.send : Icons.mic,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (sendButton) {
                                      if (!isAudioRecording) {
                                        //sendFailedMessages('');
                                        sendMessage(editingController.text, '',
                                            replyMessageDetails, '');
                                      } else {
                                        //sendFailedMessages('');
                                        onVoiceSend(
                                            audioFilPath,
                                            audioFilPath.split('/').last,
                                            editingController.text);

                                        setState(() {
                                          isAudioRecording = false;
                                        });
                                      }
                                      editingController.clear();

                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                              onLongPressStart: (_) async {
                                if (!sendButton) {
                                  if (!_mRecorderIsInited) {
                                    return null;
                                  }
                                  if (_mRecorder!.isStopped) {
                                    record();
                                  }
                                }
                              },
                              onLongPressCancel: () {},
                              onLongPressEnd: (_) async {
                                if (!sendButton) {
                                  if (!_mRecorderIsInited) {
                                    return null;
                                  }
                                  stopRecorder();
                                }
                              }),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      // show ? emojiSelect() : Container()
                    ],
                  )),
                  Offstage(
                    offstage: !show,
                    child: SizedBox(height: 300, child: emojiSelect()),
                  ),
                ],
              ),
              onWillPop: () {
                if (show) {
                  if (mounted) {
                    setState(() {
                      show = false;
                    });
                  }
                } else {
                  Provider.of<ChatNotificationCount>(context, listen: false)
                      .updateNotificationBadge(
                          roomId: widget.Room_id, type: "DELETE");
                  Provider.of<ChatNotificationCount>(context, listen: false)
                      .updateUnreadMessageId(roomId: widget.Room_id);

                  // context.read<SocketClientHelper>().setRoomDetails('', '', '');
                  context.read<SocketClientHelper>().setIsEnterRoom(false);
                  Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => RoomList())).then((_) {
                  //   setState(() {});
                  // });
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget getEmojiIcon() {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      );
    } else {
      return IconButton(
        icon: Icon(
          show ? Icons.keyboard : Icons.emoji_emotions_outlined,
          color: Colors.blue,
        ),
        onPressed: () {
          if (!show) {
            focusNode.unfocus();
            focusNode.canRequestFocus = false;
          }
          setState(() {
            show = !show;
          });
        },
      );
    }
  }

  Widget getListview() {
    return Expanded(
        child: Consumer<ChatHistory>(
      builder: (ctx, msgList, child) => ScrollablePositionedList.builder(
        itemCount: msgList.getMessageDetailsList
            .where((element) => element.room_id == widget.Room_id)
            .toList()
            .length,
        shrinkWrap: true,
        reverse: true,
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          if (index >= 0) {
            ReplyMessageDetails existingReplayMessageDetails =
                ReplyMessageDetails(
                    reply_to_id: 0,
                    msg_body: '',
                    nick_name: '',
                    filePath: '',
                    binaryType: '');

            getMessageDetailsList = msgList.getMessageDetailsList
                .where((element) => element.room_id == widget.Room_id)
                .toList()
                .reversed
                .toList();

            int replyId = getMessageDetailsList[index].reply_to_id!;
            if (getMessageDetailsList[index].reply_to_id! > 0) {
              int index = getMessageDetailsList
                  .indexWhere((element) => element.message_id == replyId);
              if (index > 0) {
                MessageDetails msgDetails = getMessageDetailsList[index];
                existingReplayMessageDetails.reply_to_id =
                    msgDetails.message_id;
                existingReplayMessageDetails.nick_name = msgDetails.nick_name;
                existingReplayMessageDetails.filePath = msgDetails.filePath;
                existingReplayMessageDetails.msg_body = msgDetails.msg_body;
              }
            }

            // if (getMessageDetailsList[index].room_id == widget.Room_id) {
            return Container(
              color: _desiredItemIndex == index ? Colors.grey[200] : null,
              child: InkWell(
                  onLongPress: () {
                    if (!isSearching &&
                        getMessageDetailsList[index].msg_binaryType !=
                            'userLeft' &&
                        getMessageDetailsList[index].msg_binaryType !=
                            'userJoined') {
                      isMultiSelectionEnabled = true;
                      doMultiSelectionItem(getMessageDetailsList[index]);
                    }
                  },
                  onTap: () {
                    doMultiSelectionItem(getMessageDetailsList[index]);
                    if (_selectedItems.length == 0) {
                      setState(() {
                        isMultiSelectionEnabled = false;
                      });
                    }
                  },
                  child: Stack(
                    alignment:
                        getMessageDetailsList[index].user_id == localUserid
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    children: [
                      Column(
                        children: [
                          if (getMessageDetailsList[index].msg_binaryType ==
                              "image") ...[
                            SwipeTo(
                                onLeftSwipe: () {
                                  replyToMessage(
                                      getMessageDetailsList[index].nick_name!,
                                      getMessageDetailsList[index].filePath!,
                                      getMessageDetailsList[index].message_id!,
                                      getMessageDetailsList[index].msg_body!,
                                      getMessageDetailsList[index]
                                          .msg_binaryType!);
                                },
                                onRightSwipe: () {
                                  replyToMessage(
                                      getMessageDetailsList[index].nick_name!,
                                      getMessageDetailsList[index].filePath!,
                                      getMessageDetailsList[index].message_id!,
                                      getMessageDetailsList[index].msg_body!,
                                      getMessageDetailsList[index]
                                          .msg_binaryType!);
                                },
                                child: ImageCard(
                                  time: getMessageDetailsList[index]
                                          .send_datetime ??
                                      '',
                                  nick_name:
                                      getMessageDetailsList[index].nick_name ??
                                          '',
                                  text: getMessageDetailsList[index].msg_body ??
                                      '',
                                  file_path:
                                      getMessageDetailsList[index].filePath ??
                                          '',
                                  user: getMessageDetailsList[index].user_id ??
                                      '',
                                  localUser: localUserid,
                                  msgStatus:
                                      getMessageDetailsList[index].msgStatus ??
                                          '',
                                  messageId:
                                      getMessageDetailsList[index].message_id ??
                                          0,
                                  replyMessageDetails:
                                      existingReplayMessageDetails,
                                  onCancelReply: cancelReply,
                                  callback: tapListitem,
                                  roomDesc: widget.roomDesc,
                                ))
                          ] else if (getMessageDetailsList[index]
                                  .msg_binaryType ==
                              "video") ...[
                            SwipeTo(
                                onLeftSwipe: () {
                                  replyToMessage(
                                      getMessageDetailsList[index].nick_name!,
                                      getMessageDetailsList[index].filePath!,
                                      getMessageDetailsList[index].message_id!,
                                      getMessageDetailsList[index].msg_body!,
                                      getMessageDetailsList[index]
                                          .msg_binaryType!);
                                },
                                onRightSwipe: () {
                                  replyToMessage(
                                      getMessageDetailsList[index].nick_name!,
                                      getMessageDetailsList[index].filePath!,
                                      getMessageDetailsList[index].message_id!,
                                      getMessageDetailsList[index].msg_body!,
                                      getMessageDetailsList[index]
                                          .msg_binaryType!);
                                },
                                child: VideoCard(
                                  file_path:
                                      getMessageDetailsList[index].filePath ??
                                          '',
                                  time: getMessageDetailsList[index]
                                          .send_datetime ??
                                      '',
                                  text: getMessageDetailsList[index].msg_body ??
                                      '',
                                  nick_name:
                                      getMessageDetailsList[index].nick_name ??
                                          '',
                                  user: getMessageDetailsList[index].user_id ??
                                      '',
                                  localUser: localUserid,
                                  msgStatus:
                                      getMessageDetailsList[index].msgStatus ??
                                          '',
                                  messageId:
                                      getMessageDetailsList[index].message_id ??
                                          0,
                                  replyMessageDetails:
                                      existingReplayMessageDetails,
                                  onCancelReply: cancelReply,
                                  callback: tapListitem,
                                  roomDesc: widget.roomDesc,
                                ))
                          ] else if (getMessageDetailsList[index]
                                  .msg_binaryType ==
                              "audio") ...[
                            SwipeTo(
                                onLeftSwipe: () {
                                  replyToMessage(
                                      getMessageDetailsList[index].nick_name!,
                                      getMessageDetailsList[index].filePath!,
                                      getMessageDetailsList[index].message_id!,
                                      getMessageDetailsList[index].msg_body!,
                                      getMessageDetailsList[index]
                                          .msg_binaryType!);
                                },
                                onRightSwipe: () {
                                  replyToMessage(
                                      getMessageDetailsList[index].nick_name!,
                                      getMessageDetailsList[index].filePath!,
                                      getMessageDetailsList[index].message_id!,
                                      getMessageDetailsList[index].msg_body!,
                                      getMessageDetailsList[index]
                                          .msg_binaryType!);
                                },
                                child: AudioCard(
                                  nick_name:
                                      getMessageDetailsList[index].nick_name ??
                                          '',
                                  text: getMessageDetailsList[index].msg_body ??
                                      '',
                                  time: getMessageDetailsList[index]
                                          .send_datetime ??
                                      '',
                                  file_path:
                                      getMessageDetailsList[index].filePath ??
                                          '',
                                  user: getMessageDetailsList[index].user_id ??
                                      '',
                                  localUser: localUserid,
                                  msgStatus:
                                      getMessageDetailsList[index].msgStatus ??
                                          '',
                                  messageId:
                                      getMessageDetailsList[index].message_id ??
                                          0,
                                  replyMessageDetails:
                                      existingReplayMessageDetails,
                                  onCancelReply: cancelReply,
                                  callback: tapListitem,
                                  roomDesc: widget.roomDesc,
                                ))
                          ] else if (getMessageDetailsList[index]
                                  .msg_binaryType ==
                              "file") ...[
                            SwipeTo(
                                onLeftSwipe: () {
                                  replyToMessage(
                                      getMessageDetailsList[index].nick_name!,
                                      getMessageDetailsList[index].filePath!,
                                      getMessageDetailsList[index].message_id!,
                                      getMessageDetailsList[index].msg_body!,
                                      getMessageDetailsList[index]
                                          .msg_binaryType!);
                                },
                                onRightSwipe: () {
                                  replyToMessage(
                                      getMessageDetailsList[index].nick_name!,
                                      getMessageDetailsList[index].filePath!,
                                      getMessageDetailsList[index].message_id!,
                                      getMessageDetailsList[index].msg_body!,
                                      getMessageDetailsList[index]
                                          .msg_binaryType!);
                                },
                                child: FileCard(
                                  nick_name:
                                      getMessageDetailsList[index].nick_name ??
                                          '',
                                  text: getMessageDetailsList[index].msg_body ??
                                      '',
                                  time: getMessageDetailsList[index]
                                          .send_datetime ??
                                      '',
                                  file_path:
                                      getMessageDetailsList[index].filePath ??
                                          '',
                                  user: getMessageDetailsList[index].user_id ??
                                      '',
                                  localUser: localUserid,
                                  msgStatus:
                                      getMessageDetailsList[index].msgStatus ??
                                          '',
                                  messageId:
                                      getMessageDetailsList[index].message_id ??
                                          0,
                                  replyMessageDetails:
                                      existingReplayMessageDetails,
                                  onCancelReply: cancelReply,
                                  callback: tapListitem,
                                  // roomDesc: widget.roomDesc,
                                ))
                          ] else if (getMessageDetailsList[index]
                                      .msg_binaryType ==
                                  "userLeft" ||
                              getMessageDetailsList[index].msg_binaryType ==
                                  "userJoined") ...[
                            UserLeftJoinedCard(
                              messageDetails: getMessageDetailsList[index],
                            )
                          ] else ...[
                            SwipeTo(
                                iconOnLeftSwipe:
                                    getMessageDetailsList[index].user_id ==
                                            localUserid
                                        ? Icons.edit
                                        : Icons.reply_sharp,
                                iconSize: 30,
                                iconColor: Colors.blue,
                                onLeftSwipe: () {
                                  if (getMessageDetailsList[index].user_id ==
                                      localUserid) {
                                    editingController.text =
                                        getMessageDetailsList[index].msg_body!;

                                    setState(() {
                                      updateStatus = true;
                                      updateMessageId =
                                          getMessageDetailsList[index]
                                              .message_id!;
                                    });
                                  } else {
                                    replyToMessage(
                                        getMessageDetailsList[index].nick_name!,
                                        getMessageDetailsList[index].filePath!,
                                        getMessageDetailsList[index]
                                            .message_id!,
                                        getMessageDetailsList[index].msg_body!,
                                        getMessageDetailsList[index]
                                            .msg_binaryType!);
                                  }
                                },
                                onRightSwipe: () {
                                  replyToMessage(
                                      getMessageDetailsList[index].nick_name!,
                                      getMessageDetailsList[index].filePath!,
                                      getMessageDetailsList[index].message_id!,
                                      getMessageDetailsList[index].msg_body!,
                                      getMessageDetailsList[index]
                                          .msg_binaryType!);
                                },
                                child: MessageCard(
                                  messageDetails: getMessageDetailsList[index],
                                  localUser: localUserid,
                                  replyMessageDetails:
                                      existingReplayMessageDetails,
                                  onCancelReply: cancelReply,
                                  callback: tapListitem,
                                  resendCallback: tapResend,
                                  roomDesc: widget.roomDesc,
                                ))
                          ]
                        ],
                      ),
                      Visibility(
                          visible: isMultiSelectionEnabled,
                          child: getMessageDetailsList[index].msg_binaryType !=
                                      'userLeft' &&
                                  getMessageDetailsList[index].msg_binaryType !=
                                      'userJoined'
                              ? Icon(
                                  _selectedItems.contains(
                                          getMessageDetailsList[index])
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  size: 30,
                                  color: Colors.blue,
                                )
                              : Text(''))
                    ],
                  )),
            );
            // } else {
            //   return SizedBox.shrink();
            // }
          }

          return SizedBox.shrink();
        },
      ),
    ));
  }

  Widget buildReply(ReplyMessageDetails replyMessageDetails) => Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(24),
          ),
        ),
        child: ReplyMessageWidget(
          messageDetails: replyMessageDetails,
          onCancelReply: cancelReply,
          type: "SEND",
        ),
      );

  String getSelectedItemCount() {
    return _selectedItems.isNotEmpty
        ? _selectedItems.length.toString() + " item selected"
        : "No item selected";
  }

  doMultiSelectionItem(MessageDetails messageDetails) {
    if (isMultiSelectionEnabled) {
      if (_selectedItems.contains(messageDetails)) {
        _selectedItems.remove(messageDetails);
      } else {
        _selectedItems.add(messageDetails);
      }
      setState(() {});
    }
  }

  Widget getSlideAction(Color backgroundColor, Color foregroundColor,
      IconData icon, String label, MessageDetails messageDetails) {
    return SlidableAction(
      flex: 1,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      onPressed: (_) {
        if (label.toUpperCase() == "DELETE") {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(
                      "Are you sure you want to delete ${messageDetails.msg_body}?"),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        setState(() {
                          //itemsList.removeAt(index);
                          deleteChatMessage(messageDetails.message_id!, '');
                        });

                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        } else {
          editingController.text = messageDetails.msg_body!;

          setState(() {
            updateStatus = true;
            updateMessageId = messageDetails.message_id!;
          });
        }
      },
      icon: icon,
      label: label,
    );
  }

  deleteConfirmation(List<MessageDetails> selectedItems, String type) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          if (type == 'OWN') {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                title: Text(
                  'Delete ${selectedItems.length} Message?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: SingleChildScrollView(
                  child: Container(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Divider(),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.4,
                          ),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: deleteList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(deleteList[index]),
                                  onTap: () {
                                    if (index == 0) {
                                      _selectedItems.forEach(
                                          (MessageDetails messageDetails) {
                                        deleteChatMessage(
                                            messageDetails.message_id!,
                                            'FORME');
                                      });
                                      Navigator.of(context).pop();
                                    } else if (index == 1) {
                                      _selectedItems.forEach(
                                          (MessageDetails messageDetails) {
                                        deleteChatMessage(
                                            messageDetails.message_id!,
                                            'EVERYONE');
                                      });
                                      Navigator.of(context).pop();
                                    } else {
                                      Navigator.of(context).pop();
                                    }
                                    setState(() {
                                      isMultiSelectionEnabled = false;
                                      _selectedItems.clear();
                                    });
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: Text(
                selectedItems.length == 1
                    ? 'Delete Message From ${selectedItems[0].nick_name}?'
                    : 'Delete ${selectedItems.length} Messages?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      isMultiSelectionEnabled = false;
                      _selectedItems.clear();
                    });
                  },
                ),
                TextButton(
                  child: Text(
                    "DELETE FOR ME",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    _selectedItems.forEach((MessageDetails messageDetails) {
                      deleteChatMessage(messageDetails.message_id!, 'FORME');
                    });
                    Navigator.of(context).pop();
                    setState(() {
                      isMultiSelectionEnabled = false;
                      _selectedItems.clear();
                    });
                  },
                )
              ],
            );
          }
        });
  }

  void replyToMessage(String name, String path, int messageId, String message,
      String binaryType) {
    focusNode.requestFocus();
    replyMessageDetails = ReplyMessageDetails(
        msg_body: message,
        reply_to_id: messageId,
        nick_name: name,
        filePath: path,
        binaryType: binaryType);

    setState(() {
      replyMessageDetails = replyMessageDetails;
    });
  }

  void cancelReply() {
    replyMessageDetails = ReplyMessageDetails(
        msg_body: '',
        reply_to_id: 0,
        nick_name: '',
        filePath: '',
        binaryType: '');

    setState(() {
      replyMessageDetails = replyMessageDetails;
    });
  }

  void tapListitem(int messageId) {
    int index = getMessageDetailsList
        .indexWhere((element) => element.message_id == messageId);
    itemScrollController.scrollTo(
        index: index,
        duration: Duration(seconds: 2),
        curve: Curves.easeInOutCubic);

    Timer(Duration(seconds: 5), () {
      _desiredItemIndex = -1;
      //print('Timer');
    });
    setState(() {
      _desiredItemIndex = index;
    });
  }

  void tapResend(int messageId) {
    List<MessageDetails> list = getMessageDetailsList
        .where((element) => element.message_id == messageId)
        .toList();
    Future.delayed(Duration(milliseconds: 500), () {
      itemScrollController.scrollTo(
          index: 0,
          duration: Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    });
    setState(() {
      editingController.text = list[0].msg_body!;
    });
  }

  Widget buildConfirmAudio() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(24),
        ),
      ),
      child: ConfirmAudioWidget(
          filePath: audioFilPath, onCancelAudio: cancelAudio),
    );
  }

  void cancelAudio() {
    setState(() {
      isAudioRecording = false;
      sendButton = false;
    });
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  _getAppBarMembers() async {
    roomMembers = await dbHelper.getRoomMembersList(widget.Room_id);
    for (var roomMembers in roomMembers) {
      if (roomMembers.user_id != localUserid)
        members += CapitalizeFirstLetter()
                .capitalizeFirstLetter(roomMembers.nick_name!) +
            ",";
    }
    setState(() {
      if (members.length > 0)
        members = members.substring(0, members.length - 1);

      membersCount = roomMembers.length;
      if (roomMembers.length > 0) roomName = roomMembers[0].room_name!;
    });
  }

  getAppBar(BuildContext context) {
    if (isSearching) {
      return AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 24,
          ),
          onPressed: () {
            setState(() {
              this.isSearching = false;
              filteredMessages = [];
              currentIndex = -1;
              _desiredItemIndex = -1;
            });
          },
        ),
        backgroundColor: Colors.blueAccent,
        title: TextField(
          controller: searcheditingController,
          onChanged: (value) {
            if (value != '') {
              List<MessageDetails> list1 = getMessageDetailsList
                  .where((element) =>
                      element.room_id == widget.Room_id &&
                      element.msg_body!
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                  .toList();
              setState(() {
                filteredMessages = [];
                list1.forEach((message) {
                  filteredMessages.add(message.message_id);
                });
              });
            }
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: "Search Message",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        actions: <Widget>[
          // isSearching
          //     ?
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                // this.isSearching = false;
                // filteredMessages = [];
                // currentIndex = -1;
                // _desiredItemIndex = -1;
                filteredMessages = [];
                currentIndex = -1;
                _desiredItemIndex = -1;
                searcheditingController.clear();
              });
            },
          ),
          //:
          IconButton(
            icon: Icon(Icons.arrow_circle_up),
            onPressed: () {
              if (filteredMessages.length > 0) {
                if (currentIndex == -1) {
                  int index = getMessageDetailsList.indexWhere(
                      (element) => element.message_id == filteredMessages[0]);

                  setState(() {
                    _desiredItemIndex = index;
                    currentIndex = 1;
                  });
                  itemScrollController.scrollTo(
                      index: index,
                      duration: Duration(seconds: 2),
                      curve: Curves.easeInOutCubic);
                } else {
                  if (currentIndex != -1 &&
                      currentIndex < filteredMessages.length) {
                    int messageId = filteredMessages[currentIndex];
                    int index = getMessageDetailsList.indexWhere(
                        (element) => element.message_id == messageId);

                    setState(() {
                      _desiredItemIndex = index;
                      currentIndex = currentIndex + 1;
                    });
                    itemScrollController.scrollTo(
                        index: index,
                        duration: Duration(seconds: 2),
                        curve: Curves.easeInOutCubic);
                  } else if (currentIndex == filteredMessages.length) {
                    setState(() {
                      currentIndex = 0;
                    });
                    final customSnackbar = CustomSnackbar();
                    customSnackbar.show(
                      context,
                      message: 'No messages found.',
                      duration: 5000,
                      type: MessageType.INFO,
                    );
                  }
                }
              } else {
                final customSnackbar = CustomSnackbar();
                customSnackbar.show(
                  context,
                  message: 'No messages found.',
                  duration: 5000,
                  type: MessageType.INFO,
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_circle_down),
            onPressed: () {
              if (currentIndex < filteredMessages.length &&
                  currentIndex != -1) {
                int messageId = filteredMessages[currentIndex];
                int index = getMessageDetailsList
                    .indexWhere((element) => element.message_id == messageId);
                itemScrollController.scrollTo(
                    index: index,
                    duration: Duration(seconds: 2),
                    curve: Curves.easeInOutCubic);

                Timer(Duration(seconds: 5), () {
                  _desiredItemIndex = -1;
                });
                setState(() {
                  _desiredItemIndex = index;
                  currentIndex = currentIndex - 1;
                });
              } else {
                final customSnackbar = CustomSnackbar();
                customSnackbar.show(
                  context,
                  message: 'No messages found.',
                  duration: 5000,
                  type: MessageType.INFO,
                );
              }
            },
          )
        ],
      );
    } else {
      if (!isMultiSelectionEnabled) {
        return AppBar(
          // leadingWidth: 80,
          titleSpacing: 0,
          backgroundColor: Colors.blueAccent,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
                onPressed: () {
                  Provider.of<ChatNotificationCount>(context, listen: false)
                      .updateNotificationBadge(
                          roomId: widget.Room_id, type: "DELETE");
                  Provider.of<ChatNotificationCount>(context, listen: false)
                      .updateUnreadMessageId(roomId: widget.Room_id);
                  Navigator.pop(context);
                  context.read<SocketClientHelper>().setIsEnterRoom(false);
                },
              ),
            ],
          ),
          title: Row(
            children: [
              // Container(
              //   width: 40,
              //   height: 40,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     border: Border.all(
              //       color: Colors.white,
              //       width: 3,
              //     ),
              //     boxShadow: [
              //       BoxShadow(
              //           color: Colors.grey.withOpacity(.3),
              //           offset: Offset(0, 2),
              //           blurRadius: 5)
              //     ],
              //   ),
              //   child: FullScreenWidget(
              //     child: Center(
              //       child: ClipRRect(
              //         borderRadius: BorderRadius.circular(8.0),
              //         child: widget.picturePath != ''
              //             ? Image.network(widget.picturePath
              //                 .replaceAll(removeBracket, '')
              //                 .split('\r\n')[0])
              //             : Icon(Icons.account_circle),
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: Container(
                  // padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RoomMembersList(
                                  Room_name: roomName,
                                  Room_id: widget.Room_id,
                                  userId: this.localUserid,
                                  picturePath: widget.picturePath,
                                  roomName: widget.roomName,
                                  roomDesc: widget.roomDesc,
                                  // roomMembers: widget.roomMembers
                                )),
                      );
                    },
                    child: Container(
                      // margin: EdgeInsets.all(6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.roomName,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            this.members,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              padding: EdgeInsets.all(0),
              onSelected: (value) {
                if (value == "View Contacts") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomMembersList(
                        Room_name: roomName,
                        Room_id: widget.Room_id,
                        userId: this.localUserid,
                        picturePath: widget.picturePath,
                        roomName: widget.roomName,
                        roomDesc: widget.roomDesc,
                      ),
                    ),
                  );
                } else if (value == "Search") {
                  setState(() {
                    this.isSearching = true;
                  });
                } else if (value == "Media and Files") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatFiles(
                        roomId: widget.Room_id,
                      ),
                    ),
                  );
                } else if (value == "Add New Member") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateGroup(
                        roomId: widget.Room_id,
                      ),
                    ),
                  );
                } else if (value == "Change Group Name") {
                  _displayTextInputDialog(context);
                } else if (value == "Leave Group") {
                  leaveGroup(widget.Room_id);
                }
                // else if (value == "Delete Chat") {
                //   print('Delete Chat');
                // }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("View Contacts"),
                    value: "View Contacts",
                  ),
                  PopupMenuItem(
                    child: Text("Search"),
                    value: "Search",
                  ),
                  PopupMenuItem(
                    child: Text("Media and Files"),
                    value: "Media and Files",
                  ),
                  if (widget.roomDesc.toUpperCase().contains("GROUP"))
                    PopupMenuItem(
                      child: Text("Add New Member"),
                      value: "Add New Member",
                    ),
                  if (widget.roomDesc.toUpperCase().contains("GROUP"))
                    PopupMenuItem(
                      child: Text("Change Group Name"),
                      value: "Change Group Name",
                    ),
                  if (widget.roomDesc.toUpperCase().contains("GROUP"))
                    PopupMenuItem(
                      child: Text("Leave Group"),
                      value: "Leave Group",
                    ),
                ];
              },
            ),
          ],
        );
      } else {
        return AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24,
            ),
            onPressed: () {
              setState(() {
                isMultiSelectionEnabled = false;
                _selectedItems.clear();
              });
            },
          ),
          backgroundColor: Colors.blueAccent,
          title: Text(
            getSelectedItemCount(),
            style: TextStyle(
              fontSize: 18.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                var contain = _selectedItems
                    .where((element) => element.user_id != localUserid);
                if (contain.length > 0) {
                  deleteConfirmation(_selectedItems, '');
                } else {
                  deleteConfirmation(_selectedItems, 'OWN');
                }
              },
            )
          ],
        );
      }
    }
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Group Name'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Group Name"),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red),
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green),
                child: Text('OK'),
                onPressed: () async {
                  await EasyLoading.show();
                  var inviteResult = await chatRoomRepo.changeGroupName(
                      widget.Room_id, valueText);

                  if (inviteResult.data != null &&
                      inviteResult.data.length > 0) {
                    InviteRoomResponse inviteRoomResponse =
                        inviteResult.data[0];
                    context.read<RoomHistory>().updateRoom(
                        roomId: inviteRoomResponse.roomId!,
                        roomName: inviteRoomResponse.roomName!);
                    await dbHelper.updateRoomName(inviteRoomResponse.roomName!,
                        inviteRoomResponse.roomId!);
                    await EasyLoading.dismiss();
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  } else {
                    await EasyLoading.dismiss();
                    final customDialog = CustomDialog();
                    return customDialog.show(
                      context: context,
                      type: DialogType.ERROR,
                      content: inviteResult.message!,
                      onPressed: () => Navigator.pop(context),
                    );
                  }
                },
              ),
            ],
          );
        });
  }

  Text getMembersText() {
    if (membersCount > 1) {
      return Text(
        this.members,
        style: Theme.of(context).textTheme.caption,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      return Text('');
    }
  }

  void leaveGroup(String roomId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Are you sure you want to  leave the group?"),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  "Leave",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  var leaveRoomResponseResult =
                      await chatRoomRepo.leaveRoom(roomId);
                  if (leaveRoomResponseResult.data != null &&
                      leaveRoomResponseResult.data.length > 0) {
                    // LeaveRoomResponse leaveRoomResponse =
                    //     leaveRoomResponseResult.data[0];

                    List<RoomMembers> roomMembers =
                        await dbHelper.getRoomMembersList(widget.Room_id);
                    roomMembers.forEach((roomMember) {
                      if (localUserid != roomMember.user_id) {
                        var leaveGroupJson = {
                          "notifiedRoomId": widget.Room_id,
                          "notifiedUserId": roomMember.user_id,
                          "title": localUserName + " just left the room",
                          "description":
                              localUserid + " just left the room_" + roomId
                        };
                        //print(messageJson);
                        socket.emitWithAck('sendNotification', leaveGroupJson,
                            ack: (data) async {});
                      }
                    });
                    String clientMessageId = generateRandomString(15);

                    var messageJson = {
                      "roomId": widget.Room_id,
                      "msgBody": localUserName + ' left',
                      "msgBinaryType": 'userLeft',
                      "replyToId": -1,
                      "clientMessageId": clientMessageId,
                      "misc": "[FCM_Notification=title:" +
                          roomName +
                          ' - ' +
                          localUserName +
                          "]"
                    };

                    socket.emitWithAck('sendMessage', messageJson,
                        ack: (data) async {
                      if (data != null) {
                        print('sendMessage from server $data');
                      } else {
                        print("Null from sendMessage");
                      }
                    });

                    // Provider.of<RoomHistory>(context, listen: false)
                    //     .deleteRoom(roomId: widget.Room_id);
                    Provider.of<ChatNotificationCount>(context, listen: false)
                        .removeNotificationRoom(roomId: roomId);
                    await dbHelper.deleteRoomById(widget.Room_id);
                    await dbHelper.deleteRoomMembersByRoomId(widget.Room_id);
                    await dbHelper.deleteMessagesByRoomId(widget.Room_id);
                    final dir = Directory((Platform.isAndroid
                                ? await getExternalStorageDirectory() //FOR ANDROID
                                : await getApplicationSupportDirectory() //FOR IOS
                            )!
                            .path +
                        '/' +
                        roomId);
                    if ((await dir.exists())) {
                      await dir.delete();
                    }
                    Provider.of<RoomHistory>(context, listen: false)
                        .getRoomHistory();
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void deleteChatMessage(int messageId, String type) {
    var messageJson = {
      "messageId": messageId,
    };

    if (type == 'FORME') {
      context.read<ChatHistory>().deleteChatItem(
            messageId,
          );
      dbHelper.deleteMsg(
          messageId,
          DateFormat("yyyy-MM-dd HH:mm:ss")
              .format(DateTime.now().toLocal())
              .toString());
      List<MessageDetails> list = getMessageDetailsList
          .where((element) =>
              element.message_id == messageId && element.filePath != '')
          .toList();

      if (list.length > 0) {
        deleteFile(File(list[0].filePath!));
      }
    } else {
      //print(messageJson);
      socket.emitWithAck('deleteMessage', messageJson, ack: (data) async {
        //print('deleteMessage ack $data');
        if (data != null) {
          Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
          if (result["messageId"] != '') {
            context.read<ChatHistory>().deleteChatItem(
                  messageId,
                );
            await dbHelper.deleteMsg(messageId, result['deleteDateTime']);

            List<MessageDetails> list = getMessageDetailsList
                .where((element) =>
                    element.message_id == messageId && element.filePath != '')
                .toList();

            if (list.length > 0) {
              deleteFile(File(list[0].filePath!));
            }
          }
          print('deleteMessage from server $data');
        } else {
          print("Null from deleteMessage");
        }
      });
    }
  }

  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }

  void updateChatMessage(int messageId, String text) {
    var messageJson = {"messageId": messageId, "msgBody": text};
    //print(messageJson);
    socket.emitWithAck('updateMessage', messageJson, ack: (data) async {
      //print('updateMessage ack $data');
      if (data != null) {
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result['editDateTime'] != null && result['editDateTime'] != '') {
          context
              .read<ChatHistory>()
              .updateChatItemMessage(text, messageId, result['editDateTime']);
          int val = await dbHelper.updateMsgDetailTableText(
              text, messageId, result['editDateTime']);
        }

        print('updateMessage from server $data');
      } else {
        print("Null from updateMessage");
      }
    });
  }

  void sendMessage(String text, String type,
      ReplyMessageDetails replyMessageDetails, String clientMessageId) {
    if (updateStatus == false && updateMessageId == 0) {
      if (type == '') {
        clientMessageId = generateRandomString(15);
        storeMyMessage(text, '', '', 0, clientMessageId);
      }
      var messageJson = {
        "roomId": widget.Room_id,
        "msgBody": text,
        "replyToId": replyMessageDetails.reply_to_id,
        "clientMessageId": clientMessageId,
        "misc":
            "[FCM_Notification=title:" + roomName + ' - ' + localUserName + "]"
      };
      print('sendMessage: $messageJson');
      if (socket.connected) {
        socket.emitWithAck('sendMessage', messageJson, ack: (data) async {
          if (data != null) {
            SendAcknowledge sendAcknowledge = SendAcknowledge.fromJson(data);
            if (sendAcknowledge.clientMessageId == clientMessageId) {
              context.read<ChatHistory>().updateChatItemStatus(
                  clientMessageId, "SENT", sendAcknowledge.messageId);
              await dbHelper.updateMsgDetailTable(
                  clientMessageId, "SENT", sendAcknowledge.messageId);
              if (myFailedList.length > 0) {
                int index = myFailedList.indexWhere(
                    (element) => element.client_message_id == clientMessageId);
                if (index > -1) {
                  myFailedList.removeAt(index);
                }
              }
            }
            print('sendMessage from server $data');
          } else {
            print("Null from sendMessage");
          }
        });
      }
      Future.delayed(Duration(milliseconds: 500), () {
        itemScrollController.scrollTo(
            index: 0,
            duration: Duration(seconds: 2),
            curve: Curves.easeInOutCubic);
      });
    } else {
      updateChatMessage(updateMessageId, text);
      setState(() {
        updateStatus = false;
        editingController.text = '';
        updateMessageId = 0;
      });
    }
  }

  updateMessageReadBy(String messageId, String userId) {
    var messageJson = {
      "messageId": messageId,
      "userId": userId,
    };
    //print(messageJson);
    socket.emitWithAck('updateMessageReadBy', messageJson, ack: (data) async {
      //print('updateMessageReadBy ack $data');
      if (data != null) {
        print('updateMessageReadBy from server $data');
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result["messageId"] != '') {
          context
              .read<ChatHistory>()
              .updateChatItemStatus('', "READ", int.parse(messageId));
          await dbHelper.updateMsgStatus('READ', int.parse(messageId));
        }
      } else {
        print("Null from updateMessageReadBy");
      }
    });
  }

  getMessageReadBy(int messageId) {
    if (socket.connected) {
      var messageJson = {
        "messageId": messageId,
        "returnMsgBinaryAsBase64": "true"
      };
      //print(messageJson);
      socket.emitWithAck('getMessageById', messageJson, ack: (data) async {
        //print('getMessageById ack $data');
        if (data != null) {
          ReadByMessage readByMessage = ReadByMessage.fromJson(data);
          if (readByMessage.message!.readMessage![0].readBy != null &&
              readByMessage.message!.readMessage![0].readBy!
                  .contains('[[ALL]]')) {
            context.read<ChatHistory>().updateChatItemStatus('', "READ",
                int.parse(readByMessage.message!.readMessage![0].id!));
            await dbHelper.updateMsgStatus(
                'READ', int.parse(readByMessage.message!.readMessage![0].id!));
          }
        } else {
          print("Null from getMessageById");
        }
      });
    }
  }

  String generateRandomString(int length) {
    final _random = Random();
    const _availableChars = '1234567890';
    // 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => _availableChars[_random.nextInt(_availableChars.length)])
        .join();

    return randomString;
  }

  void onImageSend(String path, String message, String fileName) async {
    for (int i = 0; i < popTime; i++) {
      Navigator.pop(context);
    }
    final extension = p.extension(path);
    if (extension.toLowerCase() == ".png" ||
        extension.toLowerCase() == ".jpg") {
      File f = File(path);
      getFileSize(path);
      if (isFileSizeValid) {
        var bytes = await File(path).readAsBytes();
        String base64string = base64.encode(bytes);
        emitSendMessage(
            '', base64string, 'image', message, "", replyMessageDetails, '');
        //_editImage(f, message);
      } else {
        final customDialog = CustomDialog();
        return customDialog.show(
          context: context,
          type: DialogType.ERROR,
          content: "Please try sending file size less than 5MB.",
          onPressed: () => Navigator.pop(context),
        );
      }
    } else {
      getFileSize(path);
      if (isFileSizeValid) {
        var bytes = await File(path).readAsBytes();
        String base64string = base64.encode(bytes);
        emitSendMessage(message, base64string, "video", message, "",
            replyMessageDetails, '');
      } else {
        final customDialog = CustomDialog();
        return customDialog.show(
          context: context,
          type: DialogType.ERROR,
          content: "Please try sending file size less than 5MB.",
          onPressed: () => Navigator.pop(context),
        );
      }
    }
  }

  // Future<void> _editImage(File file, String message) async {
  //   CroppedFile? croppedFile = await ImageCropper().cropImage(
  //     sourcePath: file.path,
  //     aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
  //     maxWidth: 512,
  //     maxHeight: 512,
  //   );
  //   if (croppedFile != null) {
  //     File croppedImage = File(croppedFile.path);
  //     setState(() {
  //       compressedFile = base64Encode(croppedImage.readAsBytesSync());
  //       getFileSize(croppedFile.path);
  //       if (isFileSizeValid) {
  //         emitSendMessage('', compressedFile, 'image', message, "",
  //             replyMessageDetails, '');
  //       } else {
  //         final customDialog = CustomDialog();
  //         customDialog.show(
  //           context: context,
  //           type: DialogType.ERROR,
  //           content: "Please try sending file size less than 5MB.",
  //           onPressed: () => Navigator.pop(context),
  //         );
  //       }
  //     });
  //   }
  // }

  void onVoiceSend(String path, String fileName, String message) async {
    var bytes = await File(path).readAsBytes();
    String base64string = base64.encode(bytes);

    getFileSize(path);
    if (isFileSizeValid) {
      emitSendMessage(fileName, base64string, "audio", message, "",
          replyMessageDetails, '');
    } else {
      final customDialog = CustomDialog();
      return customDialog.show(
        context: context,
        type: DialogType.ERROR,
        content: "Please try sending file size less than 5MB.",
        onPressed: () => Navigator.pop(context),
      );
    }
  }

  void onFileSend(String path, String fileName, String message) async {
    for (int i = 0; i < popTime; i++) {
      Navigator.pop(context);
    }
    var bytes = await File(path).readAsBytes();
    String base64string = base64.encode(bytes);
    getFileSize(path);
    if (isFileSizeValid) {
      //sendFailedMessages('');
      emitSendMessage(
          fileName, base64string, "file", message, "", replyMessageDetails, '');
    } else {
      final customDialog = CustomDialog();
      return customDialog.show(
        context: context,
        type: DialogType.ERROR,
        content: "Please try sending file size less than 5MB.",
        onPressed: () => Navigator.pop(context),
      );
    }
  }

  Future<void> storeMyMessage(String msgBody, String msgBinaryType,
      String msgBinary, int messageId, String clientMessageId) async {
    String filePath = "";
    String deviceId = await localStorage.getLoginDeviceId() ?? '';
    String? nickName = await localStorage.getNickName();
    if (msgBinaryType != '') {
      filePath = await createFile(msgBinaryType, msgBinary, msgBody);
    }

    MessageDetails messageDetails = MessageDetails(
        room_id: widget.Room_id,
        user_id: localUserid,
        app_id: appConfig.appId,
        ca_uid: localCaUid,
        device_id: deviceId,
        msg_body: msgBody,
        msg_binary: msgBinary,
        msg_binaryType: msgBinaryType,
        reply_to_id: replyMessageDetails.reply_to_id,
        message_id: messageId,
        read_by: '',
        status: '',
        status_msg: '',
        deleted: 0,
        send_datetime: DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime.now().toLocal())
            .toString(),
        edit_datetime: '',
        delete_datetime: '',
        transtamp: '',
        nick_name: nickName,
        filePath: filePath,
        owner_id: localUserid,
        msgStatus: "SENDING",
        client_message_id: clientMessageId,
        roomName: widget.roomName);
    //print(messageDetails.send_datetime);
    dbHelper.saveMsgDetailTable(messageDetails);
    context.read<ChatHistory>().addChatHistory(messageDetail: messageDetails);
    cancelReply();
  }

  void emitSendMessage(
      String fileName,
      String base64string,
      String msgBinaryType,
      String message,
      String type,
      ReplyMessageDetails replyMessageDetails,
      String clientMessageId) {
    if (message == '') message = fileName;

    if (type == '') {
      clientMessageId = generateRandomString(15);
      storeMyMessage(message, msgBinaryType, base64string, 0, clientMessageId);
    }
    var messageJson = {
      "roomId": widget.Room_id,
      "msgBody": message,
      "msgBinaryBuffer": base64string,
      "replyToId": replyMessageDetails.reply_to_id,
      "msgBinaryType": msgBinaryType,
      "clientMessageId": clientMessageId,
      "misc":
          "[FCM_Notification=title:" + roomName + ' - ' + localUserName + "]"
    };
    //print(messageJson);
    if (socket.connected) {
      socket.emitWithAck('sendMessage', messageJson, ack: (data) async {
        //print('sendMessage ack $data');
        if (data != null) {
          SendAcknowledge sendAcknowledge = SendAcknowledge.fromJson(data);
          if (sendAcknowledge.clientMessageId == clientMessageId) {
            context.read<ChatHistory>().updateChatItemStatus(
                clientMessageId, "SENT", sendAcknowledge.messageId);
            await dbHelper.updateMsgDetailTable(
                clientMessageId, "SENT", sendAcknowledge.messageId);
            if (myFailedList.length > 0) {
              int index = myFailedList.indexWhere(
                  (element) => element.client_message_id == clientMessageId);
              if (index > -1) {
                myFailedList.removeAt(index);
              }
            }
          }
          print('sendMessage from server $data');
        } else {
          print("Null from sendMessage");
        }
      });
    }
    Future.delayed(Duration(milliseconds: 500), () {
      itemScrollController.scrollTo(
          index: 0,
          duration: Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    });
  }

  sendFailedMessages(String type) {
    if (type != '') {
      myFailedList = getMessageDetailsList
          .where((element) =>
              element.room_id == widget.Room_id &&
              element.msgStatus == "SENDING" &&
              DateTime.now()
                      .difference(DateTime.parse(element.send_datetime!))
                      .inMinutes >
                  1)
          .toList();
    } else {
      myFailedList = getMessageDetailsList
          .where((element) =>
              element.room_id == widget.Room_id &&
              element.msgStatus == "SENDING")
          .toList();
    }

    if (myFailedList.length > 0) {
      ReplyMessageDetails myreplayList = ReplyMessageDetails(
          binaryType: '',
          msg_body: '',
          reply_to_id: 0,
          nick_name: '',
          filePath: '');
      myFailedList.forEach((messageDetails) async {
        if (messageDetails.client_message_id.toString() != '' &&
            localUserid != '') {
          if (messageDetails.reply_to_id! > 0) {
            List<MessageDetails> replyList = getMessageDetailsList
                .where((element) =>
                    element.message_id == messageDetails.reply_to_id!)
                .toList();

            myreplayList = ReplyMessageDetails(
                binaryType: replyList[0].msg_binaryType,
                msg_body: replyList[0].msg_body,
                reply_to_id: replyList[0].reply_to_id,
                nick_name: replyList[0].nick_name,
                filePath: replyList[0].filePath);
          }

          if (messageDetails.msg_binaryType == '') {
            sendMessage(messageDetails.msg_body!, "FailedMessages",
                myreplayList, messageDetails.client_message_id!);
          } else {
            var bytes = await File(messageDetails.filePath!).readAsBytes();
            emitSendMessage(
                messageDetails.filePath!.split('/').last,
                base64.encode(bytes),
                messageDetails.msg_binaryType!,
                messageDetails.msg_body!,
                "FailedMessages",
                myreplayList,
                messageDetails.client_message_id!);
          }
        }
      });
    }
  }

  onTyping() {
    socket.on('typing', (data) async {
      String? userid = await localStorage.getUserId();
      if (userid != data) {
        duplicateMembers = this.members;
        List<RoomMembers> roomMembersList =
            await dbHelper.getRoomMemberName(data);
        if (mounted) {
          setState(() {
            this.members = roomMembersList[0].nick_name! + ' Is Typing';
            duplicateMembers = duplicateMembers;
          });
        }
      }
    });
    socket.on('notTyping', (data) {
      if (this.localUserid != data) {
        if (mounted) {
          setState(() {
            this.members = duplicateMembers;
          });
        }
      }
    });
  }

  sendTyping(String value) {
    var messageJson = {
      "roomId": widget.Room_id,
    };
    socket.emit("typing", messageJson);
  }

  sendNotTyping() {
    var messageJson = {
      "roomId": widget.Room_id,
    };
    socket.emit("notTyping", messageJson);
  }

  void _getLoginUserId() async {
    String userid = await localStorage.getUserId() ?? '';
    String caUid = await localStorage.getCaUid() ?? '';
    String name = await localStorage.getName() ?? '';
    setState(() {
      localUserid = userid;
      localCaUid = caUid;
      localUserName = name;
      Hive.box('ws_url').put('isInChatRoom', localUserid);
    });
  }

  Widget bottomSheet() {
    return Container(
      // height: 278,
      height: 139,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconCreation(
                        Icons.insert_drive_file, Colors.indigo, "Document"),
                    SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                    SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                  ],
                ),
                // SizedBox(
                //   height: 30,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     iconCreation(Icons.headset, Colors.orange, "Audio"),
                //     SizedBox(
                //       width: 40,
                //     ),
                //     iconCreation(Icons.location_pin, Colors.teal, "Location"),
                //     SizedBox(
                //       width: 40,
                //     ),
                //     iconCreation(Icons.person, Colors.blue, "Contact"),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () async {
        if (text == "Gallery") {
          setState(() {
            popTime = 2;
          });

          file = await picker.pickImage(source: ImageSource.gallery);
          if (file == null) {
            Navigator.pop(context);
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => CameraViewPage(
                        path: file?.path ?? '', onImageSend: onImageSend)));
          }
        } else if (text == "Camera") {
          setState(() {
            popTime = 3;
          });

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => CameraScreen(
                        cameras: cameras,
                        onImageSend: onImageSend,
                      )));
        } else if (text == "Document") {
          setState(() {
            popTime = 1;
          });

          FilePickerResult? result = await FilePicker.platform
              .pickFiles(type: FileType.custom, allowedExtensions: [
            'pdf',
            'doc',
            'docx',
            'xls',
            'xlsx',
            'ppt',
            'pptx',
            'txt',
            'html',
            'csv',
            'mp4',
            'wmv'
          ]);

          if (result != null) {
            List<File> files = result.paths.map((path) => File(path!)).toList();
            if (files.length == 0) return;

            for (var file in files) {
              onFileSend(file.path, file.path.split('/').last, '');
            }
          } else {
            // User canceled the picker
          }
        }
        /*else if (text == "Audio") {
          setState(() {
            popTime = 1;
          });
          FilePickerResult? result =
              await FilePicker.platform.pickFiles(type: FileType.audio);
          if (result != null) {
            onFileSend(result.files.first.path!,
                result.files.first.path!.split('/').last);
          } else {
            // User canceled the picker
          }
        }*/
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  Future<String> createFolder(String folder) async {
    final dir = Directory((Platform.isAndroid
                ? await getExternalStorageDirectory() //FOR ANDROID
                : await getApplicationSupportDirectory() //FOR IOS
            )!
            .path +
        '/$folder');
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await dir.exists())) {
      return dir.path;
    } else {
      await dir.create(recursive: true);
      print(dir.path);
      return dir.path;
    }
  }

  Future<String> createFile(
      String fileType, String base64String, String fileName) async {
    File file;
    String folder = "";
    String extension = "";
    if (fileType == "audio") {
      folder = "Audios";
      extension = ".mp3";
    } else if (fileType == "image") {
      folder = "Images";
      extension = ".png";
    } else if (fileType == "video") {
      folder = "Videos";
      extension = ".mp4";
    } else if (fileType == "file") {
      folder = "Files";
      extension = "." + fileName.split('.').last;
    }
    try {
      Uint8List bytes = base64.decode(base64String);
      final dir = Directory((Platform.isAndroid
                  ? await getExternalStorageDirectory() //FOR ANDROID
                  : await getApplicationSupportDirectory() //FOR IOS
              )!
              .path +
          '/' +
          widget.Room_id +
          '/' +
          folder);
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      if ((await dir.exists())) {
        print(dir.path);
        file = File(dir.path +
            "/" +
            DateTime.now().millisecondsSinceEpoch.toString() +
            extension);
        await file.writeAsBytes(bytes);
      } else {
        await dir.create(recursive: true);
        print(dir.path);
        file = File(dir.path +
            "/" +
            DateTime.now().millisecondsSinceEpoch.toString() +
            extension);
        await file.writeAsBytes(bytes);
        //return dir.path;
      }
      return file.path;
    } on Exception catch (exception) {
      print(exception);
    } catch (error) {
      print(error);
    }
    return '';
  }

  Future<void> getFileSize(String path) async {
    final file = File(path);
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb <= 5) {
      isFileSizeValid = true;
    } else {
      isFileSizeValid = false;
    }

    setState(() {
      isFileSizeValid = isFileSizeValid;
    });
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      //_mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  void record() async {
    dirPath = await createFolder(widget.Room_id + '/' + pathToAudio);
    audioFilPath = dirPath +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.mp4';

    setState(() {
      isLoading = true;
    });

    sendTyping('');
    _mRecorder!
        .startRecorder(
      toFile: audioFilPath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {
        audioFilPath = audioFilPath;
      });
    });

    _mRecorder?.setSubscriptionDuration(Duration(milliseconds: 10));

    _recorderSubscription = _mRecorder?.onProgress!.listen((e) {
      // var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
      //     isUtc: true);
      // var txt = DateFormat('mm:ss', 'en_GB').format(date);
      setState(() {
        custFontSize = 20;
        editingController.text = e.duration.toString().substring(2, 7);
      });
    });
  }

  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
      _recorderSubscription = null;
    }
  }

  void stopRecorder() async {
    sendNotTyping();
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        isLoading = false;
        cancelRecorderSubscriptions();
        custFontSize = 15;
        //onVoiceSend(audioFilPath, audioFilPath.split('/').last);
        editingController.text = '';
        isAudioRecording = true;
        sendButton = true;
      });
    });
  }

  _onEmojiSelected(Emoji emoji) {
    editingController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: editingController.text.length));
    setState(() {
      sendButton = true;
    });
  }

  _onBackspacePressed() {
    editingController
      ..text = editingController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: editingController.text.length));
    if (editingController.text == '') {
      setState(() {
        sendButton = false;
      });
    }
  }

  Widget emojiSelect() {
    return EmojiPicker(
        onEmojiSelected: (Category? category, Emoji emoji) {
          _onEmojiSelected(emoji);
        },
        onBackspacePressed: _onBackspacePressed,
        config: Config(
            columns: 7,
            emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
            verticalSpacing: 0,
            horizontalSpacing: 0,
            initCategory: Category.RECENT,
            bgColor: const Color(0xFFF2F2F2),
            indicatorColor: Colors.blue,
            iconColor: Colors.grey,
            iconColorSelected: Colors.blue,
            // progressIndicatorColor: Colors.blue,
            backspaceColor: Colors.blue,
            skinToneDialogBgColor: Colors.white,
            skinToneIndicatorColor: Colors.grey,
            enableSkinTones: true,
            showRecentsTab: true,
            recentsLimit: 28,
            noRecents: const Text(
              'No Recents',
              style: TextStyle(fontSize: 20, color: Colors.black26),
              textAlign: TextAlign.center,
            ),
            tabIndicatorAnimDuration: kTabScrollDuration,
            categoryIcons: const CategoryIcons(),
            buttonMode: ButtonMode.MATERIAL));
  }
}
