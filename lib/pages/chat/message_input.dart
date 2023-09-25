import 'package:epandu/pages/chat/chat_bloc.dart';
import 'package:epandu/services/database/chat_db.dart';
import 'package:flutter/material.dart';
import 'package:epandu/common_library/services/model/chat_model.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function? onPressedSend;
  final Function? onPressedAttach;
  final Function? onPressedVoice;
  final Function? onShowBottom;
  final List<Message>? messageList;
  final String? userId;
  final String? targetId;
  final FocusNode? focusNode;

  const MessageInput(
      {super.key, required this.textEditingController,
      this.onPressedSend,
      this.onPressedAttach,
      this.onPressedVoice,
      this.onShowBottom,
      this.userId,
      this.targetId,
      this.messageList,
      this.focusNode});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  bool _isTyping = false;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatBloc>(
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
                          IconButton(icon: const Icon(Icons.face), onPressed: () {}),
                          Expanded(
                            child: TextFormField(
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
                              focusNode: widget.focusNode,
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
                                        _sendMessage(widget.userId,
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
                        : InkWell(
                            onLongPress:
                                widget.onShowBottom as void Function()?,
                            child: const Icon(
                              Icons.keyboard_voice,
                              color: Colors.white,
                            )),
                  )
                ],
              ),
            ));

/*      
      Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Message',
                hintText: 'Type here...',
              ),
              onChanged: (value) {
                bloc.onTextValueChange(value);
              },
              focusNode: focusNode,
              controller: _textEditCtrl,
            ),
          ),
          StreamProvider.value(
            // default disable button
            initialData: false,
            value: bloc.submitButtonStream,
            child: Consumer<bool>(
              builder: (ctx, isEnable, _) => RaisedButton(
                onPressed: isEnable
                    ? () {
                        bloc.sendMessage(_textEditCtrl.text);
                        focusNode.unfocus();
                        _textEditCtrl.clear();
                      }
                    : null,
                child: Icon(Icons.send),
              ),
            ),
          ),
        ],
      ),
    );

   return Container(
      child: Row(
        children: <Widget>[
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                maxLines: null,
                style: TextStyle(color: Colors.black54, fontSize: 70.0.sp),
                controller: widget.textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: widget.onPressedSend,
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          // Button send image
          Material(
            child: Container(
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: widget.onPressedAttach,
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: Container(
              child: IconButton(
                icon: Icon(Icons.face),
                onPressed: widget.onPressedAttach,
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black38, width: 0.5)),
          color: Colors.white),
    );*/
    //D641BDE2C7
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
    if (value1 > 0 && value2 > 0) {
      print("data insert success");
      widget.messageList!.add(message);
      _textEditingController.clear();
      widget.onPressedSend!();
      widget.focusNode!.requestFocus();
    } else {
      print("data insert fail");
    }

    setState(() {
      _isTyping = false;
    });
  }
}
