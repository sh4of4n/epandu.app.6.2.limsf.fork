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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room_id'] = roomId;
    data['user_id'] = userId;
    data['app_id'] = appId;
    data['ca_uid'] = caUid;
    data['device_id'] = deviceId;
    data['msg_body'] = msgBody;
    data['msg_binary'] = msgBinary;
    data['msg_binaryType'] = msgBinaryType;
    data['reply_to_id'] = replyToId;
    data['message_id'] = messageId;
    data['read_by'] = readBy;
    data['status'] = status;
    data['status_msg'] = statusMsg;
    data['deleted'] = deleted;
    data['send_datetime'] = sendDateTime;
    data['edit_datetime'] = editDateTime;
    data['delete_datetime'] = deleteDateTime;
    data['transtamp'] = transtamp;
    data['nick_name'] = nickName;
    data['filePath'] = filePath;
    data['owner_id'] = ownerId;
    data['msgStatus'] = msgStatus;
    data['client_message_id'] = clientMessageId;
    data['roomName'] = roomName;
    return data;
  }
}
