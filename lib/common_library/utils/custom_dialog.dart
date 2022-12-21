import 'package:flutter/material.dart';

enum DialogType {
  GENERAL,
  INFO,
  SUCCESS,
  ERROR,
  WARNING,
  SIMPLE_DIALOG,
}

class CustomDialog {
  final double _defIconSize = 120;

  Future show({
    required context,
    required String content,
    title,
    customActions,
    required type,
    bool? barrierDismissable,
    onPressed,
  }) async {
    List<Widget>? actions = <Widget>[
      TextButton(
        child: Text("Ok"),
        onPressed: onPressed ?? () => context.router.pop(),
      )
    ];

    switch (type) {
      case DialogType.GENERAL:
        actions = customActions;
        return _dialog(
          context,
          title,
          content,
          actions,
          barrierDismissable,
        );
      case DialogType.INFO:
        title = Center(
          child: Icon(
            Icons.info_outline,
            size: _defIconSize,
          ),
        );
        return _dialog(
          context,
          title,
          content,
          actions,
          barrierDismissable,
        );
      case DialogType.SUCCESS:
        title = Center(
          child: Icon(
            Icons.check_circle_outline,
            size: _defIconSize,
          ),
        );
        return _dialog(
          context,
          title,
          content,
          actions,
          barrierDismissable,
        );
      case DialogType.WARNING:
        title = Center(
          child: Icon(
            Icons.warning,
            size: _defIconSize,
          ),
        );
        return _dialog(
          context,
          title,
          content,
          actions,
          barrierDismissable,
        );
      case DialogType.ERROR:
        title = Center(
          child: Icon(
            Icons.cancel,
            color: Color(0xffdd0e0e),
            size: _defIconSize,
          ),
        );
        return _dialog(
          context,
          title,
          content,
          actions,
          barrierDismissable,
        );
      case DialogType.SIMPLE_DIALOG:
        actions = customActions;
        return _simpleDialog(
          context,
          title,
          actions,
          barrierDismissable,
        );
    }
  }

  Future _dialog(
    context,
    title,
    content,
    actions,
    barrierDismissable,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(content),
          title: title,
          actions: actions,
        );
      },
      barrierDismissible: barrierDismissable ?? true,
    );
  }

  Future _simpleDialog(
    context,
    title,
    actions,
    barrierDismissible,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: title,
          children: actions,
        );
      },
      barrierDismissible: barrierDismissible ?? true,
    );
  }
}
