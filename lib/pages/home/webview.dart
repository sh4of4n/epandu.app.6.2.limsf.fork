import 'dart:async';
import 'dart:io' show Platform;

import 'package:auto_route/auto_route.dart';
import 'package:epandu/services/api/model/provider_model.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class Webview extends StatelessWidget {
  final String url;

  Webview({@required this.url});

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final myImage = ImagesConstant();

  Future<bool> _onWillPop() async {
    // Provider.of<CallStatusModel>(context, listen: false).callStatus(false);

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: NavigationControls(
            webViewControllerFuture: _controller.future,
            type: 'BACK',
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
                webViewControllerFuture: _controller.future, type: 'RELOAD'),
          ],
        ),
        body: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          // ignore: prefer_collection_literals
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   print('blocking navigation to $request}');
            //   return NavigationDecision.prevent;
            // }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}

class NavigationControls extends StatelessWidget {
  final type;

  const NavigationControls({this.webViewControllerFuture, this.type})
      : assert(webViewControllerFuture != null);

  final Future<WebViewController> webViewControllerFuture;

  backButton(context, webViewReady, controller) async {
    if (!webViewReady)
      return null;
    else {
      if (await controller.canGoBack()) {
        await controller.goBack();
      } else {
        Provider.of<CallStatusModel>(context, listen: false).callStatus(false);
        ExtendedNavigator.of(context).pop();
        // return;
      }
    }
  }

  // onWillPop(context, controller) async {
  //   if (await controller.canGoBack()) {
  //     await controller.goBack();
  //   } else {
  //     Provider.of<CallStatusModel>(context, listen: false).callStatus(false);
  //     ExtendedNavigator.of(context).pop();
  //     // return;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            if (type == 'BACK')
              IconButton(
                icon: Platform.isIOS
                    ? const Icon(Icons.arrow_back_ios)
                    : const Icon(Icons.arrow_back),
                onPressed: () => backButton(context, webViewReady, controller),
              ),
            /* IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoForward()) {
                        await controller.goForward();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("No forward history item")),
                        );
                        return;
                      }
                    },
            ), */
            if (type == 'RELOAD')
              IconButton(
                icon: const Icon(Icons.replay),
                onPressed: !webViewReady
                    ? null
                    : () {
                        controller.reload();
                      },
              ),
          ],
        );
      },
    );
  }
}
