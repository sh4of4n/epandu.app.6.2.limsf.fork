import 'package:flutter/material.dart';

class LanguageModel extends ChangeNotifier {
  String language;

  void selectedLanguage(String lang) {
    language = '($lang)';

    notifyListeners();
  }
}

class CallStatusModel extends ChangeNotifier {
  bool status = false;

  void callStatus(bool status) {
    this.status = status;

    notifyListeners();
  }
}

class FeedsLoadingModel extends ChangeNotifier {
  bool isLoading = false;

  void callStatus(bool isLoading) {
    this.isLoading = isLoading;

    notifyListeners();
  }
}
