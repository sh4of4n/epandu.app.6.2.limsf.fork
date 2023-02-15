import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:epandu/pages/home/home.dart';
import 'package:epandu/common_library/services/model/provider_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
// import '../../router.gr.dart';

class NavigationControls extends StatelessWidget {
  final type;
  final backType;

  const NavigationControls({
    required this.webViewControllerFuture,
    this.type,
    this.backType,
  });

  final WebViewController webViewControllerFuture;

  backButton(BuildContext context, webViewReady, controller) async {
    final customDialog = CustomDialog();

    if (!webViewReady)
      return null;
    else {
      if (backType == 'HOME') {
        customDialog.show(
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
      } else {
        if (await controller.canGoBack()) {
          await controller.goBack();
        } else {
          /* customDialog.show(
            context: context,
            content: AppLocalizations.of(context).translate('confirm_back'),
            customActions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context).translate('yes_lbl')),
                onPressed: () {
                  Provider.of<CallStatusModel>(context, listen: false)
                      .callStatus(false);
                  context.router.pop();
                  context.router.pop();
                  /* context.router.popUntil(
                    ModalRoute.withName(Routes.home),
                  ); */
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context).translate('no_lbl')),
                onPressed: () {
                  context.router.pop();
                },
              ),
            ],
            type: DialogType.GENERAL,
          ); */
          Provider.of<CallStatusModel>(context, listen: false)
              .callStatus(false);
          context.router.pop();
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool webViewReady = true;
    final WebViewController? controller = webViewControllerFuture;
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
            onPressed: () {
              controller!.reload();
            },
          ),
      ],
    );
  }
}
