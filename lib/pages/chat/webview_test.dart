import 'package:auto_route/auto_route.dart';
import 'package:epandu/pages/chat/socketclient_helper.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

import '../../common_library/services/model/createroom_response.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/utils/local_storage.dart';
import '../../router.gr.dart';
import '../../services/database/DatabaseHelper.dart';
import '../../services/repository/chatroom_repository.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'chat_home.dart';

class TestWebview extends StatefulWidget {
  const TestWebview({super.key});

  @override
  State<TestWebview> createState() => _TestWebviewState();
}

class _TestWebviewState extends State<TestWebview> {
  late final WebViewController _controller;
  late IO.Socket socket;
  final chatRoomRepo = ChatRoomRepo();
  final localStorage = LocalStorage();
  final dbHelper = DatabaseHelper.instance;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final getSocket = Provider.of<SocketClientHelper>(context, listen: false);
      socket = getSocket.socket;
    });

    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(
                'https://tbsweb.tbsdns.com/Tbs.Chat.Client.Web/DEVP/1_0/testwebview.html')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'messageHandler',
        onMessageReceived: (JavaScriptMessage message) async {
          var createChatSupportResult = await chatRoomRepo
              .createChatSupportByMemberFromWebView(message.message.toString());
          if (createChatSupportResult.data != null &&
              createChatSupportResult.data.length > 0) {
            await context.read<SocketClientHelper>().loginUserRoom();
            String userid = await localStorage.getUserId() ?? '';
            CreateRoomResponse getCreateRoomResponse =
                createChatSupportResult.data[0];

            List<RoomMembers> roomMembers = await dbHelper
                .getRoomMembersList(getCreateRoomResponse.roomId!);
            roomMembers.forEach((roomMember) {
              if (userid != roomMember.user_id) {
                var inviteUserToRoomJson = {
                  "invitedRoomId": getCreateRoomResponse.roomId!,
                  "invitedUserId": roomMember.user_id
                };
                socket.emitWithAck('inviteUserToRoom', inviteUserToRoomJson,
                    ack: (data) {
                  if (data != null) {
                    print('inviteUserToRoomJson from server $data');
                  } else {
                    print("Null from inviteUserToRoomJson");
                  }
                });
              }
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatHome2(
                  roomId: getCreateRoomResponse.roomId!,
                  picturePath: '',
                  roomName: getCreateRoomResponse.roomName!,
                  roomDesc: getCreateRoomResponse.roomDesc!,
                ),
              ),
            );
            //print(message.message.toString());
            //context.router.push(RoomList());
          }
        },
      )
      ..loadRequest(Uri.parse(
          'https://tbsweb.tbsdns.com/Tbs.Chat.Client.Web/DEVP/1_0/testwebview.html'));

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
