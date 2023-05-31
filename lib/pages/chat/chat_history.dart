import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../services/database/DatabaseHelper.dart';

class ChatHistory extends ChangeNotifier {
  List<MessageDetails> getMessageDetailsList = [];
  bool isDataExist = true;
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

  void deleteChats(String roomId) {
    getMessageDetailsList.removeWhere((message) => message.room_id == roomId);
    notifyListeners();
  }

  void updateIsDataExist() {
    isDataExist = true;
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

  Future<List<MessageDetails>> getLazyLoadChatHistory(
      String roomId, int offset, int batchSize) async {
    List<MessageDetails> pastMessageDetailsList = getMessageDetailsList;
    getMessageDetailsList = [];
    getMessageDetailsList =
        await dbHelper.getLazyLoadMsgDetailList(roomId, batchSize, offset);

    if (getMessageDetailsList.length > 0) {
      //pastMessageDetailsList.addAll(getMessageDetailsList);
      // pastMessageDetailsList.addAll(getMessageDetailsList.where((message) {
      //   // Check if the value already exists in the list
      //   return !pastMessageDetailsList.contains(message);
      // }));
      pastMessageDetailsList.addAll(getMessageDetailsList.where((newMessage) {
        // Check if the message_id already exists in the list
        return !pastMessageDetailsList.any((existingMessage) =>
            existingMessage.message_id == newMessage.message_id);
      }));

      getMessageDetailsList = pastMessageDetailsList;
    } else {
      isDataExist = false;
      getMessageDetailsList = pastMessageDetailsList;
    }
    getMessageDetailsList
        .sort((a, b) => a.message_id!.compareTo(b.message_id!));

    notifyListeners();

    return getMessageDetailsList;
  }
}
