class GetInviteRoomResponse {
  List<InviteRoomResponse>? room;

  GetInviteRoomResponse({this.room});

  GetInviteRoomResponse.fromJson(Map<String, dynamic> json) {
    if (json['Room'] != null) {
      room = <InviteRoomResponse>[];
      json['Room'].forEach((v) {
        room!.add(InviteRoomResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (room != null) {
      data['Room'] = room!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InviteRoomResponse {
  String? iD;
  String? roomId;
  String? appCode;
  String? merchantUserId;
  String? merchantLoginId;
  String? merchantNickName;
  String? userId;
  String? loginId;
  String? memberNickName;
  String? roomName;
  String? roomDesc;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? rowKey;
  String? transtamp;
  String? deleted;
  String? merchantNo;
  String? picturePath;

  InviteRoomResponse(
      {this.iD,
      this.roomId,
      this.appCode,
      this.merchantUserId,
      this.merchantLoginId,
      this.merchantNickName,
      this.userId,
      this.loginId,
      this.memberNickName,
      this.roomName,
      this.roomDesc,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.rowKey,
      this.transtamp,
      this.deleted,
      this.merchantNo,
      this.picturePath});

  InviteRoomResponse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] ?? '';
    roomId = json['room_id'] ?? '';
    appCode = json['app_code'] ?? '';
    merchantUserId = json['merchant_user_id'] ?? '';
    merchantLoginId = json['merchant_login_id'] ?? '';
    merchantNickName = json['merchant_nick_name'] ?? '';
    userId = json['user_id'] ?? '';
    loginId = json['login_id'] ?? '';
    memberNickName = json['member_nick_name'] ?? '';
    roomName = json['room_name'] ?? '';
    roomDesc = json['room_desc'] ?? '';
    createUser = json['create_user'] ?? '';
    createDate = json['create_date'] ?? '';
    editUser = json['edit_user'] ?? '';
    editDate = json['edit_date'] ?? '';
    rowKey = json['row_key'] ?? '';
    transtamp = json['transtamp'] ?? '';
    deleted = json['deleted'] ?? '';
    merchantNo = json['merchant_no'] ?? '';
    picturePath = json['picture_path'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['room_id'] = roomId;
    data['app_code'] = appCode;
    data['merchant_user_id'] = merchantUserId;
    data['merchant_login_id'] = merchantLoginId;
    data['merchant_nick_name'] = merchantNickName;
    data['user_id'] = userId;
    data['login_id'] = loginId;
    data['member_nick_name'] = memberNickName;
    data['room_name'] = roomName;
    data['room_desc'] = roomDesc;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['row_key'] = rowKey;
    data['transtamp'] = transtamp;
    data['deleted'] = deleted;
    data['merchant_no'] = merchantNo;
    data['picture_path'] = picturePath;
    return data;
  }
}
