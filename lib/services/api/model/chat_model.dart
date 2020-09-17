import 'dart:ui';

class User {
  String name;
  String dbcode;

  User({this.name, this.dbcode});

  factory User.fromJson(Map<String, dynamic> json) =>
      new User(name: json['name'], dbcode: json['dbcode']);

  Map<String, dynamic> toJson() => {'name': name, 'dbcode': dbcode};
}

class GetUserProfileWithPhoneResponse {
  List<UserProfileWithPhone> userProfile;

  GetUserProfileWithPhoneResponse({this.userProfile});

  GetUserProfileWithPhoneResponse.fromJson(Map<String, dynamic> json) {
    if (json['User'] != null) {
      userProfile = new List<UserProfileWithPhone>();
      json['User'].forEach((v) {
        userProfile.add(new UserProfileWithPhone.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userProfile != null) {
      data['User'] = this.userProfile.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserProfileWithPhone {
  String iD;
  String userId;
  String phone;
  String firstName;

  UserProfileWithPhone({this.iD, this.userId, this.phone, this.firstName});

  UserProfileWithPhone.fromJson(Map<String, dynamic> json) {
    iD = json['id'];
    userId = json['user_id'];
    phone = json['phone'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.iD;
    data['user_id'] = this.userId;
    data['phone'] = this.phone;
    data['first_name'] = this.firstName;
    return data;
  }
}

class Message {
  String id;
  String author;
  String target;
  String data;
  int sentDateTime;
  String type;
  String isSeen;

  MessageBody body;

  Message(
      {this.id,
      this.author,
      this.target,
      this.body,
      this.data,
      this.sentDateTime,
      this.type,
      this.isSeen});

  factory Message.fromJson(Map<String, dynamic> json) => new Message(
      id: json['id'],
      author: json['author'],
      target: json['target'],
      //body: MessageBody.fromJson(json['body'])
      data: json['data'],
      sentDateTime: json['sent_date_time'],
      type: json['type'],
      isSeen: json['is_seen']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author,
        'target': target,
        'data': data,
        'sent_date_time': sentDateTime,
        'type': type,
        'is_seen': isSeen,
      };
}

class MessageBody {
  String data;
  String sentDateTime;
  String type;
  String isSeen;

  MessageBody({this.data, this.sentDateTime, this.type, this.isSeen});

  factory MessageBody.fromJson(Map<String, dynamic> json) => new MessageBody(
      data: json['data'],
      sentDateTime: json['sentDateTime'],
      type: json['type'],
      isSeen: json['isSeen']);

  Map<String, dynamic> toJson() => {
        'data': data,
        'sentDateTime': sentDateTime,
        'type': type,
        'isSeen': isSeen
      };
}

class MessageAndAuthorTable {
  String id;
  String author;
  String data;
  int sentDateTime;
  String type;
  String isSeen;

  MessageAndAuthorTable(
      {this.id,
      this.author,
      this.data,
      this.sentDateTime,
      this.type,
      this.isSeen});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'author': author,
      'data': data,
      'sent_date_time': sentDateTime,
      'type': type,
      'is_seen': isSeen,
    };
    return map;
  }

  MessageAndAuthorTable.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    author = map['author'];
    data = map['data'];
    sentDateTime = map['sent_date_time'];
    type = map['type'];
    isSeen = map['is_seen'];
  }
}

class MessageTargetTable {
  String id;
  String messageId;
  String targetId;

  MessageTargetTable({
    this.id,
    this.messageId,
    this.targetId,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'message_id': messageId,
      'target_id': targetId,
    };
    return map;
  }

  MessageTargetTable.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    messageId = map['message_id'];
    targetId = map['target_id'];
  }
}
