class ReadByMessage {
  Message? message;

  ReadByMessage({this.message});

  ReadByMessage.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  List<ReadMessage>? readMessage;

  Message({this.readMessage});

  Message.fromJson(Map<String, dynamic> json) {
    if (json['Message'] != null) {
      readMessage = <ReadMessage>[];
      json['Message'].forEach((v) {
        readMessage!.add(ReadMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (readMessage != null) {
      data['Message'] = readMessage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReadMessage {
  String? id;
  String? roomId;
  String? userId;
  String? appId;
  String? caUid;
  String? deviceId;
  String? msgBody;
  String? msgBinary;
  String? msgBinaryType;
  String? replyToId;
  String? clientMessageId;
  String? readBy;
  String? status;
  String? statusMsg;
  String? misc;
  String? deleted;
  String? sendDatetime;
  String? editDatetime;
  String? deleteDatetime;
  String? transtamp;

  ReadMessage(
      {this.id,
      this.roomId,
      this.userId,
      this.appId,
      this.caUid,
      this.deviceId,
      this.msgBody,
      this.msgBinary,
      this.msgBinaryType,
      this.replyToId,
      this.clientMessageId,
      this.readBy,
      this.status,
      this.statusMsg,
      this.misc,
      this.deleted,
      this.sendDatetime,
      this.editDatetime,
      this.deleteDatetime,
      this.transtamp});

  ReadMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    roomId = json['room_id'] ?? '';
    userId = json['user_id'] ?? '';
    appId = json['app_id'] ?? '';
    caUid = json['ca_uid'] ?? '';
    deviceId = json['device_id'] ?? '';
    msgBody = json['msg_body'] ?? '';
    msgBinary = json['msg_binary'] ?? '';
    msgBinaryType = json['msg_binary_type'] ?? '';
    replyToId = json['reply_to_id'] ?? '';
    clientMessageId = json['client_message_id'] ?? '';
    readBy = json['read_by'] ?? '';
    status = json['status'] ?? '';
    statusMsg = json['status_msg'] ?? '';
    misc = json['misc'] ?? '';
    deleted = json['deleted'] ?? '';
    sendDatetime = json['send_datetime'] ?? '';
    editDatetime = json['edit_datetime'] ?? '';
    deleteDatetime = json['delete_datetime'] ?? '';
    transtamp = json['transtamp'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['room_id'] = roomId;
    data['user_id'] = userId;
    data['app_id'] = appId;
    data['ca_uid'] = caUid;
    data['device_id'] = deviceId;
    data['msg_body'] = msgBody;
    data['msg_binary'] = msgBinary;
    data['msg_binary_type'] = msgBinaryType;
    data['reply_to_id'] = replyToId;
    data['client_message_id'] = clientMessageId;
    data['read_by'] = readBy;
    data['status'] = status;
    data['status_msg'] = statusMsg;
    data['misc'] = misc;
    data['deleted'] = deleted;
    data['send_datetime'] = sendDatetime;
    data['edit_datetime'] = editDatetime;
    data['delete_datetime'] = deleteDatetime;
    data['transtamp'] = transtamp;
    return data;
  }
}
