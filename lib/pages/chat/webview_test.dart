import 'dart:async';
import 'dart:io' show Platform;
import 'package:auto_route/auto_route.dart';
import 'package:epandu/pages/home/navigation_controls.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';
import 'package:epandu/common_library/services/model/provider_model.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import '../../common_library/services/model/createroom_response.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/database_helper.dart';
import '../../services/repository/chatroom_repository.dart';
import 'chat_home.dart';
import 'socketclient_helper.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class TestWebview extends StatefulWidget {
  final String? url;
  final String? backType;

  const TestWebview({super.key, required this.url, this.backType});

  @override
  State<TestWebview> createState() => _TestWebviewState();
}

WebViewController? controllerGlobal;

Future<bool> _onWillPop(
    {required BuildContext context, backType, customDialog}) async {
  // Provider.of<CallStatusModel>(context, listen: false).callStatus(false);
  if (backType == 'HOME') {
    _confirmBack(customDialog, context);

    return true;
  } else {
    if (await controllerGlobal!.canGoBack()) {
      controllerGlobal!.goBack();
    } else {
      if (!context.mounted) return false;
      // _confirmBack(customDialog, context);
      Provider.of<CallStatusModel>(context, listen: false).callStatus(false);
      return true;
    }

    return Future.value(false);
  }
}

_confirmBack(customDialog, BuildContext context) {
  return customDialog.show(
    context: context,
    content: AppLocalizations.of(context)!.translate('confirm_back'),
    customActions: <Widget>[
      TextButton(
          child: Text(AppLocalizations.of(context)!.translate('yes_lbl')),
          onPressed: () {
            Provider.of<CallStatusModel>(context, listen: false)
                .callStatus(false);
            context.router.popUntil(
              ModalRoute.withName('Home'),
            );
          }),
      TextButton(
        child: Text(AppLocalizations.of(context)!.translate('no_lbl')),
        onPressed: () {
          context.router.pop();
        },
      ),
    ],
    type: DialogType.general,
  );
}

class _TestWebviewState extends State<TestWebview> {
  late final WebViewController _controller;
  late io.Socket socket;
  final chatRoomRepo = ChatRoomRepo();
  final localStorage = LocalStorage();
  final dbHelper = DatabaseHelper.instance;
  final myImage = ImagesConstant();
  final customDialog = CustomDialog();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final getSocket = Provider.of<SocketClientHelper>(context, listen: false);
      socket = getSocket.socket;
    });
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'messageHandler',
        onMessageReceived: (JavaScriptMessage message) async {
          print(message.message.toString());
          var createChatSupportResult = await chatRoomRepo
              .createChatSupportByMemberFromWebView(message.message.toString());
          if (createChatSupportResult.data != null &&
              createChatSupportResult.data.length > 0) {
            if (!context.mounted) return;
            await context.read<SocketClientHelper>().loginUserRoom();
            String userid = await localStorage.getUserId() ?? '';
            CreateRoomResponse getCreateRoomResponse =
                createChatSupportResult.data[0];

            List<RoomMembers> roomMembers = await dbHelper
                .getRoomMembersList(getCreateRoomResponse.roomId!);
            for (var roomMember in roomMembers) {
              if (userid != roomMember.userId) {
                var inviteUserToRoomJson = {
                  "invitedRoomId": getCreateRoomResponse.roomId!,
                  "invitedUserId": roomMember.userId
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
            }
            if (!context.mounted) return;
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

            //context.router.push(RoomList());
          } else {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(createChatSupportResult.message!)),
            );
          }
        },
      )
      ..loadRequest(Uri.parse(widget.url!));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  getBackType() {
    if (widget.backType == 'HOME') {
      return IconButton(
        icon: Platform.isIOS
            ? const Icon(Icons.arrow_back_ios)
            : const Icon(Icons.arrow_back),
        onPressed: () {
          _confirmBack(customDialog, context);
        },
      );
    } else if (widget.backType == 'DI_ENROLLMENT') {
      return IconButton(
        icon: Platform.isIOS
            ? const Icon(Icons.arrow_back_ios)
            : const Icon(Icons.arrow_back),
        onPressed: () =>
            context.router.popUntil(ModalRoute.withName('DiEnrollment')),
      );
    } else {
      return NavigationControls(
        webViewControllerFuture: _controller,
        type: 'BACK',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(
        context: context,
        backType: widget.backType,
        customDialog: customDialog,
      ),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: FadeInImage(
            alignment: Alignment.center,
            height: 110.h,
            placeholder: MemoryImage(kTransparentImage),
            image: AssetImage(
              myImage.logo2,
            ),
          ),
          actions: <Widget>[
            NavigationControls(
                webViewControllerFuture: _controller, type: 'RELOAD'),
          ],
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
