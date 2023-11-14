class RoomMembers {
  String? id;
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
  String? nickName;
  String? roomName;
  String? picturePath;
  RoomMembers(
      {this.id,
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
      this.merchantNo,
      this.nickName,
      this.roomName,
      this.picturePath});

  RoomMembers.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? '';
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
    nickName = json['nick_name'] ?? '';
    roomName = json['room_name'] ?? '';
    picturePath = json['picture_path'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
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
    data['nick_name'] = nickName;
    data['room_name'] = roomName;
    data['picture_path'] = picturePath;
    return data;
  }
}

class GetRoomMemberListResponse {
  List<RoomMembers>? roomMemberslist;

  GetRoomMemberListResponse({this.roomMemberslist});

  GetRoomMemberListResponse.fromJson(Map<String, dynamic> json) {
    if (json['RoomMember'] != null) {
      roomMemberslist = List<RoomMembers>.empty(growable: true);
      json['RoomMember'].forEach((v) {
        roomMemberslist!.add(RoomMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (roomMemberslist != null) {
      data['RoomMember'] = roomMemberslist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
