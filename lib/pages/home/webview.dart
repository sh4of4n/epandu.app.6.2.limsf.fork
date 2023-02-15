import 'dart:async';
import 'dart:io' show Platform;

import 'package:auto_route/auto_route.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';
import 'package:epandu/common_library/services/model/provider_model.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';

// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// import '../../router.gr.dart';

class Webview extends StatefulWidget {
  final String? url;
  final String? backType;

  Webview({required this.url, this.backType});

  @override
  _WebviewState createState() => _WebviewState();
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
    type: DialogType.GENERAL,
  );
}

class _WebviewState extends State<Webview> {
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  late final WebViewController _controller;
  final myImage = ImagesConstant();
  final customDialog = CustomDialog();
  @override
  void initState() {
    super.initState();

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
      ..setBackgroundColor(const Color(0x00000000))
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
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
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
      return NavigationControls(webViewController: _controller);
      // return NavigationControls(
      //   webViewControllerFuture: _controller.future,
      //   type: 'BACK',
      // );
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
            // leading: getBackType(),
            title: FadeInImage(
              alignment: Alignment.center,
              height: 110.h,
              placeholder: MemoryImage(kTransparentImage),
              image: AssetImage(
                myImage.logo2,
              ),
            ),
            actions: <Widget>[
              NavigationControls(webViewController: _controller)
              // NavigationControls(
              //     webViewControllerFuture: _controller.future, type: 'RELOAD'),
            ],
          ),
          body: WebViewWidget(controller: _controller)
          // WebView(
          //   initialUrl: widget.url,
          //   javascriptMode: JavascriptMode.unrestricted,
          //   onWebViewCreated: (WebViewController webViewController) {
          //     _controller.complete(webViewController);
          //   },
          //   // ignore: prefer_collection_literals
          //   javascriptChannels: <JavascriptChannel>[
          //     _toasterJavascriptChannel(context),
          //   ].toSet(),
          //   navigationDelegate: (NavigationRequest request) {
          //     // if (request.url.startsWith('https://www.youtube.com/')) {
          //     //   print('blocking navigation to $request}');
          //     //   return NavigationDecision.prevent;
          //     // }
          //     print('allowing navigation to $request');
          //     return NavigationDecision.navigate;
          //   },
          //   onPageStarted: (String url) {
          //     print('Page started loading: $url');
          //   },
          //   onPageFinished: (String url) {
          //     print('Page finished loading: $url');
          //   },
          //   gestureNavigationEnabled: true,
          // ),
          ),
    );
  }

  // JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  //   return JavascriptChannel(
  //       name: 'Toaster',
  //       onMessageReceived: (JavascriptMessage message) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text(message.message)),
  //         );
  //       });
  // }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({Key? key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No back history item')),
              );
              return;
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (await webViewController.canGoForward()) {
              await webViewController.goForward();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No forward history item')),
              );
              return;
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => webViewController.reload(),
        ),
      ],
    );
  }
}
