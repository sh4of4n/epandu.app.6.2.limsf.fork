import 'package:epandu/pages/chat/chat_bloc.dart';
import 'package:epandu/pages/chat/chat_sqlCRUD.dart';
import 'package:flutter/material.dart';
import 'package:epandu/services/api/model/chat_model.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function onPressedSend;
  final Function onPressedAttach;
  final Function onPressedVoice;
  final Function onShowBottom;
  final List<Message> messageList;
  final String selfId;
  final String targetId;
  final FocusNode focusNode;

  MessageInput(
      {@required this.textEditingController,
      this.onPressedSend,
      this.onPressedAttach,
      this.onPressedVoice,
      this.onShowBottom,
      this.selfId,
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
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 5,
                              color: Colors.grey)
                        ],
                      ),
                      child: Row(
                        children: [
                          IconButton(icon: Icon(Icons.face), onPressed: () {}),
                          Expanded(
                            child: TextFormField(
                              maxLines: null,
                              controller: _textEditingController,
                              decoration: InputDecoration(
                                  hintText: "Type Something...",
                                  border: InputBorder.none),
                              onChanged: (value) {
                                if (value.length > 0) {
                                  bloc.onTextValueChange(value);

                                  setState(() {
                                    this._isTyping = true;
                                  });
                                } else if (value.length == 0) {
                                  bloc.onTextValueChange(value);
                                  setState(() {
                                    this._isTyping = false;
                                  });
                                }
                              },
                              focusNode: widget.focusNode,
                            ),
                          ),
                          Visibility(
                            visible: _isTyping == true ? false : true,
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
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    child: _isTyping == true
                        ? StreamProvider.value(
                            // default disable button
                            initialData: false,
                            value: bloc.submitButtonStream,
                            child: Consumer<bool>(
                              builder: (ctx, isEnable, _) => InkWell(
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                onTap: isEnable
                                    ? () {
                                        _sendMessage(widget.selfId,
                                            widget.targetId, bloc);
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
                            onLongPress: widget.onShowBottom),
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
    if (value1 > 0 && value2 > 0) {
      print("data insert success");
      widget.messageList.add(message);
      _textEditingController.clear();
      widget.onPressedSend();
      widget.focusNode.requestFocus();
    } else {
      print("data insert fail");
    }

    setState(() {
      this._isTyping = false;
    });
  }
}
