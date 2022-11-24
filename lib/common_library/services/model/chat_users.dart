class ChatUsers {
  String? roomId;
  String? userId;
  String? appId;
  String? caUid;
  String? deviceId;
  String? joined;
  String? firstJoinedDatetime;
  String? lastJoinedDatetime;
  String? lastLeftDatetime;

  ChatUsers(
      {this.roomId,
      this.userId,
      this.appId,
      this.caUid,
      this.deviceId,
      this.joined,
      this.firstJoinedDatetime,
      this.lastJoinedDatetime,
      this.lastLeftDatetime});

  ChatUsers.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    userId = json['userId'];
    appId = json['appId'];
    caUid = json['caUid'];
    deviceId = json['deviceId'];
    joined = json['joined'];
    firstJoinedDatetime = json['firstJoinedDatetime'];
    lastJoinedDatetime = json['lastJoinedDatetime'];
    lastLeftDatetime = json['lastLeftDatetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomId'] = this.roomId;
    data['userId'] = this.userId;
    data['appId'] = this.appId;
    data['caUid'] = this.caUid;
    data['deviceId'] = this.deviceId;
    data['joined'] = this.joined;
    data['firstJoinedDatetime'] = this.firstJoinedDatetime;
    data['lastJoinedDatetime'] = this.lastJoinedDatetime;
    data['lastLeftDatetime'] = this.lastLeftDatetime;
    return data;
  }
}

class GetChatUsersListResponse {
  List<ChatUsers>? chatUsersList;

  GetChatUsersListResponse({this.chatUsersList});

  GetChatUsersListResponse.fromJson(Map<String, dynamic> json) {
    if (json["data"]) {
      chatUsersList = new List<ChatUsers>.empty(growable: true);
      json['data'].forEach((v) {
        chatUsersList!.add(new ChatUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chatUsersList != null) {
      data['data'] = this.chatUsersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
