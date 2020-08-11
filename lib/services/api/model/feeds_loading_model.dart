import 'package:flutter/material.dart';

class FeedsLoadingModel extends ChangeNotifier {
  bool isLoading = false;

  void callStatus(bool isLoading) {
    this.isLoading = isLoading;

    notifyListeners();
  }
}
