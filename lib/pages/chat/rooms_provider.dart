import 'package:flutter/material.dart';
import '../../common_library/services/model/m_room_model.dart';
import '../../services/database/DatabaseHelper.dart';

class RoomHistory extends ChangeNotifier {
  List<Room> getRoomList = [];
  final dbHelper = DatabaseHelper.instance;

  List<Room> get getRoomDetailsList => getRoomList;

  void addRoom({required Room room}) {
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

  Future<List<Room>> getRoomHistory(String userId) async {
    getRoomList = [];
    getRoomList = await dbHelper.getRoomList(userId);
    notifyListeners();
    return getRoomList;
  }
}
