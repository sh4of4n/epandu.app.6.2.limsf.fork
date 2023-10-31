import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../services/database/database_helper.dart';

class ChatHistory extends ChangeNotifier {
  List<MessageDetails> getMessageDetailsList = [];
  List<MessageDetails> getAllMessageDetailsList = [];
  bool isDataExist = true;
  final dbHelper = DatabaseHelper.instance;

  List<MessageDetails> get messageDetailsList => getMessageDetailsList;

  void addChatHistory({required MessageDetails messageDetail}) {
    int index = getMessageDetailsList.indexWhere(
        (element) => element.clientMessageId == messageDetail.clientMessageId);
    //print('addChatHistory:' + messageDetail.filePath!);
    if (index == -1) {
      getMessageDetailsList.add(messageDetail);
      notifyListeners();
    }
  }

  void updateChatItemStatus(
      String clientMessageId, String msgStatus, int messageId, String roomId) {
    if (clientMessageId != '') {
      int index = getMessageDetailsList.indexWhere((element) =>
          element.clientMessageId == clientMessageId &&
          element.roomId == roomId);
      getMessageDetailsList[index].msgStatus = msgStatus;
      getMessageDetailsList[index].messageId = messageId;
    } else {
      int index = getMessageDetailsList
          .indexWhere((element) => element.messageId == messageId);
      if (index != -1) {
        getMessageDetailsList[index].msgStatus = msgStatus;
      }
    }
    notifyListeners();
  }

  void updateChatItemFilepath(String clientMessageId, String filePath) {
    if (clientMessageId != '') {
      int index = getMessageDetailsList
          .indexWhere((element) => element.clientMessageId == clientMessageId);
      getMessageDetailsList[index].filePath = filePath;
    }
    notifyListeners();
  }

  void updateChatItemMessage(
      String msgBody, int messageId, String editDatetime, String roomId) {
    int index = getMessageDetailsList.indexWhere((element) =>
        element.messageId == messageId && element.roomId == roomId);
    getMessageDetailsList[index].msgBody = msgBody;
    getMessageDetailsList[index].editDateTime =
        DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime.parse(editDatetime).toLocal())
            .toString();
    notifyListeners();
  }

  void deleteChats(String roomId) {
    getMessageDetailsList.removeWhere((message) => message.roomId == roomId);
    notifyListeners();
  }

  void updateIsDataExist() {
    isDataExist = true;
    notifyListeners();
  }

  void deleteChatItem(int messageId, String roomId) {
    int index = getMessageDetailsList.indexWhere((element) =>
        element.messageId == messageId && element.roomId == roomId);
    if (index != -1) {
      getMessageDetailsList.removeAt(index);
      // print(
      //     'messageId_ ' + messageId.toString() + ' Index_' + index.toString());
      notifyListeners();
    }
  }

  void deleteChatItemByClientMessageId(String clientMessageId) {
    int index = getMessageDetailsList
        .indexWhere((element) => element.clientMessageId == clientMessageId);
    getMessageDetailsList.removeAt(index);
    notifyListeners();
  }

  Future<List<MessageDetails>> getChatHistory() async {
    getMessageDetailsList = [];
    getMessageDetailsList = await dbHelper.getMsgDetailList();
    notifyListeners();
    return getMessageDetailsList;
  }

  Future<List<MessageDetails>> getChatHistoryByRoomId(String roomId) async {
    getAllMessageDetailsList = [];
    getAllMessageDetailsList = await dbHelper.getMsgDetailList();
    getAllMessageDetailsList = getAllMessageDetailsList
        .where((element) => element.roomId == roomId)
        .toList();
    notifyListeners();
    return getAllMessageDetailsList;
  }

  Future<List<MessageDetails>> getLazyLoadChatHistory(
      String roomId, int offset, int batchSize) async {
    List<MessageDetails> pastMessageDetailsList = getMessageDetailsList;
    getMessageDetailsList = [];
    getMessageDetailsList =
        await dbHelper.getLazyLoadMsgDetailList(roomId, batchSize, offset);

    if (getMessageDetailsList.isNotEmpty) {
      pastMessageDetailsList.addAll(getMessageDetailsList.where((newMessage) {
        return !pastMessageDetailsList.any((existingMessage) =>
            existingMessage.clientMessageId == newMessage.clientMessageId);
      }));
      getMessageDetailsList = pastMessageDetailsList;
    } else {
      isDataExist = false;
      getMessageDetailsList = pastMessageDetailsList;
    }
    getMessageDetailsList.sort((a, b) => a.messageId!.compareTo(b.messageId!));

    notifyListeners();

    return getMessageDetailsList;
  }
}
