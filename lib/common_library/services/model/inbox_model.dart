import 'package:hive/hive.dart';

part 'inbox_model.g.dart';

class GetNotificationListByUserIdResponse {
  List<MsgOutBox> table1;

  GetNotificationListByUserIdResponse({this.table1});

  GetNotificationListByUserIdResponse.fromJson(Map<String, dynamic> json) {
    if (json['Table1'] != null) {
      table1 = new List<MsgOutBox>.empty(growable: true);
      json['Table1'].forEach((v) {
        table1.add(new MsgOutBox.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table1 != null) {
      data['Table1'] = this.table1.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 4, adapterName: 'MsgOutboxAdapter')
class MsgOutBox {
  @HiveField(0)
  String msgDoc;
  @HiveField(1)
  String msgRef;
  @HiveField(2)
  String msgType;
  @HiveField(3)
  String sendMsg;

  MsgOutBox({this.msgDoc, this.msgRef, this.msgType, this.sendMsg});

  MsgOutBox.fromJson(Map<String, dynamic> json) {
    msgDoc = json['msg_doc'];
    msgRef = json['msg_ref'];
    msgType = json['msg_type'];
    sendMsg = json['send_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg_doc'] = this.msgDoc;
    data['msg_ref'] = this.msgRef;
    data['msg_type'] = this.msgType;
    data['send_msg'] = this.sendMsg;
    return data;
  }
}

class GetUnreadNotificationCountResponse {
  List<MsgCount> msgCount;

  GetUnreadNotificationCountResponse({this.msgCount});

  GetUnreadNotificationCountResponse.fromJson(Map<String, dynamic> json) {
    if (json['MsgCount'] != null) {
      msgCount = new List<MsgCount>.empty(growable: true);
      json['MsgCount'].forEach((v) {
        msgCount.add(new MsgCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.msgCount != null) {
      data['MsgCount'] = this.msgCount.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MsgCount {
  String msgCount;

  MsgCount({this.msgCount});

  MsgCount.fromJson(Map<String, dynamic> json) {
    msgCount = json['msg_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg_count'] = this.msgCount;
    return data;
  }
}
