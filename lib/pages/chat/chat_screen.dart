import 'dart:async';
import 'dart:convert';

import 'package:epandu/pages/chat/chat_bloc.dart';
import 'package:epandu/pages/chat/chat_sqlCRUD.dart';
import 'package:epandu/pages/chat/message_item.dart';
import 'package:epandu/pages/chat/socket_helper.dart';
import 'package:epandu/services/api/model/profile_model.dart';
import 'package:epandu/services/repository/chat_repository.dart';
import 'package:epandu/services/repository/profile_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socket_io_client/socket_io_client.dart';

// import 'package:epandu/pages/chat/message_input.dart';
import 'package:epandu/services/api/model/chat_model.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  final String targetId;
  final String picturePath;
  final String name;

  ChatScreen({this.targetId, this.picturePath, this.name});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User user = User();
  final LocalStorage localStorage = LocalStorage();
  final chatRepo = ChatRepo();
  final profileRepo = ProfileRepo();
  Socket socket;

  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;
  final webinarRepo = ChatRepo();
  int _startIndex = 0;
  String _message = '';
  String selfId;
  UserProfile messageTargetProfile;
  final image = ImagesConstant();
  bool ableToLoad = true;
  FocusNode focusNode;
  bool invertedFlag = true;
  bool _isTyping = false;

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  @override
  void initState() {
    _getMessages();
    _setSelfId();
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
      new TextEditingController();

  List<Message> messages = [];
  List<String> messageDuplicationIdentifier = [];

  _setSelfId() async {
    String userId = await localStorage.getUserId();
    setState(() {
      this.selfId = userId;
    });
  }

  _getMessages() async {
    print("get Message");
    String userId = await localStorage.getUserId();

    messages.insertAll(
        0,
        await DBHelper().getMessagesTable1(
            selfId: userId,
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
    var uuid = Uuid();
    String messageTargetTableId = uuid.v4();
    MessageAndAuthorTable messageAndAuthorTable = new MessageAndAuthorTable(
        id: message.id,
        author: message.author,
        data: message.data,
        sentDateTime: message.sentDateTime,
        type: message.type,
        isSeen: message.isSeen);
    MessageTargetTable messageTargetTable = new MessageTargetTable(
        id: messageTargetTableId,
        messageId: message.id,
        targetId: message.target);

    int value1 = await DBHelper().saveTable1(messageAndAuthorTable);
    int value2 = await DBHelper().saveTable2(messageTargetTable);
    if (value1 > 0 && value2 > 0) {
      print("data insert success");
      return true;
    } else {
      print("data insert fail");

      return false;
    }
  }

  _addMessageIntoMessagesArray(Message message) {
    messages.add(message);
  }

  _getMessageTargetProfile() async {
    var result = await profileRepo.getUserProfile(
        context: context, userId: widget.targetId);

    if (result.isSuccess) {
      if (result.data.length > 0) if (mounted)
        setState(() {
          for (int i = 0; i < result.data.length; i += 1) {
            //print(result.data[i].meetingDate);
            messageTargetProfile = result.data[i];
          }
        });
      else if (mounted)
        setState(() {
          _isLoading = false;
        });
    } else {
      if (mounted)
        setState(() {
          _message = result.message;
          _isLoading = false;
        });
    }
  }

  initSocketIO() async {
    String userId = await localStorage.getUserId();
    String combinedID = userId + "," + widget.targetId;
    print(combinedID);
    setState(() {
      SocketHelper().socket.then((value) {
        socket = value;
        socket.emit("initChatScreen", combinedID);
      });
    });

    print("connected");
  }

  @override
  Widget build(BuildContext context) {
    print('1 ${messages.length}');

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
            iconTheme: IconThemeData(color: Colors.black54),
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
                          offset: Offset(0, 2),
                          blurRadius: 5)
                    ],
                  ),
                  child: CircleAvatar(
                    child: _circleImage(),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style: Theme.of(context).textTheme.bodyText2,
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
                                print("message receive call");

                                if (msg != null) {
                                  Message message =
                                      Message.fromJson(jsonDecode(msg));
                                  if ((message.target == selfId &&
                                          message.author == widget.targetId) ||
                                      (message.target == widget.targetId &&
                                          message.author == selfId)) {
                                    if (messageDuplicationIdentifier
                                        .contains(msg)) {
                                      print("meesges existed" + msg);
                                    } else if (message.author ==
                                        widget.targetId) {
                                      socket.emit(
                                          "acknowledgementReceive", msg);

                                      messages.add(message);
                                      messageDuplicationIdentifier.add(msg);
                                      _addMessagesIntoDB(message).then((value) {
                                        if (value == true) {
                                          print('2 ${messages.length}');
                                          _scrollToBottom(100);
                                        }
                                      });
                                    } else {
                                      messageDuplicationIdentifier.add(msg);

                                      messages.add(message);
                                      _scrollToBottom(100);
                                    }
                                  }
                                }
                                print('3 ${messages.length}');

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
                                          borderRadius:
                                              BorderRadius.circular(35.0),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 3),
                                                blurRadius: 5,
                                                color: Colors.grey)
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.face),
                                                onPressed: () {}),
                                            Expanded(
                                              child: TextFormField(
                                                onTap: () {
                                                  _scrollToBottom(750);
                                                },
                                                maxLines: null,
                                                controller:
                                                    _textEditingController,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Type Something...",
                                                    border: InputBorder.none),
                                                onChanged: (value) {
                                                  if (value.length > 0) {
                                                    bloc.onTextValueChange(
                                                        value);

                                                    setState(() {
                                                      this._isTyping = true;
                                                    });
                                                  } else if (value.length ==
                                                      0) {
                                                    bloc.onTextValueChange(
                                                        value);
                                                    setState(() {
                                                      this._isTyping = false;
                                                    });
                                                  }
                                                },
                                                focusNode: focusNode,
                                              ),
                                            ),
                                            Visibility(
                                              visible: _isTyping == true
                                                  ? false
                                                  : true,
                                              child: IconButton(
                                                icon: Icon(Icons.photo_camera),
                                                onPressed: () {},
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.attach_file),
                                              onPressed: () {},
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle),
                                      child: _isTyping == true
                                          ? StreamProvider.value(
                                              // default disable button
                                              initialData: false,
                                              value: bloc.submitButtonStream,
                                              child: Consumer<bool>(
                                                builder: (ctx, isEnable, _) =>
                                                    InkWell(
                                                  child: Icon(
                                                    Icons.send,
                                                    color: Colors.white,
                                                  ),
                                                  onTap: isEnable
                                                      ? () {
                                                          _sendMessage(
                                                              selfId,
                                                              widget.targetId,
                                                              bloc);
                                                        }
                                                      : null,
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              child: Icon(
                                                Icons.keyboard_voice,
                                                color: Colors.white,
                                              ),
                                              //onLongPress: widget.onShowBottom
                                            ),
                                    )
                                  ],
                                ),
                              ))
                    ],
                  ),
                ),
              ))),
    );
  }

  _circleImage() {
    if (widget.picturePath != null && widget.picturePath.isNotEmpty)
      return Image.network(
          widget.picturePath.replaceAll(removeBracket, '').split('\r\n')[0]);
    return Image.memory(kTransparentImage);
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Center(
              child: Container(
            height: 1500.h,
            child: Center(
                child: new Row(children: <Widget>[
              FlatButton(
                  onPressed: null,
                  child: Container(
                      child: Column(
                    children: <Widget>[Icon(Icons.image), Text("image")],
                  ))),
              FlatButton(
                  onPressed: null,
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Icon(Icons.video_library),
                      Text("video")
                    ],
                  ))),
            ])),
          ));
        });
  }

  _messageList() {
    if (messages.length == 0 && messages.isNotEmpty) {
      return Center(
          child: Container(
              child: Align(
        alignment: Alignment.center,
        child: Text("Empty Message"),
      )));
    } else if (messages.length > 0) {
      return Column(
        children: <Widget>[
          for (int i = 0; i < messages.length; i++)
            i > 0
                ? MessageItem(
                    message: messages[i],
                    previousItemDate: messages[i - 1].sentDateTime,
                    selfId: selfId,
                    scrollController: _scrollController)
                : MessageItem(
                    message: messages[i],
                    previousItemDate: 0,
                    selfId: selfId,
                    scrollController: _scrollController),
          if (_isLoading)
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
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
            child: Align(
      alignment: Alignment.center,
      child: Text("Empty Message"),
    )));
  }

  Future<void> _sendMessage(String author, String target, ChatBloc bloc) async {
    final messageContent = _textEditingController.text;
    var uuid = Uuid();
    String messageId = uuid.v4();

    DateTime parsedDate = DateTime.now();
    int timeStamp = parsedDate.toUtc().millisecondsSinceEpoch;
/*
    MessageBody messageBody = MessageBody(
        data: messageContent,
        sentDateTime: DateTime.now().toString(),
        type: "text",
        isSeen: "false"); */
    final Message message = new Message(
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
    MessageAndAuthorTable messageAndAuthorTable = new MessageAndAuthorTable(
        id: message.id,
        author: message.author,
        data: message.data,
        sentDateTime: message.sentDateTime,
        type: message.type,
        isSeen: message.isSeen);
    MessageTargetTable messageTargetTable = new MessageTargetTable(
        id: messageTargetTableId,
        messageId: message.id,
        targetId: message.target);

    int value1 = await DBHelper().saveTable1(messageAndAuthorTable);
    int value2 = await DBHelper().saveTable2(messageTargetTable);

    setState(() {
      if (value1 > 0 && value2 > 0) {
        print("data insert success");
        messages.add(message);
        _textEditingController.clear();
        focusNode.requestFocus();
        this._isTyping = false;
        _scrollToBottom(100);
      } else {
        print("data insert fail");
        this._isTyping = false;
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
    String combinedId = selfId + "," + widget.targetId;
    socket.emit("cancelConnection", combinedId);
    print("dispose " + combinedId);
    messages.clear();
    socket.disconnect();
    socket.destroy();
    focusNode.dispose();

    super.dispose();
  }

  void onPressSend() {
    setState(() {
      _scrollToBottom(100);
    });
  }
}
