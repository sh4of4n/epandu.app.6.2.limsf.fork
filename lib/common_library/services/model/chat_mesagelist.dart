class MessageDetails {
  String? room_id;
  String? user_id;
  String? app_id;
  String? ca_uid;
  String? device_id;
  String? msg_body;
  String? msg_binary;
  String? msg_binaryType;
  int? reply_to_id;
  int? message_id;
  String? read_by;
  String? status;
  String? status_msg;
  int? deleted;
  String? send_datetime;
  String? edit_datetime;
  String? delete_datetime;
  String? transtamp;
  String? nick_name;
  String? filePath;
  String? owner_id;
  String? msgStatus;
  String? client_message_id;
  String? roomName;

  MessageDetails(
      {required this.room_id,
      required this.user_id,
      required this.app_id,
      required this.ca_uid,
      required this.device_id,
      required this.msg_body,
      required this.msg_binary,
      required this.msg_binaryType,
      required this.reply_to_id,
      required this.message_id,
      required this.read_by,
      required this.status,
      required this.status_msg,
      required this.deleted,
      required this.send_datetime,
      required this.edit_datetime,
      required this.delete_datetime,
      required this.transtamp,
      required this.nick_name,
      required this.filePath,
      required this.owner_id,
      required this.msgStatus,
      required this.client_message_id,
      required this.roomName});

  factory MessageDetails.fromJson(Map<String, dynamic> json) {
    return MessageDetails(
      room_id: json['room_id'] ?? "",
      user_id: json['user_id'] ?? "",
      app_id: json['app_id'] ?? "",
      ca_uid: json['ca_uid'] ?? "",
      device_id: json['device_id'] ?? "",
      msg_body: json['msg_body'] ?? "",
      msg_binary: json['msg_binary'] ?? "",
      msg_binaryType: json['msg_binaryType'] ?? "",
      reply_to_id: json['reply_to_id'],
      message_id: json['message_id'],
      read_by: json['read_by'] ?? "",
      status: json['status'] ?? "",
      status_msg: json['status_msg'] ?? "",
      deleted: json['deleted'] == false ? 0 : 1,
      send_datetime: json['send_datetime'] ?? "",
      edit_datetime: json['edit_datetime'] ?? "",
      delete_datetime: json['delete_datetime'] ?? "",
      transtamp: json['transtamp'] ?? "",
      nick_name: json['nick_name'] ?? "",
      filePath: json['filePath'] ?? "",
      owner_id: json['owner_id'] ?? "",
      msgStatus: json['msgStatus'] ?? "",
      client_message_id: json['client_message_id'] ?? "",
      roomName: json['roomName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.room_id;
    data['user_id'] = this.user_id;
    data['app_id'] = this.app_id;
    data['ca_uid'] = this.ca_uid;
    data['device_id'] = this.device_id;
    data['msg_body'] = this.msg_body;
    data['msg_binary'] = this.msg_binary;
    data['msg_binaryType'] = this.msg_binaryType;
    data['reply_to_id'] = this.reply_to_id;
    data['message_id'] = this.message_id;
    data['read_by'] = this.read_by;
    data['status'] = this.status;
    data['status_msg'] = this.status_msg;
    data['deleted'] = this.deleted;
    data['send_datetime'] = this.send_datetime;
    data['edit_datetime'] = this.edit_datetime;
    data['delete_datetime'] = this.delete_datetime;
    data['transtamp'] = this.transtamp;
    data['nick_name'] = this.nick_name;
    data['filePath'] = this.filePath;
    data['owner_id'] = this.owner_id;
    data['msgStatus'] = this.msgStatus;
    data['client_message_id'] = this.client_message_id;
    data['roomName'] = this.roomName;
    return data;
  }
}
