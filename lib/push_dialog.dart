import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:flutter/material.dart';

import 'common_library/utils/app_localizations.dart';

class PushDialog extends StatelessWidget {
  final String? message;

  PushDialog({this.message});

  final customDialog = CustomDialog();

  @override
  Widget build(BuildContext context) {
    return customDialog.show(
      context: context,
      content: message,
      customActions: <Widget>[
        TextButton(
          child: Text(AppLocalizations.of(context)!.translate('ok_btn')),
          onPressed: () => context.router.pop(),
        ),
      ],
      type: DialogType.GENERAL,
    );
  }
}
