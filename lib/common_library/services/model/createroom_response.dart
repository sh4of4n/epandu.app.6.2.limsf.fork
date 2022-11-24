class GetCreateRoomResponse {
  List<CreateRoomResponse>? room;

  GetCreateRoomResponse({this.room});

  GetCreateRoomResponse.fromJson(Map<String, dynamic> json) {
    if (json['Room'] != null) {
      room = <CreateRoomResponse>[];
      json['Room'].forEach((v) {
        room!.add(new CreateRoomResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.room != null) {
      data['Room'] = this.room!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreateRoomResponse {
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

  CreateRoomResponse(
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
      this.merchantNo});

  CreateRoomResponse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
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
    merchantNo = json['merchant_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
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
    data['merchant_no'] = this.merchantNo;
    return data;
  }
}
