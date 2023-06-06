class RoomHistoryModel {
  String? room_id;
  String? picture_path;
  String? room_name;
  String? room_desc;
  int? message_id;
  String? msg_body;
  String? msg_binaryType;
  String? filePath;
  String? nick_name;
  String? send_datetime;
  String? merchant_no;

  RoomHistoryModel(
      {this.room_id,
      this.picture_path,
      this.room_name,
      this.room_desc,
      this.message_id,
      this.msg_body,
      this.msg_binaryType,
      this.filePath,
      this.nick_name,
      this.send_datetime,
      this.merchant_no});

  RoomHistoryModel.fromJson(Map<String, dynamic> json) {
    room_id = json['room_id'];
    picture_path = json['picture_path'];
    room_name = json['room_name'];
    room_desc = json['room_desc'];
    message_id = json['message_id'];
    msg_body = json['msg_body'];
    msg_binaryType = json['msg_binaryType'];
    filePath = json['filePath'];
    nick_name = json['nick_name'];
    send_datetime = json['send_datetime'];
    merchant_no = json['merchant_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.room_id;
    data['picture_path'] = this.picture_path;
    data['room_name'] = this.room_name;
    data['room_desc'] = this.room_desc;
    data['message_id'] = this.message_id;
    data['msg_body'] = this.msg_body;
    data['msg_binaryType'] = this.msg_binaryType;
    data['filePath'] = this.filePath;
    data['nick_name'] = this.nick_name;
    data['send_datetime'] = this.send_datetime;
    data['merchant_no'] = this.merchant_no;
    return data;
  }
}
