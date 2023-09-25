import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatBloc {
  final Socket socket;
  final StreamController<String> _textFieldCtrl = BehaviorSubject();
  final StreamController<bool> _submitBtnCtrl = BehaviorSubject();
  final StreamController<String?> _chatItemsCtrl = BehaviorSubject();

  ChatBloc(this.socket) {
    _textFieldCtrl.stream.listen((value) {
      _submitBtnCtrl.sink.add(value.isNotEmpty);
    });
    socket.connect();

    socket.on('connect_error', (value) {
      // handle
    });

    socket.on('chat message', (value) {
      _chatItemsCtrl.sink.add(value);
    });
  }

  sendMessage(String message) {
    socket.emit('chat message', message);
  }

  sendMessage2(String message) {
    socket.emit('test', message);
  }

  disconnect(String message) {
    socket.emit('disconnect', message);
  }

  joinRoom(String message) {
    socket.emit('join room', '123');
  }

  Stream<bool> get submitButtonStream => _submitBtnCtrl.stream;
  Stream<String?> get chatItemsStream => _chatItemsCtrl.stream;
  void onTextValueChange(String value) => _textFieldCtrl.sink.add(value);

  void dispose() {
    _textFieldCtrl.close();
    _submitBtnCtrl.close();
    _chatItemsCtrl.close();
  }
}
