class ReceiveMessage {
  String? roomId;
  String? userId;
  String? text;
  String? binary;
  String? binaryType;
  String? datetime;
  String? nickName;
  int? replyToId;
  String? filePath;
  int? messageId;
  String? clientMessageId;
  ReceiveMessage(
      {required this.roomId,
      required this.userId,
      required this.text,
      required this.binary,
      required this.binaryType,
      required this.datetime,
      required this.replyToId,
      required this.messageId,
      required this.nickName,
      required this.filePath,
      required this.clientMessageId});

  factory ReceiveMessage.fromJson(Map<String, dynamic> json) {
    return ReceiveMessage(
        roomId: json['roomId'] ?? '',
        userId: json['userId'] ?? '',
        text: json['text'] ?? '',
        binary: json['binary'] ?? '',
        binaryType: json['binaryType'] ?? '',
        datetime: json['datetime'] ?? '',
        replyToId: json['replyToId'] ?? 0,
        messageId: json['messageId'] ?? 0,
        nickName: json['nick_name'] ?? '',
        filePath: json['filePath'] ?? '',
        clientMessageId: json['clientMessageId'] ?? '');
  }
}
