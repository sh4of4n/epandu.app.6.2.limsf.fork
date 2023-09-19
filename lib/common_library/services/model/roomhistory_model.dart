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
  String? sendDateTime;
  String? merchantNo;

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
      this.sendDateTime,
      this.merchantNo});

  RoomHistoryModel.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    picturePath = json['picture_path'];
    roomName = json['room_name'];
    roomDesc = json['room_desc'];
    messageId = json['message_id'];
    msgBody = json['msg_body'];
    msgBinaryType = json['msg_binaryType'];
    filePath = json['filePath'];
    nickName = json['nick_name'];
    sendDateTime = json['send_datetime'];
    merchantNo = json['merchant_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['picture_path'] = this.picturePath;
    data['room_name'] = this.roomName;
    data['room_desc'] = this.roomDesc;
    data['message_id'] = this.messageId;
    data['msg_body'] = this.msgBody;
    data['msg_binaryType'] = this.msgBinaryType;
    data['filePath'] = this.filePath;
    data['nick_name'] = this.nickName;
    data['send_datetime'] = this.sendDateTime;
    data['merchant_no'] = this.merchantNo;
    return data;
  }
}
