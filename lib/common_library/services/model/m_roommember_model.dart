class RoomMembers {
  String? ID;
  String? room_id;
  String? app_code;
  String? user_id;
  String? login_id;
  String? user_type;
  String? create_user;
  String? create_date;
  String? edit_user;
  String? edit_date;
  String? row_key;
  String? transtamp;
  String? deleted;
  String? merchant_no;
  String? nick_name;
  String? room_name;
  String? picture_path;
  RoomMembers(
      {this.ID,
      this.room_id,
      this.app_code,
      this.user_id,
      this.login_id,
      this.user_type,
      this.create_user,
      this.create_date,
      this.edit_user,
      this.edit_date,
      this.row_key,
      this.transtamp,
      this.deleted,
      this.merchant_no,
      this.nick_name,
      this.room_name,
      this.picture_path});

  RoomMembers.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    room_id = json['room_id'];
    app_code = json['app_code'];
    user_id = json['user_id'];
    login_id = json['login_id'];
    user_type = json['user_type'];
    create_user = json['create_user'];
    create_date = json['create_date'];
    edit_user = json['edit_user'];
    edit_date = json['edit_date'];
    row_key = json['row_key'];
    transtamp = json['transtamp'];
    deleted = json['deleted'];
    merchant_no = json['merchant_no'];
    nick_name = json['nick_name'];
    room_name = json['room_name'];
    picture_path = json['picture_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.ID;
    data['room_id'] = this.room_id;
    data['app_code'] = this.app_code;
    data['user_id'] = this.user_id;
    data['login_id'] = this.login_id;
    data['user_type'] = this.user_type;
    data['create_user'] = this.create_user;
    data['create_date'] = this.create_date;
    data['edit_user'] = this.edit_user;
    data['edit_date'] = this.edit_date;
    data['row_key'] = this.row_key;
    data['transtamp'] = this.transtamp;
    data['deleted'] = this.deleted;
    data['merchant_no'] = this.merchant_no;
    data['nick_name'] = this.nick_name;
    data['room_name'] = this.room_name;
    data['picture_path'] = this.picture_path;
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
