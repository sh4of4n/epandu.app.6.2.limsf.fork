import 'dart:async';
import 'dart:convert';

import 'package:epandu/pages/chat/chat_bloc.dart';
import 'package:epandu/services/database/chat_db.dart';
import 'package:epandu/pages/chat/message_item.dart';
import 'package:epandu/pages/chat/socket_helper.dart';
import 'package:epandu/common_library/services/model/profile_model.dart';
import 'package:epandu/common_library/services/repository/meeting_repository.dart';
import 'package:epandu/common_library/services/repository/profile_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socket_io_client/socket_io_client.dart';

// import 'package:epandu/pages/chat/message_input.dart';
import 'package:epandu/common_library/services/model/chat_model.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  final String? targetId;
  final String? picturePath;
  final String? name;

  const ChatScreen({super.key, this.targetId, this.picturePath, this.name});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User user = User();
  final LocalStorage localStorage = LocalStorage();
  final chatRepo = ChatRepo();
  final profileRepo = ProfileRepo();
  Socket? socket;

  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  final webinarRepo = ChatRepo();
  int _startIndex = 0;
  // String _message = '';
  String? userId;
  UserProfile? messageTargetProfile;
  final image = ImagesConstant();
  bool ableToLoad = true;
  FocusNode? focusNode;
  bool invertedFlag = true;
  bool _isTyping = false;

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  @override
  void initState() {
    _getMessages();
    _getUserId();
    _getMessageTargetProfile();
    initSocketIO();
    focusNode = FocusNode();

    _scrollController.addListener(() {
      if (messages.length > 25) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _startIndex += 10;
          });
          _getMessages();
        }
      }
    });
    super.initState();
  }

  final TextEditingController _textEditingController =
      TextEditingController();

  List<Message> messages = [];
  List<String> messageDuplicationIdentifier = [];

  _getUserId() async {
    String? userId = await localStorage.getUserId();
    setState(() {
      this.userId = userId;
    });
  }

  _getMessages() async {
    print("get Message");
    String? userId = await localStorage.getUserId();

    messages.insertAll(
        0,
        await ChatDatabase().getMessageAndAuthorTable(
            userId: userId,
            targetId: widget.targetId,
            startIndex: _startIndex,
            noOfRecords: 10));
    if (messages.length < 20) {
      setState(() {
        invertedFlag = false;
      });
    }
    _scrollToBottom(100);
  }

  Future<bool> _addMessagesIntoDB(Message message) async {
    var uuid = const Uuid();
    String messageTargetTableId = uuid.v4();
    MessageAndAuthorTable messageAndAuthorTable = MessageAndAuthorTable(
        id: message.id,
        author: message.author,
        data: message.data,
        sentDateTime: message.sentDateTime,
        type: message.type,
        isSeen: message.isSeen);
    MessageTargetTable messageTargetTable = MessageTargetTable(
        id: messageTargetTableId,
        messageId: message.id,
        targetId: message.target);

    int value1 =
        await ChatDatabase().saveMessageAndAuthorTable(messageAndAuthorTable);
    int value2 =
        await ChatDatabase().saveMessageTargetTable(messageTargetTable);
    if (value1 > 0 && value2 > 0) {
      // print("data insert success");
      return true;
    } else {
      // print("data insert fail");

      return false;
    }
  }

  /* _addMessageIntoMessagesArray(Message message) {
    messages.add(message);
  } */

  _getMessageTargetProfile() async {
    var result = await profileRepo.getUserProfile(
        context: context, customUserId: widget.targetId);

    if (result.isSuccess) {
      if (result.data.length > 0) if (mounted) {
        setState(() {
          for (int i = 0; i < result.data.length; i += 1) {
            //print(result.data[i].meetingDate);
            messageTargetProfile = result.data[i];
          }
        });
      } else if (mounted)
        setState(() {
          _isLoading = false;
        });
    } else {
      if (mounted) {
        setState(() {
          // _message = result.message;
          _isLoading = false;
        });
      }
    }
  }

  initSocketIO() async {
    String userId = await (localStorage.getUserId() as FutureOr<String>);
    String combinedID = "$userId,${widget.targetId!}";
    // print(combinedID);
    setState(() {
      SocketHelper().socket.then((value) {
        socket = value;
        socket!.emit("initChatScreen", combinedID);
      });
    });

    print("connected");
  }

  @override
  Widget build(BuildContext context) {
    // print('1 ${messages.length}');

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black54),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
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
                child: CircleAvatar(
                  child: _circleImage(),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.name!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.clip,
                  ),
                ],
              )
            ],
          ),
        ),
        body: Provider.value(
          value: socket,
          child: ProxyProvider<Socket, ChatBloc>(
            update: (context, socket, previousBloc) {
              return ChatBloc(Provider.of<Socket>(context));
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(80.w, 50.h, 80.w, 50.h),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Consumer<ChatBloc>(
                      builder: (context, bloc, _) => StreamProvider.value(
                        initialData: null,
                        value: bloc.chatItemsStream,
                        child: Consumer<String>(
                          builder: (context, msg, _) {
                            // print("message receive call");

                            Message message = Message.fromJson(jsonDecode(msg));
                            if ((message.target == userId &&
                                    message.author == widget.targetId) ||
                                (message.target == widget.targetId &&
                                    message.author == userId)) {
                              if (messageDuplicationIdentifier.contains(msg)) {
                                print("meesges existed$msg");
                              } else if (message.author == widget.targetId) {
                                socket!.emit("acknowledgementReceive", msg);

                                messages.add(message);
                                messageDuplicationIdentifier.add(msg);
                                _addMessagesIntoDB(message).then((value) {
                                  if (value == true) {
                                    // print('2 ${messages.length}');
                                    _scrollToBottom(100);
                                  }
                                });
                              } else {
                                messageDuplicationIdentifier.add(msg);

                                messages.add(message);
                                _scrollToBottom(100);
                              }
                            }
                            // print('3 ${messages.length}');

                            return SingleChildScrollView(
                              reverse: invertedFlag,
                              controller: _scrollController,
                              child: Column(
                                children: <Widget>[
                                  _messageList(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Consumer<ChatBloc>(
                    builder: (ctx, bloc, _) => Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(35.0),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 5,
                                      color: Colors.grey)
                                ],
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.face), onPressed: () {}),
                                  Expanded(
                                    child: TextFormField(
                                      onTap: () {
                                        _scrollToBottom(750);
                                      },
                                      maxLines: null,
                                      controller: _textEditingController,
                                      decoration: const InputDecoration(
                                          hintText: "Type Something...",
                                          border: InputBorder.none),
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          bloc.onTextValueChange(value);

                                          setState(() {
                                            _isTyping = true;
                                          });
                                        } else if (value.isEmpty) {
                                          bloc.onTextValueChange(value);
                                          setState(() {
                                            _isTyping = false;
                                          });
                                        }
                                      },
                                      focusNode: focusNode,
                                    ),
                                  ),
                                  Visibility(
                                    visible: _isTyping == true ? false : true,
                                    child: IconButton(
                                      icon: const Icon(Icons.photo_camera),
                                      onPressed: () {},
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.attach_file),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            decoration: const BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                            child: _isTyping == true
                                ? StreamProvider.value(
                                    // default disable button
                                    initialData: false,
                                    value: bloc.submitButtonStream,
                                    child: Consumer<bool>(
                                      builder: (ctx, isEnable, _) => InkWell(
                                        onTap: isEnable
                                            ? () {
                                                _sendMessage(userId,
                                                    widget.targetId, bloc);
                                              }
                                            : null,
                                        child: const Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : const InkWell(
                                    child: Icon(
                                      Icons.keyboard_voice,
                                      color: Colors.white,
                                    ),
                                    //onLongPress: widget.onShowBottom
                                  ),
                          ),
                        ],
                      ),
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

  _circleImage() {
    if (widget.picturePath != null && widget.picturePath!.isNotEmpty) {
      return Image.network(
          widget.picturePath!.replaceAll(removeBracket, '').split('\r\n')[0]);
    }
    return Image.memory(kTransparentImage);
  }

  /* void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Center(
          child: Container(
            height: 1500.h,
            child: Center(
              child: new Row(
                children: <Widget>[
                  TextButton(
                      onPressed: null,
                      child: Container(
                          child: Column(
                        children: <Widget>[Icon(Icons.image), Text("image")],
                      ))),
                  TextButton(
                    onPressed: null,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.video_library),
                          Text("video")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  } */

  _messageList() {
    if (messages.isEmpty && messages.isNotEmpty) {
      return Center(
          child: Container(
              child: const Align(
        alignment: Alignment.center,
        child: Text("Empty Message"),
      )));
    } else if (messages.isNotEmpty) {
      return Column(
        children: <Widget>[
          for (int i = 0; i < messages.length; i++)
            i > 0
                ? MessageItem(
                    message: messages[i],
                    previousItemDate: messages[i - 1].sentDateTime,
                    userId: userId,
                    scrollController: _scrollController)
                : MessageItem(
                    message: messages[i],
                    previousItemDate: 0,
                    userId: userId,
                    scrollController: _scrollController),
          if (_isLoading)
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.white,
              child: Container(
                width: ScreenUtil().setWidth(1400),
                height: ScreenUtil().setHeight(600),
                color: Colors.grey[300],
              ),
            ),
        ],
      );
    }
    return Center(
      child: Container(
        child: const Align(
          alignment: Alignment.center,
          child: Text("Empty Message"),
        ),
      ),
    );
  }

  Future<void> _sendMessage(
      String? author, String? target, ChatBloc bloc) async {
    final messageContent = _textEditingController.text;
    var uuid = const Uuid();
    String messageId = uuid.v4();

    DateTime parsedDate = DateTime.now();
    int timeStamp = parsedDate.toUtc().millisecondsSinceEpoch;
/*
    MessageBody messageBody = MessageBody(
        data: messageContent,
        sentDateTime: DateTime.now().toString(),
        type: "text",
        isSeen: "false"); */
    final Message message = Message(
        id: messageId,
        author: author,
        target: target,
        data: messageContent,
        sentDateTime: timeStamp,
        type: "text",
        isSeen: "false");
    final jsonMessage = jsonEncode(message);
    print(jsonDecode(jsonMessage));

    bloc.sendMessage(jsonMessage);
    String messageTargetTableId = uuid.v1();
    MessageAndAuthorTable messageAndAuthorTable = MessageAndAuthorTable(
        id: message.id,
        author: message.author,
        data: message.data,
        sentDateTime: message.sentDateTime,
        type: message.type,
        isSeen: message.isSeen);
    MessageTargetTable messageTargetTable = MessageTargetTable(
        id: messageTargetTableId,
        messageId: message.id,
        targetId: message.target);

    int value1 =
        await ChatDatabase().saveMessageAndAuthorTable(messageAndAuthorTable);
    int value2 =
        await ChatDatabase().saveMessageTargetTable(messageTargetTable);

    setState(() {
      if (value1 > 0 && value2 > 0) {
        print("data insert success");
        messages.add(message);
        _textEditingController.clear();
        focusNode!.requestFocus();
        _isTyping = false;
        _scrollToBottom(100);
      } else {
        print("data insert fail");
        _isTyping = false;
      }
    });
  }

  _scrollToBottom(int interval) {
    Timer(Duration(milliseconds: interval), () {
      if (invertedFlag == true) {
        _scrollController.animateTo(0.0,
            curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
      } else {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
      }
    });
  }

  @override
  void dispose() {
    //socket.on('disconnect', (_) => print('disconnect'));
    // String combinedId = userId + "," + widget.targetId;
    // socket.emit("cancelConnection", combinedId);
    // print("dispose " + combinedId);
    messages.clear();
    socket!.disconnect();
    socket!.destroy();
    focusNode!.dispose();

    super.dispose();
  }

  void onPressSend() {
    setState(() {
      _scrollToBottom(100);
    });
  }
}
