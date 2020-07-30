import 'package:flutter/material.dart';

class CallStatusModel extends ChangeNotifier {
  bool status = false;

  void callStatus(bool status) {
    this.status = status;

    notifyListeners();
  }
}
