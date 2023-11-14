class ReplyMessageDetails {
  String? msgBody;
  int? replyToId;
  String? nickName;
  String? filePath;
  String? binaryType;

  ReplyMessageDetails(
      {required this.binaryType,
      required this.msgBody,
      required this.replyToId,
      required this.nickName,
      required this.filePath});

  factory ReplyMessageDetails.fromJson(Map<String, dynamic> json) {
    return ReplyMessageDetails(
        msgBody: json['msg_body'] ?? "",
        replyToId: json['reply_to_id'] ?? "",
        nickName: json['nick_name'] ?? "",
        filePath: json['filePath'] ?? "",
        binaryType: json['binaryType'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg_body'] = msgBody;
    data['reply_to_id'] = replyToId;
    data['nick_name'] = nickName;
    data['filePath'] = filePath;
    data['binaryType'] = binaryType;
    return data;
  }
}
