class Room {
  String? ID;
  String? room_id;
  String? app_code;
  String? merchant_user_id;
  String? merchant_login_id;
  String? merchant_nick_name;
  String? user_id;
  String? login_id;
  String? member_nick_name;
  String? room_name;
  String? room_desc;
  String? create_user;
  String? create_date;
  String? edit_user;
  String? edit_date;
  String? row_key;
  String? transtamp;
  String? deleted;
  String? photo_filename;
  String? profile_photo;
  String? merchant_no;
  String? picture_path;

  Room({
    this.ID,
    this.room_id,
    this.app_code,
    this.merchant_user_id,
    this.merchant_login_id,
    this.merchant_nick_name,
    this.user_id,
    this.login_id,
    this.member_nick_name,
    this.room_name,
    this.room_desc,
    this.create_user,
    this.create_date,
    this.edit_user,
    this.edit_date,
    this.row_key,
    this.transtamp,
    this.deleted,
    this.photo_filename,
    this.profile_photo,
    this.merchant_no,
    this.picture_path,
  });

  Room.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    room_id = json['room_id'];
    app_code = json['app_code'];
    merchant_user_id = json['merchant_user_id'];
    merchant_login_id = json['merchant_login_id'];
    merchant_nick_name = json['merchant_nick_name'];
    user_id = json['user_id'];
    login_id = json['login_id'];
    member_nick_name = json['member_nick_name'];
    room_name = json['room_name'];
    room_desc = json['room_desc'];
    create_user = json['create_user'];
    create_date = json['create_date'];
    edit_user = json['edit_user'];
    edit_date = json['edit_date'];
    row_key = json['row_key'];
    transtamp = json['transtamp'];
    deleted = json['deleted'];
    photo_filename = json['photo_filename'];
    profile_photo = json['profile_photo'];
    merchant_no = json['merchant_no'];
    picture_path = json['picture_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.ID;
    data['room_id'] = this.room_id;
    data['app_code'] = this.app_code;
    data['merchant_user_id'] = this.merchant_user_id;
    data['merchant_login_id'] = this.merchant_login_id;
    data['merchant_nick_name'] = this.merchant_nick_name;
    data['user_id'] = this.user_id;
    data['login_id'] = this.login_id;
    data['member_nick_name'] = this.member_nick_name;
    data['room_name'] = this.room_name;
    data['room_desc'] = this.room_desc;
    data['create_user'] = this.create_user;
    data['create_date'] = this.create_date;
    data['edit_user'] = this.edit_user;
    data['edit_date'] = this.edit_date;
    data['row_key'] = this.row_key;
    data['transtamp'] = this.transtamp;
    data['deleted'] = this.deleted;
    data['photo_filename'] = this.photo_filename;
    data['profile_photo'] = this.profile_photo;
    data['merchant_no'] = this.merchant_no;
    data['picture_path'] = this.picture_path;
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
