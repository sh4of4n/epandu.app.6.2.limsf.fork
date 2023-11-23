class Room {
  String? id;
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
  String? photoFilename;
  String? profilePhoto;
  String? merchantNo;
  String? picturePath;
  String? deleteDatetime;
  String? ownerId;
  Room(
      {this.id,
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
      this.photoFilename,
      this.profilePhoto,
      this.merchantNo,
      this.picturePath,
      this.deleteDatetime,
      this.ownerId});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
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
    photoFilename = json['photo_filename'] ?? '';
    profilePhoto = json['profile_photo'] ?? '';
    merchantNo = json['merchant_no'] ?? '';
    picturePath = json['picture_path'] ?? '';
    deleteDatetime = json['delete_datetime'] ?? '';
    ownerId = json['owner_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
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
    data['photo_filename'] = photoFilename;
    data['profile_photo'] = profilePhoto;
    data['merchant_no'] = merchantNo;
    data['picture_path'] = picturePath;
    data['delete_datetime'] = deleteDatetime;
    data['owner_id'] = ownerId;
    return data;
  }
}

class GetRoomListResponse {
  List<Room>? roomlist;

  GetRoomListResponse({this.roomlist});

  GetRoomListResponse.fromJson(Map<String, dynamic> json) {
    if (json['Room'] != null) {
      roomlist = List<Room>.empty(growable: true);
      json['Room'].forEach((v) {
        roomlist!.add(Room.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (roomlist != null) {
      data['Room'] = roomlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
