import 'package:flutter/material.dart';
import '../../common_library/services/model/roomhistory_model.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/DatabaseHelper.dart';

class RoomHistory extends ChangeNotifier {
  List<RoomHistoryModel> getRoomList = [];
  final dbHelper = DatabaseHelper.instance;
  final LocalStorage localStorage = LocalStorage();
  List<RoomHistoryModel> get getRoomDetailsList => getRoomList;

  void addRoom({required RoomHistoryModel room}) {
    int index = getRoomDetailsList
        .indexWhere((element) => element.room_id == room.room_id);
    if (index == -1) {
      getRoomList.add(room);
      notifyListeners();
    }
  }

  void updateRoom({required String roomId, required String roomName}) {
    int index =
        getRoomDetailsList.indexWhere((element) => element.room_id == roomId);
    if (index > -1) {
      getRoomList[index].room_name = roomName;
      notifyListeners();
    }
  }

  void updateRoomMessage({required String roomId, required String message}) {
    int index =
        getRoomDetailsList.indexWhere((element) => element.room_id == roomId);
    if (index > -1) {
      getRoomList[index].msg_body = message;
      notifyListeners();
    }
  }

  void deleteRoom({required String roomId}) {
    int index =
        getRoomDetailsList.indexWhere((element) => element.room_id == roomId);
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

    if (getRoomList.indexWhere((element) => element.merchant_no == "EPANDU") >
        0) {
      RoomHistoryModel roomHistoryModel =
          getRoomList.firstWhere((element) => element.merchant_no == "EPANDU");

      getRoomList.remove(roomHistoryModel);
      getRoomList.insert(0, roomHistoryModel);
    }
    return getRoomList;
  }
}
