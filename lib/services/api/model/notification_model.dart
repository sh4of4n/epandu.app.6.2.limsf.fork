import 'package:flutter/material.dart';

class NotificationModel extends ChangeNotifier {
  bool notification = false;

  void setNotification(bool value) {
    notification = value;

    notifyListeners();
  }
}
