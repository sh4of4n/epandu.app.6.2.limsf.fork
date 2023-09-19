class MessageDetails {
  String? roomId;
  String? userId;
  String? appId;
  String? caUid;
  String? deviceId;
  String? msgBody;
  String? msgBinary;
  String? msgBinaryType;
  int? replyToId;
  int? messageId;
  String? readBy;
  String? status;
  String? statusMsg;
  int? deleted;
  String? sendDateTime;
  String? editDateTime;
  String? deleteDateTime;
  String? transtamp;
  String? nickName;
  String? filePath;
  String? ownerId;
  String? msgStatus;
  String? clientMessageId;
  String? roomName;

  MessageDetails(
      {required this.roomId,
      required this.userId,
      required this.appId,
      required this.caUid,
      required this.deviceId,
      required this.msgBody,
      required this.msgBinary,
      required this.msgBinaryType,
      required this.replyToId,
      required this.messageId,
      required this.readBy,
      required this.status,
      required this.statusMsg,
      required this.deleted,
      required this.sendDateTime,
      required this.editDateTime,
      required this.deleteDateTime,
      required this.transtamp,
      required this.nickName,
      required this.filePath,
      required this.ownerId,
      required this.msgStatus,
      required this.clientMessageId,
      required this.roomName});

  factory MessageDetails.fromJson(Map<String, dynamic> json) {
    return MessageDetails(
      roomId: json['room_id'] ?? "",
      userId: json['user_id'] ?? "",
      appId: json['app_id'] ?? "",
      caUid: json['ca_uid'] ?? "",
      deviceId: json['device_id'] ?? "",
      msgBody: json['msg_body'] ?? "",
      msgBinary: json['msg_binary'] ?? "",
      msgBinaryType: json['msg_binaryType'] ?? "",
      replyToId: json['reply_to_id'],
      messageId: json['message_id'],
      readBy: json['read_by'] ?? "",
      status: json['status'] ?? "",
      statusMsg: json['status_msg'] ?? "",
      deleted: json['deleted'] == false ? 0 : 1,
      sendDateTime: json['send_datetime'] ?? "",
      editDateTime: json['edit_datetime'] ?? "",
      deleteDateTime: json['delete_datetime'] ?? "",
      transtamp: json['transtamp'] ?? "",
      nickName: json['nick_name'] ?? "",
      filePath: json['filePath'] ?? "",
      ownerId: json['owner_id'] ?? "",
      msgStatus: json['msgStatus'] ?? "",
      clientMessageId: json['client_message_id'] ?? "",
      roomName: json['roomName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['user_id'] = this.userId;
    data['app_id'] = this.appId;
    data['ca_uid'] = this.caUid;
    data['device_id'] = this.deviceId;
    data['msg_body'] = this.msgBody;
    data['msg_binary'] = this.msgBinary;
    data['msg_binaryType'] = this.msgBinaryType;
    data['reply_to_id'] = this.replyToId;
    data['message_id'] = this.messageId;
    data['read_by'] = this.readBy;
    data['status'] = this.status;
    data['status_msg'] = this.statusMsg;
    data['deleted'] = this.deleted;
    data['send_datetime'] = this.sendDateTime;
    data['edit_datetime'] = this.editDateTime;
    data['delete_datetime'] = this.deleteDateTime;
    data['transtamp'] = this.transtamp;
    data['nick_name'] = this.nickName;
    data['filePath'] = this.filePath;
    data['owner_id'] = this.ownerId;
    data['msgStatus'] = this.msgStatus;
    data['client_message_id'] = this.clientMessageId;
    data['roomName'] = this.roomName;
    return data;
  }
}
