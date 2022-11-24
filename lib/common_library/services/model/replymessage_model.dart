class ReplyMessageDetails {
  String? msg_body;
  int? reply_to_id;
  String? nick_name;
  String? filePath;
  String? binaryType;

  ReplyMessageDetails(
      {required this.binaryType,
      required this.msg_body,
      required this.reply_to_id,
      required this.nick_name,
      required this.filePath});

  factory ReplyMessageDetails.fromJson(Map<String, dynamic> json) {
    return ReplyMessageDetails(
        msg_body: json['msg_body'] ?? "",
        reply_to_id: json['reply_to_id'] ?? "",
        nick_name: json['nick_name'] ?? "",
        filePath: json['filePath'] ?? "",
        binaryType: json['binaryType'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg_body'] = this.msg_body;
    data['reply_to_id'] = this.reply_to_id;
    data['nick_name'] = this.nick_name;
    data['filePath'] = this.filePath;
    data['binaryType'] = this.binaryType;
    return data;
  }
}
