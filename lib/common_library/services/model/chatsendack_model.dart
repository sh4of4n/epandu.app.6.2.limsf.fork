class SendAcknowledge {
  int messageId;
  String? sendDateTime;
  String? clientMessageId;

  SendAcknowledge(
      {required this.messageId,
      required this.sendDateTime,
      required this.clientMessageId});

  factory SendAcknowledge.fromJson(Map<String, dynamic> json) {
    return SendAcknowledge(
      messageId: json['messageId'] ?? 0,
      sendDateTime: json['sendDateTime'] ?? "",
      clientMessageId: json['clientMessageId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageId'] = messageId;
    data['sendDateTime'] = sendDateTime;
    data['clientMessageId'] = clientMessageId;
    return data;
  }
}
