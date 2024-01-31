class RoomHistoryModel {
  String? roomId;
  String? picturePath;
  String? roomName;
  String? roomDesc;
  int? messageId;
  String? msgBody;
  String? msgBinaryType;
  String? filePath;
  String? nickName;
  String? sendDatetime;
  String? merchantNo;
  String? deleted;
  String? deletedDateTime;

  RoomHistoryModel(
      {this.roomId,
      this.picturePath,
      this.roomName,
      this.roomDesc,
      this.messageId,
      this.msgBody,
      this.msgBinaryType,
      this.filePath,
      this.nickName,
      this.sendDatetime,
      this.merchantNo,
      this.deleted,
      this.deletedDateTime});

  RoomHistoryModel.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'] ?? '';
    picturePath = json['picture_path'] ?? '';
    roomName = json['room_name'] ?? '';
    roomDesc = json['room_desc'] ?? '';
    messageId = json['message_id'] ?? 0;
    msgBody = json['msg_body'] ?? '';
    msgBinaryType = json['msg_binaryType'] ?? '';
    filePath = json['filePath'] ?? '';
    nickName = json['nick_name'] ?? '';
    sendDatetime = json['send_datetime'] ?? '';
    merchantNo = json['merchant_no'] ?? '';
    deleted = json['deleted'] ?? '';
    deletedDateTime = json['deletedDateTime'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room_id'] = roomId;
    data['picture_path'] = picturePath;
    data['room_name'] = roomName;
    data['room_desc'] = roomDesc;
    data['message_id'] = messageId;
    data['msg_body'] = msgBody;
    data['msg_binaryType'] = msgBinaryType;
    data['filePath'] = filePath;
    data['nick_name'] = nickName;
    data['send_datetime'] = sendDatetime;
    data['merchant_no'] = merchantNo;
    data['deleted'] = deleted;
    data['deletedDateTime'] = deletedDateTime;
    return data;
  }
}
