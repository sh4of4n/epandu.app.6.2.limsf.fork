import 'package:epandu/services/repository/chat_repository.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketHelper {
  final LocalStorage localStorage = LocalStorage();
  final chatRepo = ChatRepo();
  Socket _socket;

  Future<Socket> get socket async {
    if (_socket != null) {
      return _socket;
    }
    _socket = await initSocket();
    return _socket;
  }

  initSocket() async {
    String userId = await localStorage.getUserId();
    _socket = io('http://fancationswipe.ddns.net:8086', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': 'userId=$userId'
    });
    _socket.connect();
    return _socket;
  }
}
