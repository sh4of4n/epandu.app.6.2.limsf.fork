import 'package:flutter/material.dart';

enum DialogType {
  general,
  info,
  success,
  error,
  warning,
  simpleDialog,
}

class CustomNewDialog {
  showNewDialog(BuildContext context, String title, String content,
      Function() onPress) async {
    showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: onPress,
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
