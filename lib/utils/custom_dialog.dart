import 'package:flutter/material.dart';

enum DialogType {
  GENERAL,
  INFO,
  SUCCESS,
  ERROR,
  WARNING,
}

class CustomDialog {
  final double _defIconSize = 80;

  show({
    @required context,
    @required content,
    title,
    customActions,
    @required type,
  }) {
    List<Widget> actions = <Widget>[
      FlatButton(
        child: Text("Ok"),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ];

    switch (type) {
      case DialogType.GENERAL:
        actions = customActions;
        return _dialog(context, title, content, actions);
      case DialogType.INFO:
        title = Center(
          child: Icon(
            Icons.info_outline,
            size: _defIconSize,
          ),
        );
        return _dialog(context, title, content, actions);
      case DialogType.SUCCESS:
        title = Center(
          child: Icon(
            Icons.check_circle_outline,
            size: _defIconSize,
          ),
        );
        return _dialog(context, title, content, actions);
      case DialogType.WARNING:
        title = Center(
          child: Icon(
            Icons.warning,
            size: _defIconSize,
          ),
        );
        return _dialog(context, title, content, actions);
      case DialogType.ERROR:
        title = Center(
          child: Icon(
            Icons.cancel,
            size: _defIconSize,
          ),
        );
        return _dialog(context, title, content, actions);
    }
  }

  _dialog(context, title, content, actions) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(content),
          title: title,
          actions: actions,
        );
      },
    );
  }
}
