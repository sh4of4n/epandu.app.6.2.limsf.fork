import 'package:flutter/material.dart';

enum DialogType {
  GENERAL,
  INFO,
  SUCCESS,
  ERROR,
  WARNING,
  SIMPLE_DIALOG,
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
              child: const Text('Ok'),
              onPressed: onPress,
            ),
          ],
        );
      },
    );
  }
}
