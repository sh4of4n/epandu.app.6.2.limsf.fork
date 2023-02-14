class MessageByRoomModel {
  Message? message;

  MessageByRoomModel({this.message});

  MessageByRoomModel.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  List<MessageList>? messageList;

  Message({this.messageList});

  Message.fromJson(Map<String, dynamic> json) {
    if (json['Message'] != null) {
      messageList = <MessageList>[];
      json['Message'].forEach((v) {
        messageList!.add(new MessageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messageList != null) {
      data['Message'] = this.messageList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessageList {
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
  String? messageId;
  String? readBy;
  String? status;
  String? statusMsg;
  String? deleted;
  String? sendDatetime;
  String? editDatetime;
  String? deleteDatetime;
  String? transtamp;
  String? clientMessageId;

  MessageList(
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
      this.messageId,
      this.readBy,
      this.status,
      this.statusMsg,
      this.deleted,
      this.sendDatetime,
      this.editDatetime,
      this.deleteDatetime,
      this.transtamp,
      this.clientMessageId});

  MessageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['room_id'];
    userId = json['user_id'];
    appId = json['app_id'];
    caUid = json['ca_uid'];
    deviceId = json['device_id'];
    msgBody = json['msg_body'];
    msgBinary = json['msg_binary'];
    msgBinaryType = json['msg_binary_type'];
    replyToId = json['reply_to_id'];
    messageId = json['messageId'];
    readBy = json['read_by'];
    status = json['status'];
    statusMsg = json['status_msg'];
    deleted = json['deleted'];
    sendDatetime = json['send_datetime'];
    editDatetime = json['edit_datetime'];
    deleteDatetime = json['delete_datetime'];
    transtamp = json['transtamp'];
    clientMessageId = json['client_message_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['room_id'] = this.roomId;
    data['user_id'] = this.userId;
    data['app_id'] = this.appId;
    data['ca_uid'] = this.caUid;
    data['device_id'] = this.deviceId;
    data['msg_body'] = this.msgBody;
    data['msg_binary'] = this.msgBinary;
    data['msg_binary_type'] = this.msgBinaryType;
    data['reply_to_id'] = this.replyToId;
    data['messageId'] = this.messageId;
    data['read_by'] = this.readBy;
    data['status'] = this.status;
    data['status_msg'] = this.statusMsg;
    data['deleted'] = this.deleted;
    data['send_datetime'] = this.sendDatetime;
    data['edit_datetime'] = this.editDatetime;
    data['delete_datetime'] = this.deleteDatetime;
    data['transtamp'] = this.transtamp;
    data['clientMessageId'] = this.clientMessageId;
    return data;
  }
}
