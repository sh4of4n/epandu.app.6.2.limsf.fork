import 'package:flutter/material.dart';
import '../../common_library/services/model/roomhistory_model.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/database_helper.dart';

class RoomHistory extends ChangeNotifier {
  List<RoomHistoryModel> getRoomList = [];
  final dbHelper = DatabaseHelper.instance;
  final LocalStorage localStorage = LocalStorage();
  List<RoomHistoryModel> get getRoomDetailsList => getRoomList;

  void addRoom({required RoomHistoryModel room}) {
    int index = getRoomDetailsList
        .indexWhere((element) => element.roomId == room.roomId);
    if (index == -1) {
      getRoomList.add(room);
      notifyListeners();
    }
  }

  void updateRoom({required String roomId, required String roomName}) {
    int index =
        getRoomDetailsList.indexWhere((element) => element.roomId == roomId);
    if (index > -1) {
      getRoomList[index].roomName = roomName;
      notifyListeners();
    }
  }

  void updateRoomMessage({required String roomId, required String message}) {
    int index =
        getRoomDetailsList.indexWhere((element) => element.roomId == roomId);
    if (index > -1) {
      getRoomList[index].msgBody = message;
      notifyListeners();
    }
  }

  void deleteRoom({required String roomId}) {
    int index =
        getRoomDetailsList.indexWhere((element) => element.roomId == roomId);
    if (index > -1) {
      getRoomList.removeAt(index);
      notifyListeners();
    }
  }

  Future<List<RoomHistoryModel>> getRoomHistory() async {
    String? userId = await localStorage.getUserId();
    getRoomList = [];
    getRoomList = await dbHelper.getRoomListWithMessage(userId!);
    notifyListeners();

    if (getRoomList.indexWhere((element) => element.merchantNo == "EPANDU") >
        0) {
      RoomHistoryModel roomHistoryModel =
          getRoomList.firstWhere((element) => element.merchantNo == "EPANDU");

      getRoomList.remove(roomHistoryModel);
      getRoomList.insert(0, roomHistoryModel);
    }
    return getRoomList;
  }
}
