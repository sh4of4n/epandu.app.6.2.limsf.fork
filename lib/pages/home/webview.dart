import 'dart:async';
import 'dart:io' show Platform;

import 'package:auto_route/auto_route.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';
import 'package:epandu/services/api/model/provider_model.dart';

import '../../app_localizations.dart';
import '../../router.gr.dart';
import 'navigation_controls.dart';

class Webview extends StatefulWidget {
  final String url;
  final String backType;

  Webview({@required this.url, this.backType});

  @override
  _WebviewState createState() => _WebviewState();
}

WebViewController controllerGlobal;

Future<bool> _onWillPop({context, backType, customDialog}) async {
  // Provider.of<CallStatusModel>(context, listen: false).callStatus(false);
  if (backType == 'NORMAL') {
    ExtendedNavigator.of(context).pop();

    return true;
  } else {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
    } else {
      customDialog.show(
        context: context,
        content: AppLocalizations.of(context).translate('confirm_back'),
        customActions: <Widget>[
          FlatButton(
              child: Text(AppLocalizations.of(context).translate('yes_lbl')),
              onPressed: () {
                Provider.of<CallStatusModel>(context, listen: false)
                    .callStatus(false);
                ExtendedNavigator.of(context).pop();
                ExtendedNavigator.of(context).pop();
                /* ExtendedNavigator.of(context).popUntil(
                  ModalRoute.withName(Routes.home),
                ); */
              }),
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('no_lbl')),
            onPressed: () {
              ExtendedNavigator.of(context).pop();
            },
          ),
        ],
        type: DialogType.GENERAL,
      );
    }

    return Future.value(false);
  }
}

class _WebviewState extends State<Webview> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final myImage = ImagesConstant();
  final customDialog = CustomDialog();

  getBackType() {
    if (widget.backType == 'NORMAL') {
      return IconButton(
        icon: Platform.isIOS
            ? const Icon(Icons.arrow_back_ios)
            : const Icon(Icons.arrow_back),
        onPressed: () => ExtendedNavigator.of(context).pop(),
      );
    } else {
      return NavigationControls(
        webViewControllerFuture: _controller.future,
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
          leading: getBackType(),
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
          initialUrl: widget.url,
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
