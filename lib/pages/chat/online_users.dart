import 'package:flutter/material.dart';
import '../../common_library/services/model/checkonline_model.dart';

class OnlineUsers extends ChangeNotifier {
  List<CheckOnline> checkOnlineList = [];
  BuildContext ctx;
  OnlineUsers(this.ctx);
  List<CheckOnline> get getOnlineList => checkOnlineList;
  void showOnlineUsers({required CheckOnline checkOnline}) {
    checkOnlineList.add(checkOnline);
    notifyListeners();
  }

  void removeOnlineUsers() {
    checkOnlineList = [];
    notifyListeners();
  }
}
