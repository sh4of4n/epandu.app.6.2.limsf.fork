import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../services/database/DatabaseHelper.dart';

class ChatHistory extends ChangeNotifier {
  List<MessageDetails> getMessageDetailsList = [];
  final dbHelper = DatabaseHelper.instance;

  List<MessageDetails> get messageDetailsList => getMessageDetailsList;

  void addChatHistory({required MessageDetails messageDetail}) {
    int index = getMessageDetailsList.indexWhere((element) =>
        element.client_message_id == messageDetail.client_message_id);
    if (index == -1) {
      getMessageDetailsList.add(messageDetail);
      notifyListeners();
    }
  }

  void updateChatItemStatus(
      String clientMessageId, String msgStatus, int messageId, String roomId) {
    if (clientMessageId != '') {
      int index = getMessageDetailsList.indexWhere((element) =>
          element.client_message_id == clientMessageId &&
          element.room_id == roomId);
      getMessageDetailsList[index].msgStatus = msgStatus;
      getMessageDetailsList[index].message_id = messageId;
    } else {
      int index = getMessageDetailsList
          .indexWhere((element) => element.message_id == messageId);
      if (index != -1) {
        getMessageDetailsList[index].msgStatus = msgStatus;
      }
    }
    notifyListeners();
  }

  void updateChatItemFilepath(String clientMessageId, String filePath) {
    if (clientMessageId != '') {
      int index = getMessageDetailsList.indexWhere(
          (element) => element.client_message_id == clientMessageId);
      getMessageDetailsList[index].filePath = filePath;
    }
    notifyListeners();
  }

  void updateChatItemMessage(
      String msgBody, int messageId, String editDatetime, String roomId) {
    int index = getMessageDetailsList.indexWhere((element) =>
        element.message_id == messageId && element.room_id == roomId);
    getMessageDetailsList[index].msg_body = msgBody;
    getMessageDetailsList[index].edit_datetime =
        DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime.parse(editDatetime).toLocal())
            .toString();
    notifyListeners();
  }

  void deleteChatItem(int messageId, String roomId) {
    int index = getMessageDetailsList.indexWhere((element) =>
        element.message_id == messageId && element.room_id == roomId);
    if (index != -1) {
      getMessageDetailsList.removeAt(index);
      print(
          'messageId_ ' + messageId.toString() + ' Index_' + index.toString());
      notifyListeners();
    }
  }

  void deleteChatItemByClientMessageId(String clientMessageId) {
    int index = getMessageDetailsList
        .indexWhere((element) => element.client_message_id == clientMessageId);
    getMessageDetailsList.removeAt(index);
    notifyListeners();
  }

  Future<List<MessageDetails>> getChatHistory() async {
    getMessageDetailsList = [];
    getMessageDetailsList = await dbHelper.getMsgDetailList();
    notifyListeners();
    return getMessageDetailsList;
  }
}
