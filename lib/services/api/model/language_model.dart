import 'package:flutter/material.dart';

class LanguageModel extends ChangeNotifier {
  String language;

  void selectedLanguage(String lang) {
    language = '($lang)';

    notifyListeners();
  }
}
