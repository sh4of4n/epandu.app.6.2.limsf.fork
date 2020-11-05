import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:epandu/pages/home/home.dart';
import 'package:epandu/services/api/model/provider_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:epandu/utils/custom_dialog.dart';

import '../../app_localizations.dart';
import '../../router.gr.dart';

class NavigationControls extends StatelessWidget {
  final type;

  const NavigationControls({this.webViewControllerFuture, this.type})
      : assert(webViewControllerFuture != null);

  final Future<WebViewController> webViewControllerFuture;

  backButton(context, webViewReady, controller) async {
    final customDialog = CustomDialog();

    if (!webViewReady)
      return null;
    else {
      if (await controller.canGoBack()) {
        await controller.goBack();
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
        // Provider.of<CallStatusModel>(context, listen: false).callStatus(false);
        // ExtendedNavigator.of(context).pop();
        // return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        controllerGlobal = controller;

        return Row(
          children: <Widget>[
            if (type == 'BACK')
              IconButton(
                icon: Platform.isIOS
                    ? const Icon(Icons.arrow_back_ios)
                    : const Icon(Icons.arrow_back),
                onPressed: () => backButton(context, webViewReady, controller),
              ),
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
