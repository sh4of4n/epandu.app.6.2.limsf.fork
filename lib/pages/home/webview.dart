import 'dart:async';
import 'dart:io' show File, Platform;

import 'package:auto_route/auto_route.dart';
import 'package:epandu/pages/home/navigation_controls.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
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
import '../chat/chat_room.dart';
import '../chat/socketclient_helper.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

// import '../../router.gr.dart';

@RoutePage(name: 'Webview')
class Webview extends StatefulWidget {
  final String? url;
  final String? backType;

  const Webview({super.key, required this.url, this.backType});

  @override
  State<Webview> createState() => _WebviewState();
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

class _WebviewState extends State<Webview> {
  late final WebViewController _controller;
  final myImage = ImagesConstant();
  final customDialog = CustomDialog();
  final chatRoomRepo = ChatRoomRepo();
  final localStorage = LocalStorage();

  final dbHelper = DatabaseHelper.instance;

  late io.Socket socket;

  String? _message = '';

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
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) async {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   debugPrint('blocking navigation to ${request.url}');
            //   return NavigationDecision.prevent;
            // }
            if (request.url.contains('tel:')) {
              var phoneNo = request.url.replaceAll("tel:", "");
              final Uri telLaunchUri = Uri(
                scheme: 'tel',
                path: phoneNo,
              );
              launchUrl(telLaunchUri);
              // context.router.pop();
              return NavigationDecision.prevent;
            }
            if (request.url.contains('map:')) {
              // Extract the latitude and longitude values
              RegExp latRegex = RegExp(r'lat=(-?\d+\.\d+)');
              Match? latMatch = latRegex.firstMatch(request.url);
              String? lat = latMatch?.group(1);

              RegExp lngRegex = RegExp(r'lng=(-?\d+\.\d+)');
              Match? lngMatch = lngRegex.firstMatch(request.url);
              String? lng = lngMatch?.group(1);

              final availableMaps = await MapLauncher.installedMaps;
              if (!context.mounted) return NavigationDecision.prevent;
              showModalBottomSheet(
                context: context,
                builder: (BuildContext dialogContext) {
                  return SafeArea(
                    child: Wrap(
                      children: <Widget>[
                        for (var map in availableMaps)
                          ListTile(
                            onTap: () async {
                              final currentContext = dialogContext;
                              await map.showDirections(
                                destination: Coords(
                                  double.parse(lat!),
                                  double.parse(lng!),
                                ),
                              );
                              if (!currentContext.mounted) return;
                              currentContext.router.pop();
                            },
                            title: Text(map.mapName),
                            leading: SvgPicture.asset(
                              map.icon,
                              height: 30.0,
                              width: 30.0,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
              return NavigationDecision.prevent;
            }

            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'messageHandler',
        onMessageReceived: (JavaScriptMessage message) async {
          var createChatSupportResult = await chatRoomRepo
              .createChatSupportByMemberFromWebView(message.message.toString());
          if (createChatSupportResult.isSuccess) {
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
                  builder: (context) => ChatRoom(
                    roomId: getCreateRoomResponse.roomId!,
                    picturePath: '',
                    roomName: getCreateRoomResponse.roomName!,
                    roomDesc: getCreateRoomResponse.roomDesc!,
                    isMessagesExist: false,
                  ),
                ),
              );

              //print(message.message.toString());
              //context.router.push(RoomList());
            }
          } else {
            if (createChatSupportResult.message!
                .contains('add merchant user')) {
              _message = 'Not Avaliable Yet';
            }
            if (!context.mounted) return;
            customDialog.show(
                context: context,
                content: _message ?? "Error",
                type: DialogType.warning,
                onPressed: () {
                  context.router.pop();
                });
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
    setOnShowFileSelector();
  }

  Future<void> setOnShowFileSelector() async {
    if (Platform.isAndroid) {
      final controller = (_controller.platform as AndroidWebViewController);
      await controller.setOnShowFileSelector(_androidFilePicker);
    }
  }

  Future<List<String>> _androidFilePicker(FileSelectorParams params) async {
    print(params);
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      return [file.uri.toString()];
    }

    // if (params.acceptTypes.any((type) => type == 'image/*')) {
    //   final picker = image_picker.ImagePicker();
    //   final photo = await picker.pickImage(source: image_picker.ImageSource.camera);

    //   if (photo == null) {
    //     return [];
    //   }

    //   final imageData = await photo.readAsBytes();
    //   final decodedImage = image.decodeImage(imageData)!;
    //   final scaledImage = image.copyResize(decodedImage, width: 500);
    //   final jpg = image.encodeJpg(scaledImage, quality: 90);

    //   final filePath = (await getTemporaryDirectory()).uri.resolve(
    //         './image_${DateTime.now().microsecondsSinceEpoch}.jpg',
    //       );
    //   final file = await File.fromUri(filePath).create(recursive: true);
    //   await file.writeAsBytes(jpg, flush: true);

    //   return [file.uri.toString()];
    // }

    return [];
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
            context.router.popUntil(ModalRoute.withName('DiEnrollme nt')),
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
