import 'package:flutter/material.dart';

class ChatNotificationCount extends ChangeNotifier {
  List<ChatNotification> getChatNotificationCountList = [];

  List<ChatNotification> get getChatNotificationCount =>
      getChatNotificationCountList;

  void addNotificationBadge(
      {required int? notificationBadge, required String? roomId}) {
    ChatNotification chatNotification;
    int index = getChatNotificationCountList
        .indexWhere((element) => element.roomId == roomId);
    if (index != -1) {
      getChatNotificationCountList[index].showBadge = true;
      getChatNotificationCountList[index].notificationBadge =
          getChatNotificationCountList[index].notificationBadge! +
              notificationBadge!;
    } else {
      chatNotification = ChatNotification(
          notificationBadge: notificationBadge,
          showBadge: true,
          roomId: roomId,
          messageId: '');
      getChatNotificationCountList.add(chatNotification);
    }

    notifyListeners();
  }

  void updateNotificationBadge(
      {required String? roomId, required String? type}) {
    int index = getChatNotificationCountList
        .indexWhere((element) => element.roomId == roomId);
    if (index != -1) {
      if (type == "DELETE") {
        getChatNotificationCountList[index].showBadge = false;
        getChatNotificationCountList[index].notificationBadge = 0;
      } else {
        getChatNotificationCountList[index].showBadge = true;
        getChatNotificationCountList[index].notificationBadge =
            getChatNotificationCountList[index].notificationBadge! + 1;
      }
      notifyListeners();
    }
  }

  void removeNotificationRoom({required String? roomId}) {
    int index = getChatNotificationCountList
        .indexWhere((element) => element.roomId == roomId);
    if (index != -1) {
      getChatNotificationCountList.removeAt(index);
      notifyListeners();
    }
  }

  void updateUnreadMessageId({required String? roomId}) {
    int index = getChatNotificationCountList
        .indexWhere((element) => element.roomId == roomId);
    if (index != -1) {
      getChatNotificationCountList[index].messageId = '';
      notifyListeners();
    }
  }

  void addMessageId(String roomId, String messageId, String from) {
    int index = getChatNotificationCountList
        .indexWhere((element) => element.roomId == roomId);
    if (index != -1 && from == 'MISSING MESSAGES') {
      getChatNotificationCountList[index].messageId =
          messageId.substring(0, messageId.length - 1);
    } else if (index != -1 && from == 'OUT OF ROOM') {
      if (getChatNotificationCountList[index].messageId != '') {
        getChatNotificationCountList[index].messageId = ',' + messageId;
      } else {
        getChatNotificationCountList[index].messageId = messageId;
      }
      notifyListeners();
    }
  }
}

class ChatNotification {
  int? notificationBadge = 0;
  bool? showBadge = false;
  String? roomId = '';
  String? messageId = '';

  ChatNotification(
      {required this.notificationBadge,
      required this.showBadge,
      required this.roomId,
      required this.messageId});
}
