import 'package:flutter/material.dart';

enum DialogType {
  GENERAL,
  INFO,
  SUCCESS,
  ERROR,
  WARNING,
}

class CustomDialog extends StatelessWidget {
  final String content;
  final Widget title;
  final List<Widget> customActions;
  final DialogType type;

  CustomDialog({
    @required this.content,
    this.title,
    this.customActions,
    @required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return _dialogType(context, content, title, customActions);
  }

  _dialogType(context, content, title, customActions) {
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
        _dialog(title, content, actions);
        break;
      case DialogType.INFO:
        title = Center(child: Icon(Icons.info_outline));
        _dialog(title, content, actions);
        break;
      case DialogType.SUCCESS:
        title = Center(child: Icon(Icons.check_circle_outline));
        _dialog(title, content, actions);
        break;
      case DialogType.WARNING:
        title = Center(child: Icon(Icons.warning));
        _dialog(title, content, actions);
        break;
      case DialogType.ERROR:
        title = Center(child: Icon(Icons.cancel));
        _dialog(title, content, actions);
        break;
    }
  }

  _dialog(title, content, actions) {
    return AlertDialog(
      content: Text(content),
      title: title,
      actions: actions,
    );
  }
}
