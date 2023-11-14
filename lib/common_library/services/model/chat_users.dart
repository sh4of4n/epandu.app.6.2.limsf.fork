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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roomId'] = roomId;
    data['userId'] = userId;
    data['appId'] = appId;
    data['caUid'] = caUid;
    data['deviceId'] = deviceId;
    data['joined'] = joined;
    data['firstJoinedDatetime'] = firstJoinedDatetime;
    data['lastJoinedDatetime'] = lastJoinedDatetime;
    data['lastLeftDatetime'] = lastLeftDatetime;
    return data;
  }
}

class GetChatUsersListResponse {
  List<ChatUsers>? chatUsersList;

  GetChatUsersListResponse({this.chatUsersList});

  GetChatUsersListResponse.fromJson(Map<String, dynamic> json) {
    if (json["data"]) {
      chatUsersList = List<ChatUsers>.empty(growable: true);
      json['data'].forEach((v) {
        chatUsersList!.add(ChatUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chatUsersList != null) {
      data['data'] = chatUsersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
