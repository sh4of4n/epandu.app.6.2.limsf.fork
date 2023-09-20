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
    id = json['ID'];
    roomId = json['room_id'];
    appCode = json['app_code'];
    userId = json['user_id'];
    loginId = json['login_id'];
    userType = json['user_type'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
    deleted = json['deleted'];
    merchantNo = json['merchant_no'];
    nickName = json['nick_name'];
    roomName = json['room_name'];
    picturePath = json['picture_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['room_id'] = this.roomId;
    data['app_code'] = this.appCode;
    data['user_id'] = this.userId;
    data['login_id'] = this.loginId;
    data['user_type'] = this.userType;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['row_key'] = this.rowKey;
    data['transtamp'] = this.transtamp;
    data['deleted'] = this.deleted;
    data['merchant_no'] = this.merchantNo;
    data['nick_name'] = this.nickName;
    data['room_name'] = this.roomName;
    data['picture_path'] = this.picturePath;
    return data;
  }
}

class GetRoomMemberListResponse {
  List<RoomMembers>? roomMemberslist;

  GetRoomMemberListResponse({this.roomMemberslist});

  GetRoomMemberListResponse.fromJson(Map<String, dynamic> json) {
    if (json['RoomMember'] != null) {
      roomMemberslist = new List<RoomMembers>.empty(growable: true);
      json['RoomMember'].forEach((v) {
        roomMemberslist!.add(new RoomMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.roomMemberslist != null) {
      data['RoomMember'] =
          this.roomMemberslist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
