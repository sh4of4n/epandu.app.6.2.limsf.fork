import 'package:flutter/material.dart';

class NotificationCount extends ChangeNotifier {
  int? notificationBadge = 0;
  bool showBadge = false;

  void setShowBadge({required bool showBadge}) {
    this.showBadge = showBadge;

    notifyListeners();
  }

  void updateNotificationBadge({required int? notificationBadge}) {
    this.notificationBadge = notificationBadge;

    notifyListeners();
  }
}
