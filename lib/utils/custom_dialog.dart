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
    return Container(
        child: _dialogType(context, content, title, customActions));
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
        return _dialog(title, content, actions);
      case DialogType.INFO:
        title = Center(child: Icon(Icons.info_outline));
        return _dialog(title, content, actions);
      case DialogType.SUCCESS:
        title = Center(child: Icon(Icons.check_circle_outline));
        return _dialog(title, content, actions);
      case DialogType.WARNING:
        title = Center(child: Icon(Icons.warning));
        return _dialog(title, content, actions);
      case DialogType.ERROR:
        title = Center(child: Icon(Icons.cancel));
        return _dialog(title, content, actions);
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
