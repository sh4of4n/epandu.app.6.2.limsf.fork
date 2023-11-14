class GetLeaveRoomResponse {
  List<LeaveRoomResponse>? room;

  GetLeaveRoomResponse({this.room});

  GetLeaveRoomResponse.fromJson(Map<String, dynamic> json) {
    if (json['RoomMember'] != null) {
      room = <LeaveRoomResponse>[];
      json['RoomMember'].forEach((v) {
        room!.add(LeaveRoomResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (room != null) {
      data['RoomMember'] = room!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveRoomResponse {
  String? iD;
  String? roomId;
  String? appCode;
  String? userId;
  String? loginId;
  String? userType;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? rowKey;
  String? transtamp;
  String? deleted;
  String? merchantNo;

  LeaveRoomResponse(
      {this.iD,
      this.roomId,
      this.appCode,
      this.userId,
      this.loginId,
      this.userType,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.rowKey,
      this.transtamp,
      this.deleted,
      this.merchantNo});

  LeaveRoomResponse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] ?? '';
    roomId = json['room_id'] ?? '';
    appCode = json['app_code'] ?? '';
    userId = json['user_id'] ?? '';
    loginId = json['login_id'] ?? '';
    userType = json['user_type'] ?? '';
    createUser = json['create_user'] ?? '';
    createDate = json['create_date'] ?? '';
    editUser = json['edit_user'] ?? '';
    editDate = json['edit_date'] ?? '';
    rowKey = json['row_key'] ?? '';
    transtamp = json['transtamp'] ?? '';
    deleted = json['deleted'] ?? '';
    merchantNo = json['merchant_no'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['room_id'] = roomId;
    data['app_code'] = appCode;
    data['user_id'] = userId;
    data['login_id'] = loginId;
    data['user_type'] = userType;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['row_key'] = rowKey;
    data['transtamp'] = transtamp;
    data['deleted'] = deleted;
    data['merchant_no'] = merchantNo;
    return data;
  }
}
