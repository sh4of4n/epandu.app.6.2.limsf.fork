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
  String? photoFileName;
  String? profilePhoto;
  String? merchantNo;
  String? picturePath;

  Room({
    this.id,
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
    this.photoFileName,
    this.profilePhoto,
    this.merchantNo,
    this.picturePath,
  });

  Room.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    roomId = json['room_id'];
    appCode = json['app_code'];
    merchantUserId = json['merchant_user_id'];
    merchantLoginId = json['merchant_login_id'];
    merchantNickName = json['merchant_nick_name'];
    userId = json['user_id'];
    loginId = json['login_id'];
    memberNickName = json['member_nick_name'];
    roomName = json['room_name'];
    roomDesc = json['room_desc'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
    deleted = json['deleted'];
    photoFileName = json['photo_filename'];
    profilePhoto = json['profile_photo'];
    merchantNo = json['merchant_no'];
    picturePath = json['picture_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['room_id'] = this.roomId;
    data['app_code'] = this.appCode;
    data['merchant_user_id'] = this.merchantUserId;
    data['merchant_login_id'] = this.merchantLoginId;
    data['merchant_nick_name'] = this.merchantNickName;
    data['user_id'] = this.userId;
    data['login_id'] = this.loginId;
    data['member_nick_name'] = this.memberNickName;
    data['room_name'] = this.roomName;
    data['room_desc'] = this.roomDesc;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['row_key'] = this.rowKey;
    data['transtamp'] = this.transtamp;
    data['deleted'] = this.deleted;
    data['photo_filename'] = this.photoFileName;
    data['profile_photo'] = this.profilePhoto;
    data['merchant_no'] = this.merchantNo;
    data['picture_path'] = this.picturePath;
    return data;
  }
}

class GetRoomListResponse {
  List<Room>? roomlist;

  GetRoomListResponse({this.roomlist});

  GetRoomListResponse.fromJson(Map<String, dynamic> json) {
    if (json['Room'] != null) {
      roomlist = new List<Room>.empty(growable: true);
      json['Room'].forEach((v) {
        roomlist!.add(new Room.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.roomlist != null) {
      data['Room'] = this.roomlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
