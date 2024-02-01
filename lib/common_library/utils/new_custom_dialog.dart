import 'package:flutter/material.dart';

class NewCustomDialog {
  Future<void> show({
    required BuildContext context,
    String title = 'ePandu',
    required String content,
    bool barrierDismissible = true,
    bool dismissOnBackKeyPress = true,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(dismissOnBackKeyPress);
          },
          child: AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Text(content),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
