import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:auto_route/auto_route.dart';
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
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
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
import '../../common_library/services/model/read_message_by_id_model.dart';
import '../../common_library/services/model/replymessage_model.dart';
import '../../common_library/services/repository/auth_repository.dart';
import '../../common_library/utils/capitalize_firstletter.dart';
import '../../common_library/utils/custom_dialog.dart';
import '../../common_library/utils/custom_snackbar.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/database_helper.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
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
import 'package:flutter/foundation.dart' as foundation;
import 'confirm_audio.dart';
import 'file_card.dart';
import 'image_card.dart';
import 'message_card.dart';
import 'reply_message_widget.dart';
import 'room_members.dart';
import 'video_card.dart';
import '../../router.gr.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const theSource = AudioSource.microphone;
typedef MyCallback = void Function(int messageId);
typedef ResendCallback = void Function(int messageId);

@RoutePage(name: 'chatRoom')
class ChatRoom extends StatefulWidget {
  const ChatRoom({
    Key? key,
    required this.roomId,
    required this.picturePath,
    required this.roomName,
    required this.roomDesc,
    // required this.roomMembers
  }) : super(key: key);
  final String roomId; //lowerCamelCase
  final String picturePath;
  final String roomName;
  final String roomDesc;
  // final String roomMembers;
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String originalValue = '';
  bool _isSendingMessage = false;
  final int batchSize = 10;
  int offset = 0;
  bool isDataLoading = false;
  bool _isFetchingData = false;
  int currentIndex = -1;
  List<int> filteredMessages = [];
  bool isSearching = false;
  String valueText = "";
  final chatRoomRepo = ChatRoomRepo();
  List<String> deleteList = [
    'DELETE FOR ME',
    'DELETE FOR EVERYONE',
    'CANCEL',
  ];
  List<MessageDetails> myFailedList = [];
  final bool _showDownArrow = false;
  final TextEditingController _textFieldController = TextEditingController();
  int _desiredItemIndex = -1;
  Timer? timer;
  String socketStatus = '';
  List parts = [];
  bool isAudioRecording = false;
  bool isReplying = false;
  late final ValueChanged<ReplyMessageDetails> onSwipedMessage;
  ReplyMessageDetails replyMessageDetails = ReplyMessageDetails(
      msgBody: '', replyToId: 0, nickName: '', filePath: '', binaryType: '');
  TextEditingController searcheditingController = TextEditingController();
  final List<MessageDetails> _selectedItems = [];
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
  FocusNode focusNode1 = FocusNode();
  bool sendButton = false;
  //ScrollController _scrollController = ScrollController();
  List<MessageDetails> getMessageDetailsList = [];
  bool _isWriting = false;
  late io.Socket socket;
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
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    clearAllAppNotifications();
    //Provider.of<ChatHistory>(context, listen: false).getChatHistory();
    // this.members = widget.roomMembers;
    // itemPositionsListener.itemPositions.addListener(() {
    //   if (itemPositionsListener.itemPositions.value.length > 0 &&
    //       itemPositionsListener.itemPositions.value.last.index >= 8) {
    //     setState(() {
    //       _showDownArrow = true;
    //     });
    //   } else {
    //     setState(() {
    //       _showDownArrow = false;
    //     });
    //   }
    // });
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
      if (!context.mounted) return;
      Provider.of<ChatNotificationCount>(context, listen: false)
          .updateNotificationBadge(roomId: widget.roomId, type: "DELETE");

      context.read<SocketClientHelper>().setIsEnterRoom(true);
    });
    _getCameras();
    //Provider.of<ChatHistory>(context, listen: false).deleteChats(widget.roomId);

    // final allChatHistoryProvider =
    //     Provider.of<ChatHistory>(context, listen: false);
    // allChatHistoryProvider.getChatHistoryByRoomId(widget.roomId);

    //BatchLoad
    final chatHistoryProvider =
        Provider.of<ChatHistory>(context, listen: false);
    chatHistoryProvider.getLazyLoadChatHistory(
        widget.roomId, offset, batchSize);
    offset += batchSize;
    _isFetchingData = false;
    itemPositionsListener.itemPositions.addListener(_onItemPositionsChanged);
  }

  void _onItemPositionsChanged() {
    final positions = itemPositionsListener.itemPositions.value;
    bool dataExist =
        Provider.of<ChatHistory>(context, listen: false).isDataExist;
    if (positions.isNotEmpty &&
        !_isFetchingData &&
        dataExist &&
        positions.last.index == getMessageDetailsList.length - 1) {
      _isFetchingData = true;
      _loadMoreChatHistory();
    }
  }

  Future<void> clearAllAppNotifications() async {
    // Initialize the local notification plugin
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Cancel all notifications generated by the app
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> _loadMoreChatHistory() async {
    getMessageDetailsList =
        await Provider.of<ChatHistory>(context, listen: false)
            .getLazyLoadChatHistory(widget.roomId, offset, batchSize);
    setState(() {
      offset += batchSize;
      _isFetchingData = false;
    });
  }

  Future<List<int>> searchMessages(String keyword) async {
    filteredMessages = [];
    while (true) {
      //await EasyLoading.show();
      if (!context.mounted) return filteredMessages;
      bool dataExist =
          Provider.of<ChatHistory>(context, listen: false).isDataExist;
      if (!dataExist) {
        List<MessageDetails> list = getMessageDetailsList
            // .where((element) =>
            //     element.room_id == widget.roomId &&
            //     element.msg_body!.toLowerCase() == keyword.toLowerCase())
            // .toList();
            .where((element) =>
                element.roomId == widget.roomId &&
                element.msgBody!.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
        currentIndex = -1;

        for (var message in list) {
          filteredMessages.add(message.messageId!);
        }
        break;
      }
      // setState(() {
      _isFetchingData = true;
      // });
      await _loadMoreChatHistory();
      List<MessageDetails> list = getMessageDetailsList
          // .where((element) =>
          //     element.room_id == widget.roomId &&
          //     element.msg_body!.toLowerCase() == keyword.toLowerCase())
          // .toList();
          .where((element) =>
              element.roomId == widget.roomId &&
              element.msgBody!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
      currentIndex = -1;
      for (var message in list) {
        filteredMessages.add(message.messageId!);
      }
    }
    //await EasyLoading.dismiss();
    return filteredMessages.toSet().toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    socket = context.watch<SocketClientHelper>().socket;
    if (socket.connected) {
      onTyping();
      if (localUserid != '') {
        List<MessageDetails> mylist = context
            .watch<ChatHistory>()
            .getMessageDetailsList
            .where((element) =>
                element.roomId == widget.roomId &&
                element.msgStatus == "UNREAD" &&
                element.userId != localUserid &&
                element.messageId != 0)
            .toList();

        for (var messageDetails in mylist) {
          updateMessageReadBy(
              messageDetails.messageId.toString(), localUserid, widget.roomId);
        }
        getReadByChatHistory();
      }
    }
  }

  void getReadByChatHistory() {
    List<MessageDetails> getUnreadMessageDetailsList = getMessageDetailsList
        .where((element) =>
            element.userId == localUserid &&
            element.roomId == widget.roomId &&
            element.msgStatus == 'SENT')
        .toList();
    if (getUnreadMessageDetailsList.isNotEmpty) {
      for (var messageDetails in getUnreadMessageDetailsList) {
        if (messageDetails.messageId.toString() != '') {
          getMessageReadBy(messageDetails.messageId!, widget.roomId);
        }
      }
    }
  }

  void _getCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }

  @override
  void dispose() {
    if (!_isSendingMessage) {
      editingController.dispose();
      // _scrollController.dispose();
      searcheditingController.dispose();
      _mRecorder!.closeRecorder();
      cancelRecorderSubscriptions();
      _mRecorder = null;
      Hive.box('ws_url').put('isInChatRoom', null);
      getMessageDetailsList = [];
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: getAppBar(context),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  getListview(),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Visibility(
                      visible: _showDownArrow,
                      child: FloatingActionButton(
                        child: const Icon(Icons.arrow_downward_sharp),
                        onPressed: () {
                          itemScrollController.scrollTo(
                              index: 0,
                              duration: const Duration(seconds: 2),
                              curve: Curves.easeInOutCubic);
                          // setState(() {
                          //   _showDownArrow = false;
                          // });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                if (replyMessageDetails.replyToId! > 0)
                                  buildReply(replyMessageDetails),
                                if (isAudioRecording) buildConfirmAudio(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        left: 2, right: 2, bottom: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: TextFormField(
                                      controller: editingController,
                                      focusNode: focusNode,
                                      style: TextStyle(fontSize: custFontSize),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      autocorrect: true,
                                      maxLines: 5,
                                      minLines: 1,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          if (!_isWriting) {
                                            _isWriting = true;
                                            sendTyping(value);
                                            Future.delayed(
                                                    const Duration(seconds: 2))
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
                                                : const Radius.circular(24),
                                            topRight: isReplying
                                                ? Radius.zero
                                                : const Radius.circular(24),
                                            bottomLeft:
                                                const Radius.circular(24),
                                            bottomRight:
                                                const Radius.circular(24),
                                          ),
                                        ),
                                        hintText: "Type a message",
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        prefixIcon: getEmojiIcon(),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
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
                                              icon: const Icon(
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
                                        //contentPadding: EdgeInsets.all(5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
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
                                    return;
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
                                    return;
                                  }
                                  stopRecorder();
                                }
                              }),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      // show ? emojiSelect() : Container()
                    ],
                  ),
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
                  return Future.value(false);
                } else {
                  if (_isSendingMessage) {
                    return Future.value(false);
                  } else {
                    Provider.of<ChatNotificationCount>(context, listen: false)
                        .updateNotificationBadge(
                            roomId: widget.roomId, type: "DELETE");
                    Provider.of<ChatNotificationCount>(context, listen: false)
                        .updateUnreadMessageId(roomId: widget.roomId);

                    // context.read<SocketClientHelper>().setRoomDetails('', '', '');
                    context.read<SocketClientHelper>().setIsEnterRoom(false);
                    context.read<RoomHistory>().getRoomHistory();
                    context.read<ChatHistory>().deleteChats(widget.roomId);
                    context.read<ChatHistory>().updateIsDataExist();
                    Navigator.pop(context);
                    return Future.value(true);
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget getEmojiIcon() {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
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
        child: Scrollbar(
      controller: scrollController,
      child: Consumer<ChatHistory>(
        builder: (ctx, msgList, child) => ScrollablePositionedList.builder(
          itemCount: msgList.getMessageDetailsList
              .where((element) => element.roomId == widget.roomId)
              .toList()
              .length,
          shrinkWrap: true,
          reverse: true,
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, index) {
            // if (index == msgList.getMessageDetailsList.length) {
            //   if (isDataLoading) {
            //     return Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   } else {
            //     return Container(); // Reached end of data
            //   }
            // }
            if (index >= 0) {
              ReplyMessageDetails existingReplayMessageDetails =
                  ReplyMessageDetails(
                      replyToId: 0,
                      msgBody: '',
                      nickName: '',
                      filePath: '',
                      binaryType: '');

              getMessageDetailsList = msgList.getMessageDetailsList
                  .where((element) => element.roomId == widget.roomId)
                  .toList()
                  .reversed
                  .toList();

              int replyId = getMessageDetailsList[index].replyToId!;
              if (getMessageDetailsList[index].replyToId! > 0) {
                int index = getMessageDetailsList
                    .indexWhere((element) => element.messageId == replyId);
                if (index > 0) {
                  MessageDetails msgDetails = getMessageDetailsList[index];
                  existingReplayMessageDetails.replyToId = msgDetails.messageId;
                  existingReplayMessageDetails.nickName = msgDetails.nickName;
                  existingReplayMessageDetails.filePath = msgDetails.filePath;
                  existingReplayMessageDetails.msgBody = msgDetails.msgBody;
                }
              }

              // if (getMessageDetailsList[index].room_id == widget.Room_id) {
              return Container(
                color: _desiredItemIndex == index ? Colors.grey[200] : null,
                child: InkWell(
                    onLongPress: () {
                      if (!isSearching &&
                          getMessageDetailsList[index].msgBinaryType !=
                              'userLeft' &&
                          getMessageDetailsList[index].msgBinaryType !=
                              'userJoined') {
                        isMultiSelectionEnabled = true;
                        doMultiSelectionItem(getMessageDetailsList[index]);
                      }
                    },
                    onTap: () {
                      doMultiSelectionItem(getMessageDetailsList[index]);
                      if (_selectedItems.isEmpty) {
                        setState(() {
                          isMultiSelectionEnabled = false;
                        });
                      }
                    },
                    child: Stack(
                      alignment:
                          getMessageDetailsList[index].userId == localUserid
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      children: [
                        Column(
                          children: [
                            if (getMessageDetailsList[index].msgBinaryType ==
                                "image") ...[
                              SwipeTo(
                                  onLeftSwipe: () {
                                    replyToMessage(
                                        getMessageDetailsList[index].nickName!,
                                        getMessageDetailsList[index].filePath!,
                                        getMessageDetailsList[index].messageId!,
                                        getMessageDetailsList[index].msgBody!,
                                        getMessageDetailsList[index]
                                            .msgBinaryType!);
                                  },
                                  onRightSwipe: () {
                                    replyToMessage(
                                        getMessageDetailsList[index].nickName!,
                                        getMessageDetailsList[index].filePath!,
                                        getMessageDetailsList[index].messageId!,
                                        getMessageDetailsList[index].msgBody!,
                                        getMessageDetailsList[index]
                                            .msgBinaryType!);
                                  },
                                  child: ImageCard(
                                    time: getMessageDetailsList[index]
                                            .sendDateTime ??
                                        '',
                                    nickName:
                                        getMessageDetailsList[index].nickName ??
                                            '',
                                    text:
                                        getMessageDetailsList[index].msgBody ??
                                            '',
                                    filePath:
                                        getMessageDetailsList[index].filePath ??
                                            '',
                                    user: getMessageDetailsList[index].userId ??
                                        '',
                                    localUser: localUserid,
                                    msgStatus: getMessageDetailsList[index]
                                            .msgStatus ??
                                        '',
                                    messageId: getMessageDetailsList[index]
                                            .messageId ??
                                        0,
                                    replyMessageDetails:
                                        existingReplayMessageDetails,
                                    onCancelReply: cancelReply,
                                    callback: tapListitem,
                                    roomDesc: widget.roomDesc,
                                  ))
                            ] else if (getMessageDetailsList[index]
                                    .msgBinaryType ==
                                "video") ...[
                              SwipeTo(
                                  onLeftSwipe: () {
                                    replyToMessage(
                                        getMessageDetailsList[index].nickName!,
                                        getMessageDetailsList[index].filePath!,
                                        getMessageDetailsList[index].messageId!,
                                        getMessageDetailsList[index].msgBody!,
                                        getMessageDetailsList[index]
                                            .msgBinaryType!);
                                  },
                                  onRightSwipe: () {
                                    replyToMessage(
                                        getMessageDetailsList[index].nickName!,
                                        getMessageDetailsList[index].filePath!,
                                        getMessageDetailsList[index].messageId!,
                                        getMessageDetailsList[index].msgBody!,
                                        getMessageDetailsList[index]
                                            .msgBinaryType!);
                                  },
                                  child: VideoCard(
                                    filePath:
                                        getMessageDetailsList[index].filePath ??
                                            '',
                                    time: getMessageDetailsList[index]
                                            .sendDateTime ??
                                        '',
                                    text:
                                        getMessageDetailsList[index].msgBody ??
                                            '',
                                    nickName:
                                        getMessageDetailsList[index].nickName ??
                                            '',
                                    user: getMessageDetailsList[index].userId ??
                                        '',
                                    localUser: localUserid,
                                    msgStatus: getMessageDetailsList[index]
                                            .msgStatus ??
                                        '',
                                    messageId: getMessageDetailsList[index]
                                            .messageId ??
                                        0,
                                    replyMessageDetails:
                                        existingReplayMessageDetails,
                                    onCancelReply: cancelReply,
                                    callback: tapListitem,
                                    roomDesc: widget.roomDesc,
                                  ))
                            ] else if (getMessageDetailsList[index]
                                    .msgBinaryType ==
                                "audio") ...[
                              SwipeTo(
                                  onLeftSwipe: () {
                                    replyToMessage(
                                        getMessageDetailsList[index].nickName!,
                                        getMessageDetailsList[index].filePath!,
                                        getMessageDetailsList[index].messageId!,
                                        getMessageDetailsList[index].msgBody!,
                                        getMessageDetailsList[index]
                                            .msgBinaryType!);
                                  },
                                  onRightSwipe: () {
                                    replyToMessage(
                                        getMessageDetailsList[index].nickName!,
                                        getMessageDetailsList[index].filePath!,
                                        getMessageDetailsList[index].messageId!,
                                        getMessageDetailsList[index].msgBody!,
                                        getMessageDetailsList[index]
                                            .msgBinaryType!);
                                  },
                                  child: AudioCard(
                                    nickName:
                                        getMessageDetailsList[index].nickName ??
                                            '',
                                    text:
                                        getMessageDetailsList[index].msgBody ??
                                            '',
                                    time: getMessageDetailsList[index]
                                            .sendDateTime ??
                                        '',
                                    filePath:
                                        getMessageDetailsList[index].filePath ??
                                            '',
                                    user: getMessageDetailsList[index].userId ??
                                        '',
                                    localUser: localUserid,
                                    msgStatus: getMessageDetailsList[index]
                                            .msgStatus ??
                                        '',
                                    messageId: getMessageDetailsList[index]
                                            .messageId ??
                                        0,
                                    replyMessageDetails:
                                        existingReplayMessageDetails,
                                    onCancelReply: cancelReply,
                                    callback: tapListitem,
                                    roomDesc: widget.roomDesc,
                                  ))
                            ] else if (getMessageDetailsList[index]
                                    .msgBinaryType ==
                                "file") ...[
                              SwipeTo(
                                  onLeftSwipe: () {
                                    replyToMessage(
                                        getMessageDetailsList[index].nickName!,
                                        getMessageDetailsList[index].filePath!,
                                        getMessageDetailsList[index].messageId!,
                                        getMessageDetailsList[index].msgBody!,
                                        getMessageDetailsList[index]
                                            .msgBinaryType!);
                                  },
                                  onRightSwipe: () {
                                    replyToMessage(
                                        getMessageDetailsList[index].nickName!,
                                        getMessageDetailsList[index].filePath!,
                                        getMessageDetailsList[index].messageId!,
                                        getMessageDetailsList[index].msgBody!,
                                        getMessageDetailsList[index]
                                            .msgBinaryType!);
                                  },
                                  child: FileCard(
                                    nickName:
                                        getMessageDetailsList[index].nickName ??
                                            '',
                                    text:
                                        getMessageDetailsList[index].msgBody ??
                                            '',
                                    time: getMessageDetailsList[index]
                                            .sendDateTime ??
                                        '',
                                    filePath:
                                        getMessageDetailsList[index].filePath ??
                                            '',
                                    user: getMessageDetailsList[index].userId ??
                                        '',
                                    localUser: localUserid,
                                    msgStatus: getMessageDetailsList[index]
                                            .msgStatus ??
                                        '',
                                    messageId: getMessageDetailsList[index]
                                            .messageId ??
                                        0,
                                    replyMessageDetails:
                                        existingReplayMessageDetails,
                                    onCancelReply: cancelReply,
                                    callback: tapListitem,
                                    roomDesc: widget.roomDesc,
                                  ))
                            ] else if (getMessageDetailsList[index]
                                        .msgBinaryType ==
                                    "userLeft" ||
                                getMessageDetailsList[index].msgBinaryType ==
                                    "userJoined" ||
                                getMessageDetailsList[index].msgBinaryType ==
                                    "changed") ...[
                              UserLeftJoinedCard(
                                messageDetails: getMessageDetailsList[index],
                              )
                            ] else ...[
                              SwipeTo(
                                  iconOnLeftSwipe:
                                      getMessageDetailsList[index].userId ==
                                              localUserid
                                          ? Icons.edit
                                          : Icons.reply_sharp,
                                  iconSize: 30,
                                  iconColor: Colors.blue,
                                  onLeftSwipe: () {
                                    if (getMessageDetailsList[index].userId ==
                                        localUserid) {
                                      editingController.text =
                                          getMessageDetailsList[index].msgBody!;

                                      setState(() {
                                        updateStatus = true;
                                        updateMessageId =
                                            getMessageDetailsList[index]
                                                .messageId!;
                                      });
                                    } else {
                                      replyToMessage(
                                          getMessageDetailsList[index]
                                              .nickName!,
                                          getMessageDetailsList[index]
                                              .filePath!,
                                          getMessageDetailsList[index]
                                              .messageId!,
                                          getMessageDetailsList[index].msgBody!,
                                          getMessageDetailsList[index]
                                              .msgBinaryType!);
                                    }
                                  },
                                  onRightSwipe: () {
                                    replyToMessage(
                                        getMessageDetailsList[index].nickName!,
                                        getMessageDetailsList[index].filePath!,
                                        getMessageDetailsList[index].messageId!,
                                        getMessageDetailsList[index].msgBody!,
                                        getMessageDetailsList[index]
                                            .msgBinaryType!);
                                  },
                                  child: MessageCard(
                                    messageDetails:
                                        getMessageDetailsList[index],
                                    localUser: localUserid,
                                    replyMessageDetails:
                                        existingReplayMessageDetails,
                                    onCancelReply: cancelReply,
                                    callback: tapListitem,
                                    resendCallback: tapResend,
                                    roomDesc: widget.roomDesc,
                                    searchKey: _desiredItemIndex == index &&
                                            isSearching
                                        ? searcheditingController.text
                                        : '',
                                    isSearching: isSearching,
                                  ))
                            ]
                          ],
                        ),
                        Visibility(
                            visible: isMultiSelectionEnabled,
                            child: getMessageDetailsList[index].msgBinaryType !=
                                        'userLeft' &&
                                    getMessageDetailsList[index]
                                            .msgBinaryType !=
                                        'userJoined'
                                ? Icon(
                                    _selectedItems.contains(
                                            getMessageDetailsList[index])
                                        ? Icons.check_circle
                                        : Icons.radio_button_unchecked,
                                    size: 30,
                                    color: Colors.blue,
                                  )
                                : const Text(''))
                      ],
                    )),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    ));
  }

  Widget buildReply(ReplyMessageDetails replyMessageDetails) => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
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
        ? "${_selectedItems.length} item selected"
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
                      "Are you sure you want to delete ${messageDetails.msgBody}?"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        setState(() {
                          //itemsList.removeAt(index);
                          deleteChatMessage(
                              messageDetails.messageId!, '', widget.roomId);
                        });

                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        } else {
          editingController.text = messageDetails.msgBody!;

          setState(() {
            updateStatus = true;
            updateMessageId = messageDetails.messageId!;
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
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                title: Text(
                  'Delete ${selectedItems.length} Message?',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                content: SingleChildScrollView(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Divider(),
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
                                      for (var messageDetails
                                          in _selectedItems) {
                                        deleteChatMessage(
                                            messageDetails.messageId!,
                                            'FORME',
                                            widget.roomId);
                                      }
                                      Navigator.of(context).pop();
                                    } else if (index == 1) {
                                      for (var messageDetails
                                          in _selectedItems) {
                                        deleteChatMessage(
                                            messageDetails.messageId!,
                                            'EVERYONE',
                                            widget.roomId);
                                      }
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
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: Text(
                selectedItems.length == 1
                    ? 'Delete Message From ${selectedItems[0].nickName}?'
                    : 'Delete ${selectedItems.length} Messages?',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
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
                  child: const Text(
                    "DELETE FOR ME",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    for (var messageDetails in _selectedItems) {
                      deleteChatMessage(
                          messageDetails.messageId!, 'FORME', widget.roomId);
                    }
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
        msgBody: message,
        replyToId: messageId,
        nickName: name,
        filePath: path,
        binaryType: binaryType);

    setState(() {
      replyMessageDetails = replyMessageDetails;
    });
  }

  void cancelReply() {
    replyMessageDetails = ReplyMessageDetails(
        msgBody: '', replyToId: 0, nickName: '', filePath: '', binaryType: '');

    setState(() {
      replyMessageDetails = replyMessageDetails;
    });
  }

  void tapListitem(int messageId) {
    int index = getMessageDetailsList
        .indexWhere((element) => element.messageId == messageId);
    itemScrollController.scrollTo(
        index: index,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOutCubic);

    Timer(const Duration(seconds: 5), () {
      _desiredItemIndex = -1;
      //print('Timer');
    });
    setState(() {
      _desiredItemIndex = index;
    });
  }

  void tapResend(int messageId) {
    List<MessageDetails> list = getMessageDetailsList
        .where((element) => element.messageId == messageId)
        .toList();
    Future.delayed(const Duration(milliseconds: 500), () {
      itemScrollController.scrollTo(
          index: 0,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    });
    setState(() {
      editingController.text = list[0].msgBody!;
    });
  }

  Widget buildConfirmAudio() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
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

  _getAppBarMembers() async {
    roomMembers = await dbHelper.getRoomMembersList(widget.roomId);
    if (roomMembers.isNotEmpty) {
      for (var roomMember in roomMembers) {
        if (roomMember.userId != localUserid) {
          members +=
              "${CapitalizeFirstLetter().capitalizeFirstLetter(roomMember.nickName ?? "")},";
        }
      }
      setState(() {
        if (members.isNotEmpty) {
          members = members.substring(0, members.length - 1);
        }
        originalValue = members;
        membersCount = roomMembers.length;
        if (membersCount > 0) roomName = roomMembers[0].roomName!;
      });
    }
  }

  void navigateSearchResults(int direction) {
    if (filteredMessages.isNotEmpty) {
      setState(() {
        if (direction == 1) {
          if (currentIndex < filteredMessages.length - 1) {
            currentIndex++;
            int index = getMessageDetailsList.indexWhere((element) =>
                element.messageId == filteredMessages[currentIndex]);
            _desiredItemIndex = index;

            itemScrollController.scrollTo(
                index: index,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutCubic);
          } else {
            currentIndex = 0;
            int index = getMessageDetailsList.indexWhere((element) =>
                element.messageId == filteredMessages[currentIndex]);
            _desiredItemIndex = index;

            itemScrollController.scrollTo(
                index: index,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutCubic);
          }
        } else {
          if (currentIndex > 0) {
            currentIndex--;
            int index = getMessageDetailsList.indexWhere((element) =>
                element.messageId == filteredMessages[currentIndex]);
            _desiredItemIndex = index;
            itemScrollController.scrollTo(
                index: index,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutCubic);
          } else {
            currentIndex = filteredMessages.length - 1;
            int index = getMessageDetailsList.indexWhere((element) =>
                element.messageId == filteredMessages[currentIndex]);
            _desiredItemIndex = index;
            itemScrollController.scrollTo(
                index: index,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutCubic);
          }
        }
      });
    } else {
      final customSnackbar = CustomSnackbar();
      customSnackbar.show(
        context,
        message: 'No messages found.',
        duration: 5000,
        type: MessageType.info,
      );
    }
  }

  getAppBar(BuildContext context) {
    if (isSearching) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 24,
          ),
          onPressed: () {
            setState(() {
              isSearching = false;
              filteredMessages = [];
              currentIndex = -1;
              _desiredItemIndex = -1;
              searcheditingController.clear();
            });
          },
        ),
        backgroundColor: Colors.blueAccent,
        title: TextField(
          focusNode: focusNode1,
          cursorColor: Colors.white,
          controller: searcheditingController,
          onChanged: (value) async {
            if (value != '') {
              List<int> searchResults = [];
              searchResults = await searchMessages(value);
              if (searchResults.isNotEmpty) {
                searchResults.sort((a, b) => a.compareTo(b));
                setState(() {
                  filteredMessages = searchResults;
                });
              }
            } else {
              setState(() {
                filteredMessages = [];
                currentIndex = -1;
                _desiredItemIndex = -1;
              });
            }
          },
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              hintText: "Search Message",
              contentPadding: EdgeInsets.only(left: 10.0),
              hintStyle: TextStyle(color: Colors.white)),
        ),
        actions: <Widget>[
          // isSearching
          //     ?
          IconButton(
            icon: const Icon(Icons.cancel),
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
            icon: const Icon(Icons.arrow_circle_up),
            onPressed: () {
              focusNode1.unfocus();
              focusNode1.canRequestFocus = false;
              navigateSearchResults(-1);
              // if (filteredMessages.length > 0) {
              //   if (currentIndex == -1) {
              //     int index = getMessageDetailsList.indexWhere(
              //         (element) => element.message_id == filteredMessages[0]);

              //     setState(() {
              //       _desiredItemIndex = index;
              //       currentIndex = 1;
              //     });
              //     itemScrollController.scrollTo(
              //         index: index,
              //         duration: Duration(seconds: 2),
              //         curve: Curves.easeInOutCubic);
              //   } else {
              //     if (currentIndex != -1 &&
              //         currentIndex < filteredMessages.length) {
              //       int messageId = filteredMessages[currentIndex];
              //       int index = getMessageDetailsList.indexWhere(
              //           (element) => element.message_id == messageId);

              //       setState(() {
              //         _desiredItemIndex = index;
              //         currentIndex = currentIndex + 1;
              //       });
              //       itemScrollController.scrollTo(
              //           index: index,
              //           duration: Duration(seconds: 2),
              //           curve: Curves.easeInOutCubic);
              //     } else if (currentIndex == filteredMessages.length) {
              //       setState(() {
              //         currentIndex = 0;
              //       });
              //       final customSnackbar = CustomSnackbar();
              //       customSnackbar.show(
              //         context,
              //         message: 'No messages found.',
              //         duration: 5000,
              //         type: MessageType.INFO,
              //       );
              //     }
              //   }
              // } else {
              //   final customSnackbar = CustomSnackbar();
              //   customSnackbar.show(
              //     context,
              //     message: 'No messages found.',
              //     duration: 5000,
              //     type: MessageType.INFO,
              //   );
              // }
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_circle_down),
            onPressed: () {
              focusNode1.unfocus();
              focusNode1.canRequestFocus = false;
              navigateSearchResults(1);
              // if (currentIndex < filteredMessages.length &&
              //     currentIndex != -1) {
              //   int messageId = filteredMessages[currentIndex];
              //   int index = getMessageDetailsList
              //       .indexWhere((element) => element.message_id == messageId);
              //   itemScrollController.scrollTo(
              //       index: index,
              //       duration: Duration(seconds: 2),
              //       curve: Curves.easeInOutCubic);

              //   Timer(Duration(seconds: 5), () {
              //     _desiredItemIndex = -1;
              //   });
              //   setState(() {
              //     _desiredItemIndex = index;
              //     currentIndex = currentIndex - 1;
              //   });
              // } else {
              //   final customSnackbar = CustomSnackbar();
              //   customSnackbar.show(
              //     context,
              //     message: 'No messages found.',
              //     duration: 5000,
              //     type: MessageType.INFO,
              //   );
              // }
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
                icon: const Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
                onPressed: () {
                  if (_isSendingMessage) {
                    return;
                  } else {
                    Provider.of<ChatNotificationCount>(context, listen: false)
                        .updateNotificationBadge(
                            roomId: widget.roomId, type: "DELETE");
                    Provider.of<ChatNotificationCount>(context, listen: false)
                        .updateUnreadMessageId(roomId: widget.roomId);

                    Navigator.pop(context);
                    //context.router.pop();
                    //context.router.navigate(const RoomList());
                    context.read<SocketClientHelper>().setIsEnterRoom(false);
                    context.read<RoomHistory>().getRoomHistory();
                    context.read<ChatHistory>().deleteChats(widget.roomId);
                    context.read<ChatHistory>().updateIsDataExist();
                  }
                },
              ),
            ],
          ),
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          offset: const Offset(0, 2),
                          blurRadius: 5)
                    ],
                  ),
                  child: FullScreenWidget(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: widget.picturePath != ''
                            ? Image.network(widget.picturePath
                                .replaceAll(removeBracket, '')
                                .split('\r\n')[0])
                            : const Icon(Icons.account_circle),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RoomMembersList(
                                roomId: widget.roomId,
                                userId: localUserid,
                                picturePath: widget.picturePath,
                                roomName: widget.roomName,
                                roomDesc: widget.roomDesc,
                                // roomMembers: widget.roomMembers
                              )),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.roomName,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        members,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              padding: const EdgeInsets.all(0),
              onSelected: (value) {
                if (value == "View Contacts") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomMembersList(
                        roomId: widget.roomId,
                        userId: localUserid,
                        picturePath: widget.picturePath,
                        roomName: widget.roomName,
                        roomDesc: widget.roomDesc,
                      ),
                    ),
                  );
                } else if (value == "Search") {
                  setState(() {
                    isSearching = true;
                    focusNode1.requestFocus();
                  });
                } else if (value == "Media and Files") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatFiles(
                        roomId: widget.roomId,
                      ),
                    ),
                  );
                } else if (value == "Add New Member") {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CreateGroup(
                  //       roomId: widget.roomId,
                  //     ),
                  //   ),
                  // );
                  context.router.replace(
                    CreateGroup(
                      roomId: widget.roomId,
                    ),
                  );
                } else if (value == "Change Group Name") {
                  _displayTextInputDialog(context, widget.roomName);
                } else if (value == "Leave Group") {
                  leaveGroup(widget.roomId);
                }
                // else if (value == "Delete Chat") {
                //   print('Delete Chat');
                // }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: "View Contacts",
                    child: Text("View Contacts"),
                  ),
                  const PopupMenuItem(
                    value: "Search",
                    child: Text("Search"),
                  ),
                  const PopupMenuItem(
                    value: "Media and Files",
                    child: Text("Media and Files"),
                  ),
                  if (widget.roomDesc.toUpperCase().contains("GROUP"))
                    const PopupMenuItem(
                      value: "Add New Member",
                      child: Text("Add New Member"),
                    ),
                  if (widget.roomDesc.toUpperCase().contains("GROUP"))
                    const PopupMenuItem(
                      value: "Change Group Name",
                      child: Text("Change Group Name"),
                    ),
                  if (widget.roomDesc.toUpperCase().contains("GROUP"))
                    const PopupMenuItem(
                      value: "Leave Group",
                      child: Text("Leave Group"),
                    ),
                ];
              },
            ),
          ],
        );
      } else {
        return AppBar(
          leading: IconButton(
            icon: const Icon(
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
            style: const TextStyle(
              fontSize: 18.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                var contain = _selectedItems
                    .where((element) => element.userId != localUserid);
                if (contain.isNotEmpty) {
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

  Future<void> _displayTextInputDialog(
      BuildContext context, String roomName) async {
    _textFieldController.text = roomName;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Change Group Name'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "Group Name"),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red),
                child: const Text('CANCEL'),
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
                child: const Text('OK'),
                onPressed: () async {
                  await EasyLoading.show(
                    maskType: EasyLoadingMaskType.black,
                  );
                  var inviteResult = await chatRoomRepo.changeGroupName(
                      widget.roomId, valueText);

                  if (inviteResult.data != null &&
                      inviteResult.data.length > 0) {
                    InviteRoomResponse inviteRoomResponse =
                        inviteResult.data[0];
                    if (!context.mounted) return;
                    context.read<RoomHistory>().updateRoom(
                        roomId: inviteRoomResponse.roomId!,
                        roomName: inviteRoomResponse.roomName!);
                    await dbHelper.updateRoomName(inviteRoomResponse.roomName!,
                        inviteRoomResponse.roomId!);

                    List<RoomMembers> roomMembers = await dbHelper
                        .getRoomMembersList(inviteRoomResponse.roomId!);

                    for (var roomMember in roomMembers) {
                      if (localUserid != roomMember.userId) {
                        var groupJson = {
                          "notifiedRoomId": inviteRoomResponse.roomId!,
                          "notifiedUserId": roomMember.userId,
                          "title":
                              '$localUserid|${inviteRoomResponse.roomId!} just changed the group name',
                          "description":
                              '${valueText}_just changed the group name'
                        };
                        socket.emitWithAck('sendNotification', groupJson,
                            ack: (data) async {
                          print(data);
                        });
                      }
                    }
                    String clientMessageId = generateRandomString(15);

                    var messageJson = {
                      "roomId": inviteRoomResponse.roomId!,
                      "msgBody":
                          '$localUserName changed group name to $valueText',
                      "msgBinaryType": 'changed',
                      "replyToId": -1,
                      "clientMessageId": clientMessageId,
                      "misc":
                          "[FCM_Notification=title: $roomName - $localUserName]"
                    };
                    // storeMyMessage('You changed group name to $valueText',
                    //     'changed', '', 0, clientMessageId);
                    socket.emitWithAck('sendMessage', messageJson,
                        ack: (data) async {
                      if (data != null && !data.containsKey("error")) {
                        SendAcknowledge sendAcknowledge =
                            SendAcknowledge.fromJson(data);
                        // if (sendAcknowledge.clientMessageId == clientMessageId) {
                        context.read<ChatHistory>().updateChatItemStatus(
                            clientMessageId,
                            "SENT",
                            sendAcknowledge.messageId,
                            widget.roomId,
                            DateFormat("yyyy-MM-dd HH:mm:ss")
                                .format(DateTime.parse(
                                        sendAcknowledge.sendDateTime ?? '')
                                    .toLocal())
                                .toString());
                        await dbHelper.updateMsgDetailTable(
                            clientMessageId,
                            "SENT",
                            sendAcknowledge.messageId,
                            DateFormat("yyyy-MM-dd HH:mm:ss")
                                .format(DateTime.parse(
                                        sendAcknowledge.sendDateTime ?? '')
                                    .toLocal())
                                .toString());
                      } else {}
                    });
                    await EasyLoading.dismiss();
                    setState(() {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  } else {
                    await EasyLoading.dismiss();
                    final customDialog = CustomDialog();
                    if (!context.mounted) return;
                    customDialog.show(
                      context: context,
                      type: DialogType.error,
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
        members,
        style: Theme.of(context).textTheme.bodySmall,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      return const Text('');
    }
  }

  void leaveGroup(String roomId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("Are you sure you want to  leave the group?"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  "Leave",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  var leaveRoomResponseResult =
                      await chatRoomRepo.leaveRoom(roomId);
                  if (leaveRoomResponseResult.data != null &&
                      leaveRoomResponseResult.data.length > 0) {
                    List<RoomMembers> roomMembers =
                        await dbHelper.getRoomMembersList(widget.roomId);
                    for (var roomMember in roomMembers) {
                      if (localUserid != roomMember.userId) {
                        var leaveGroupJson = {
                          "notifiedRoomId": widget.roomId,
                          "notifiedUserId": roomMember.userId,
                          "title": "$localUserName just left the room",
                          "description":
                              "$localUserid just left the room_$roomId"
                        };
                        //print(messageJson);
                        socket.emitWithAck('sendNotification', leaveGroupJson,
                            ack: (data) async {});
                      }
                    }
                    String clientMessageId = generateRandomString(15);

                    var messageJson = {
                      "roomId": widget.roomId,
                      "msgBody": '$localUserName left',
                      "msgBinaryType": 'userLeft',
                      "replyToId": -1,
                      "clientMessageId": clientMessageId,
                      "misc":
                          "[FCM_Notification=title: $roomName - $localUserName]"
                    };

                    socket.emitWithAck('sendMessage', messageJson,
                        ack: (data) async {
                      if (data != null && !data.containsKey("error")) {
                        var logOutJson = {
                          "roomId": widget.roomId,
                        };
                        socket.emitWithAck('logout', logOutJson, ack: (data) {
                          //print('ack $data');
                          if (data != null && !data.containsKey("error")) {
                            //print('logout user from server $data');
                          } else {
                            //print("Null from logout user");
                          }
                        });
                        //print('sendMessage from server $data');
                      } else {
                        //print("Null from sendMessage");
                      }
                    });

                    // Provider.of<RoomHistory>(context, listen: false)
                    //     .deleteRoom(roomId: widget.Room_id);
                    if (!context.mounted) return;
                    Provider.of<ChatNotificationCount>(context, listen: false)
                        .removeNotificationRoom(roomId: roomId);
                    await dbHelper.deleteRoomById(widget.roomId);
                    await dbHelper.deleteRoomMembersByRoomId(widget.roomId);
                    await dbHelper.deleteMessagesByRoomId(widget.roomId);
                    final dir = Directory(
                        '${(Platform.isAndroid ? await getExternalStorageDirectory() //FOR ANDROID
                                : await getApplicationSupportDirectory() //FOR IOS
                            )!.path}/$roomId');

                    deleteDirectory(dir);
                    if (!context.mounted) return;
                    Provider.of<RoomHistory>(context, listen: false)
                        .getRoomHistory();
                  }
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void deleteDirectory(Directory directory) {
    if (directory.existsSync()) {
      directory.listSync().forEach((FileSystemEntity entity) {
        if (entity is File) {
          entity.deleteSync();
        } else if (entity is Directory) {
          deleteDirectory(entity);
        }
      });
      directory.deleteSync();
    }
  }

  void deleteChatMessage(int messageId, String type, String roomId) async {
    if (type == 'FORME') {
      List<MessageDetails> list = getMessageDetailsList
          .where((element) =>
              element.messageId == messageId && element.filePath != '')
          .toList();

      if (list.isNotEmpty) {
        await deleteFile(File(list[0].filePath!));
      }
      if (!context.mounted) return;
      await context.read<ChatHistory>().deleteChatItem(messageId, roomId);
      //await dbHelper.deleteMsgDetailTable(messageId);
      await dbHelper.updateMessageStatus(messageId);
    } else {
      var deleteMessageJson = {
        "messageId": messageId,
      };
      //print('socket connection:' + socket.connected.toString());
      socket.emitWithAck('deleteMessage', deleteMessageJson, ack: (data) async {
        // print('deleteMessage from server $data');
        // print('deletemessage_' + socket.id!);
        if (data != null && !data.containsKey("error")) {
          Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
          if (result["messageId"] != '') {
            List<MessageDetails> list = getMessageDetailsList
                .where((element) =>
                    element.messageId == messageId && element.filePath != '')
                .toList();

            if (list.isNotEmpty) {
              await deleteFile(File(list[0].filePath!));
            }
            if (!context.mounted) return;
            await context.read<ChatHistory>().deleteChatItem(messageId, roomId);
            //await dbHelper.deleteMsgDetailTable(messageId);
            await dbHelper.updateMessageStatus(messageId);
          }
        } else {
          //print("Null from deleteMessage");
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
      //print(e.toString());
      // Error in getting access to the file.
    }
  }

  void updateChatMessage(int messageId, String text, String roomId) {
    var messageJson = {"messageId": messageId, "msgBody": text};
    //print(messageJson);
    socket.emitWithAck('updateMessage', messageJson, ack: (data) async {
      //print('updateMessage ack $data');
      if (data != null && !data.containsKey("error")) {
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result['editDateTime'] != null && result['editDateTime'] != '') {
          context.read<ChatHistory>().updateChatItemMessage(
              text, messageId, result['editDateTime'], roomId);
          await dbHelper.updateMsgDetailTableText(
              text, messageId, result['editDateTime']);
        }
        //print('updateMessage from server $data');
      } else {
        //print("Null from updateMessage");
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
        "roomId": widget.roomId,
        "msgBody": text,
        "replyToId": replyMessageDetails.replyToId,
        "clientMessageId": clientMessageId,
        "misc": "[FCM_Notification=title: $roomName - $localUserName]"
      };
      //print('sendMessage: $messageJson');
      if (socket.connected) {
        socket.emitWithAck('sendMessage', messageJson, ack: (data) async {
          if (data != null && !data.containsKey("error")) {
            SendAcknowledge sendAcknowledge = SendAcknowledge.fromJson(data);
            // if (sendAcknowledge.clientMessageId == clientMessageId) {
            context.read<ChatHistory>().updateChatItemStatus(
                clientMessageId,
                "SENT",
                sendAcknowledge.messageId,
                widget.roomId,
                DateFormat("yyyy-MM-dd HH:mm:ss")
                    .format(DateTime.parse(sendAcknowledge.sendDateTime ?? '')
                        .toLocal())
                    .toString());
            await dbHelper.updateMsgDetailTable(
                clientMessageId,
                "SENT",
                sendAcknowledge.messageId,
                DateFormat("yyyy-MM-dd HH:mm:ss")
                    .format(DateTime.parse(sendAcknowledge.sendDateTime ?? '')
                        .toLocal())
                    .toString());
            if (myFailedList.isNotEmpty) {
              int index = myFailedList.indexWhere(
                  (element) => element.clientMessageId == clientMessageId);
              if (index > -1) {
                myFailedList.removeAt(index);
              }
            }
            // }
            //print('sendMessage from server $data');
          } else {
            //print("Null from sendMessage");
          }
        });
      }
      Future.delayed(const Duration(milliseconds: 500), () {
        itemScrollController.scrollTo(
            index: 0,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOutCubic);
      });
    } else {
      updateChatMessage(updateMessageId, text, widget.roomId);
      setState(() {
        updateStatus = false;
        editingController.text = '';
        updateMessageId = 0;
      });
    }
  }

  updateMessageReadBy(String messageId, String userId, String roomId) {
    var messageJson = {
      "messageId": messageId,
      "userId": userId,
    };
    //print(messageJson);
    socket.emitWithAck('updateMessageReadBy', messageJson, ack: (data) async {
      //print('updateMessageReadBy ack $data');
      if (data != null && !data.containsKey("error")) {
        //print('updateMessageReadBy from server $data');
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result["messageId"] != '') {
          context.read<ChatHistory>().updateChatItemStatus(
              '', "READ", int.parse(messageId), roomId, '');
          await dbHelper.updateMsgStatus('READ', int.parse(messageId));
        }
      } else {
        //print("Null from updateMessageReadBy");
      }
    });
  }

  getMessageReadBy(int messageId, String roomId) {
    if (socket.connected) {
      var messageJson = {
        "messageId": messageId,
        "returnMsgBinaryAsBase64": "true"
      };
      //print(messageJson);
      socket.emitWithAck('getMessageById', messageJson, ack: (data) async {
        //print('getMessageById ack $data');
        if (data != null && !data.containsKey("error")) {
          ReadByMessage readByMessage = ReadByMessage.fromJson(data);
          if (readByMessage.message != null &&
              readByMessage.message!.readMessage![0].readBy != null &&
              readByMessage.message!.readMessage![0].readBy!
                  .contains('[[ALL]]')) {
            context.read<ChatHistory>().updateChatItemStatus(
                '',
                "READ",
                int.parse(readByMessage.message!.readMessage![0].id!),
                roomId,
                '');
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
    final random = Random();
    const availableChars = '123456789';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
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
      await getFileSize(path);
      if (isFileSizeValid) {
        var bytes = await File(path).readAsBytes();
        String base64string = base64.encode(bytes);
        await emitSendMessage(
            '', base64string, 'image', message, "", replyMessageDetails, '');
        //_editImage(f, message);
      } else {
        final customDialog = CustomDialog();
        if (!context.mounted) return;
        customDialog.show(
          context: context,
          type: DialogType.error,
          content: "Please try sending file size less than 2 MB.",
          onPressed: () => Navigator.pop(context),
        );
      }
    } else {
      await getFileSize(path);
      if (isFileSizeValid) {
        var bytes = await File(path).readAsBytes();
        String base64string = base64.encode(bytes);
        await emitSendMessage(message, base64string, "video", message, "",
            replyMessageDetails, '');
      } else {
        final customDialog = CustomDialog();
        if (!context.mounted) return;
        customDialog.show(
          context: context,
          type: DialogType.error,
          content: "Please try sending file size less than 2 MB.",
          onPressed: () => Navigator.pop(context),
        );
      }
    }
  }

  void onVoiceSend(String path, String fileName, String message) async {
    var bytes = await File(path).readAsBytes();
    String base64string = base64.encode(bytes);

    await getFileSize(path);
    if (isFileSizeValid) {
      await emitSendMessage(fileName, base64string, "audio", message, "",
          replyMessageDetails, '');
    } else {
      final customDialog = CustomDialog();
      if (!context.mounted) return;
      customDialog.show(
        context: context,
        type: DialogType.error,
        content: "Please try sending file size less than 2 MB.",
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
    var fileType = 'file';
    if (path.split(".").last.toUpperCase().contains('MP4')) {
      fileType = 'video';
    }
    await getFileSize(path);
    if (isFileSizeValid) {
      //sendFailedMessages('');
      await emitSendMessage(fileName, base64string, fileType, message, "",
          replyMessageDetails, '');
    } else {
      final customDialog = CustomDialog();
      if (!context.mounted) return;
      customDialog.show(
        context: context,
        type: DialogType.error,
        content: "Please try sending file size less than 2 MB.",
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
        roomId: widget.roomId,
        userId: localUserid,
        appId: appConfig.appId,
        caUid: localCaUid,
        deviceId: deviceId,
        msgBody: msgBody,
        msgBinary: msgBinary,
        msgBinaryType: msgBinaryType,
        replyToId: replyMessageDetails.replyToId,
        messageId: messageId,
        readBy: '',
        status: '',
        statusMsg: '',
        deleted: 0,
        sendDateTime: DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime.now().toLocal())
            .toString(),
        editDateTime: '',
        deleteDateTime: '',
        transtamp: '',
        nickName: nickName,
        filePath: filePath,
        ownerId: localUserid,
        msgStatus: "SENDING",
        clientMessageId: clientMessageId,
        roomName: widget.roomName);
    await dbHelper.saveMsgDetailTable(messageDetails);
    print('StoreFilePath:$filePath');
    if (!context.mounted) return;
    context.read<ChatHistory>().addChatHistory(messageDetail: messageDetails);
    context.read<RoomHistory>().updateRoomMessage(
        roomId: messageDetails.roomId!, message: messageDetails.msgBody!);
    cancelReply();
  }

  Future<void> emitSendMessage(
      String fileName,
      String base64string,
      String msgBinaryType,
      String message,
      String type,
      ReplyMessageDetails replyMessageDetails,
      String clientMessageId) async {
    setState(() {
      _isSendingMessage = true;
    });
    if (message == '') message = fileName;

    if (type == '') {
      clientMessageId = generateRandomString(15);
      await storeMyMessage(
          message, msgBinaryType, base64string, 0, clientMessageId);
    }
    var messageJson = {
      "roomId": widget.roomId,
      "msgBody": message,
      "msgBinaryBuffer": base64string,
      "replyToId": replyMessageDetails.replyToId,
      "msgBinaryType": msgBinaryType,
      "clientMessageId": clientMessageId,
      "misc": "[FCM_Notification=title: $roomName - $localUserName]"
    };
    //print(messageJson);
    if (socket.connected) {
      socket.emitWithAck('sendMessage', messageJson, ack: (data) async {
        //print('sendMessage ack $data');
        if (data != null && !data.containsKey("error")) {
          SendAcknowledge sendAcknowledge = SendAcknowledge.fromJson(data);
          if (sendAcknowledge.messageId > 0) {
            if (mounted && getMessageDetailsList.isNotEmpty) {
              context.read<ChatHistory>().updateChatItemStatus(
                  clientMessageId,
                  "SENT",
                  sendAcknowledge.messageId,
                  widget.roomId,
                  DateFormat("yyyy-MM-dd HH:mm:ss")
                      .format(DateTime.parse(sendAcknowledge.sendDateTime ?? '')
                          .toLocal())
                      .toString());
            }
            await dbHelper.updateMsgDetailTable(
                clientMessageId,
                "SENT",
                sendAcknowledge.messageId,
                DateFormat("yyyy-MM-dd HH:mm:ss")
                    .format(DateTime.parse(sendAcknowledge.sendDateTime ?? '')
                        .toLocal())
                    .toString());
            if (myFailedList.isNotEmpty) {
              int index = myFailedList.indexWhere(
                  (element) => element.clientMessageId == clientMessageId);
              if (index > -1) {
                myFailedList.removeAt(index);
              }
            }
            setState(() {
              _isSendingMessage = false;
            });
          }
          //print('sendMessage from server $data');
        } else {
          //print("Null from sendMessage");
        }
      });
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      itemScrollController.scrollTo(
          index: 0,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    });
  }

  sendFailedMessages(String type) async {
    if (type != '') {
      myFailedList = getMessageDetailsList
          .where((element) =>
              element.roomId == widget.roomId &&
              element.msgStatus == "SENDING" &&
              DateTime.now()
                      .difference(DateTime.parse(element.sendDateTime!))
                      .inMinutes >
                  1)
          .toList();
    } else {
      myFailedList = getMessageDetailsList
          .where((element) =>
              element.roomId == widget.roomId && element.msgStatus == "SENDING")
          .toList();
    }

    if (myFailedList.isNotEmpty) {
      ReplyMessageDetails myreplayList = ReplyMessageDetails(
          binaryType: '',
          msgBody: '',
          replyToId: 0,
          nickName: '',
          filePath: '');
      for (var messageDetails in myFailedList) {
        if (messageDetails.clientMessageId.toString() != '' &&
            localUserid != '') {
          if (messageDetails.replyToId! > 0) {
            List<MessageDetails> replyList = getMessageDetailsList
                .where(
                    (element) => element.messageId == messageDetails.replyToId!)
                .toList();

            myreplayList = ReplyMessageDetails(
                binaryType: replyList[0].msgBinaryType,
                msgBody: replyList[0].msgBody,
                replyToId: replyList[0].replyToId,
                nickName: replyList[0].nickName,
                filePath: replyList[0].filePath);
          }

          if (messageDetails.msgBinaryType == '' ||
              messageDetails.msgBinaryType == 'userLeft' ||
              messageDetails.msgBinaryType == 'userJoined') {
            sendMessage(messageDetails.msgBody!, "FailedMessages", myreplayList,
                messageDetails.clientMessageId!);
          } else {
            var bytes = await File(messageDetails.filePath!).readAsBytes();
            await emitSendMessage(
                messageDetails.filePath!.split('/').last,
                base64.encode(bytes),
                messageDetails.msgBinaryType!,
                messageDetails.msgBody!,
                "FailedMessages",
                myreplayList,
                messageDetails.clientMessageId!);
          }
        }
      }
    }
  }

  onTyping() {
    socket.on('typing', (data) async {
      String? userid = await localStorage.getUserId();
      Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);

      if (result.containsKey("userId") &&
          userid != result["userId"].toString() &&
          widget.roomId == result["roomId"].toString()) {
        List<RoomMembers> roomMembersList =
            await dbHelper.getRoomMemberName(result["userId"].toString());
        if (mounted) {
          setState(() {
            if (roomMembersList.isNotEmpty) {
              members = '${roomMembersList[0].nickName!} Is Typing';
            }
          });
        }
      }
    });
    socket.on('notTyping', (data) async {
      String? userid = await localStorage.getUserId();
      Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
      if (userid != result["userId"].toString() &&
          widget.roomId == result["roomId"].toString()) {
        if (mounted) {
          setState(() {
            members = originalValue;
          });
        }
      }
    });
  }

  sendTyping(String value) {
    var messageJson = {
      "roomId": widget.roomId,
    };
    socket.emit("typing", messageJson);
  }

  sendNotTyping() {
    var messageJson = {
      "roomId": widget.roomId,
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
    return SizedBox(
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
                    const SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                    const SizedBox(
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
            if (!context.mounted) return;
            Navigator.pop(context);
          } else {
            if (!context.mounted) return;
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

          FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              withData: true,
              allowedExtensions: [
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
            if (files.isEmpty) return;

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
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  Future<String> createFolder(String folder) async {
    final dir = Directory(
        '${(Platform.isAndroid ? await getExternalStorageDirectory() //FOR ANDROID
                : await getApplicationSupportDirectory() //FOR IOS
            )!.path}/$folder');
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await dir.exists())) {
      return dir.path;
    } else {
      await dir.create(recursive: true);
      //print(dir.path);
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
      extension = ".${fileName.split('.').last}";
    }
    try {
      Uint8List bytes = base64.decode(base64String);
      final dir = Directory(
          '${(Platform.isAndroid ? await getExternalStorageDirectory() //FOR ANDROID
                  : await getApplicationSupportDirectory() //FOR IOS
              )!.path}/${widget.roomId}/$folder');
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final random = Random().nextInt(10000).toString();

      if ((await dir.exists())) {
        //print(dir.path);
        file = File("${dir.path}/$timestamp$random$extension");
        await file.writeAsBytes(bytes);
      } else {
        await dir.create(recursive: true);
        //print(dir.path);
        file = File("${dir.path}/$timestamp$random$extension");
        await file.writeAsBytes(bytes);
        //return dir.path;
      }
      return file.path;
    } on Exception catch (exception) {
      print(exception);
    } catch (error) {
      //print(error);
    }
    return '';
  }

  Future<void> getFileSize(String path) async {
    final file = File(path);
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb <= 2) {
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
      final status = await Permission.microphone.request();
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
    dirPath = await createFolder('${widget.roomId}/$pathToAudio');
    audioFilPath = '$dirPath/${DateTime.now().millisecondsSinceEpoch}.mp4';

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

    _mRecorder?.setSubscriptionDuration(const Duration(milliseconds: 10));

    _recorderSubscription = _mRecorder?.onProgress!.listen((e) {
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
          emojiSizeMax: 32 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.30
                  : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
          verticalSpacing: 0,
          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          initCategory: Category.RECENT,
          bgColor: const Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          recentTabBehavior: RecentTabBehavior.RECENT,
          recentsLimit: 28,
          noRecents: const Text(
            'No Recents',
            style: TextStyle(fontSize: 20, color: Colors.black26),
            textAlign: TextAlign.center,
          ), // Needs to be const Widget
          loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL,
        ));
  }
}
