import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../services/database/database_helper.dart';

class ChatHistory extends ChangeNotifier {
  List<MessageDetails> getMessageDetailsList = [];
  bool isDataExist = true;
  final dbHelper = DatabaseHelper.instance;

  List<MessageDetails> get messageDetailsList => getMessageDetailsList;

  void addChatHistory({required MessageDetails messageDetail}) {
    int index = getMessageDetailsList.indexWhere(
        (element) => element.clientMessageId == messageDetail.clientMessageId);
    if (index == -1) {
      //getMessageDetailsList.add(messageDetail);
      getMessageDetailsList.insert(0, messageDetail);
      notifyListeners();
    }
  }

  void updateChatItemStatus(String clientMessageId, String msgStatus,
      int messageId, String roomId, String sendDateTime) {
    if (clientMessageId != '') {
      int index = getMessageDetailsList.indexWhere((element) =>
          element.clientMessageId == clientMessageId &&
          element.roomId == roomId);
      if (index != -1) {
        getMessageDetailsList[index].msgStatus = msgStatus;
        getMessageDetailsList[index].messageId = messageId;
        if (sendDateTime != '') {
          getMessageDetailsList[index].sendDateTime = sendDateTime;
        }
      }
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
    if (index != -1) {
      getMessageDetailsList[index].msgBody = msgBody;
      getMessageDetailsList[index].editDateTime =
          DateFormat("yyyy-MM-dd HH:mm:ss")
              .format(DateTime.parse(editDatetime).toLocal())
              .toString();
    }
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
  void updateDataNotExist() {
    isDataExist = true;
    notifyListeners();
  }

  Future<void> deleteChatItem(int messageId, String roomId) async {
    int index = getMessageDetailsList.indexWhere((element) =>
        element.messageId == messageId && element.roomId == roomId);
    if (index != -1) {
      getMessageDetailsList.removeAt(index);
      print('messageId_ $messageId Index_$index');
      if (getMessageDetailsList.isEmpty) {
        await dbHelper.deleteLogicallyRoomById(
            roomId,
            'false',
            DateFormat("yyyy-MM-dd HH:mm:ss")
                .format(DateTime.now())
                .toString());
      }
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

  Future<List<MessageDetails>> getLazyLoadChatHistory(
      String roomId, int offset, int batchSize) async {
    List<MessageDetails> pastMessageDetailsList = getMessageDetailsList;
    List<MessageDetails> failedMessagesList = [];
    getMessageDetailsList = [];
    getMessageDetailsList =
        await dbHelper.getLazyLoadMsgDetailList(roomId, batchSize, offset);
    failedMessagesList = await dbHelper.getFailedMsgList(roomId);
    if (getMessageDetailsList.isNotEmpty) {
      pastMessageDetailsList.addAll(getMessageDetailsList.where((newMessage) {
        // Check if the message_id already exists in the list
        return !pastMessageDetailsList.any((existingMessage) =>
            existingMessage.clientMessageId == newMessage.clientMessageId);
      }));

      getMessageDetailsList = pastMessageDetailsList;
    } else {
      isDataExist = false;

      getMessageDetailsList = pastMessageDetailsList;
    }
    // getMessageDetailsList
    //     .sort((a, b) => a.sendDateTime!.compareTo(b.sendDateTime!));
    // getMessageDetailsList.sort((a, b) => a.messageId!.compareTo(b.messageId!));
    getMessageDetailsList.sort((a, b) => b.messageId!.compareTo(a.messageId!));
    if (failedMessagesList.isNotEmpty) {
      for (var newFailedMessage in failedMessagesList) {
        if (!getMessageDetailsList.any((existingMessage) =>
            existingMessage.clientMessageId ==
            newFailedMessage.clientMessageId)) {
          //getMessageDetailsList.add(newFailedMessage);
          getMessageDetailsList.insert(0, newFailedMessage);
        } else {
          int index = getMessageDetailsList.indexWhere((element) =>
              element.clientMessageId == newFailedMessage.clientMessageId);
          getMessageDetailsList.removeAt(index);
          //getMessageDetailsList.add(newFailedMessage);
          getMessageDetailsList.insert(0, newFailedMessage);
        }
      }
    }
    notifyListeners();

    return getMessageDetailsList;
  }
}
