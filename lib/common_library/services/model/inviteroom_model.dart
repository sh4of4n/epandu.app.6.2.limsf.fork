class InviteRoom {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? merchantNo;
  String? mLoginId;
  String? appId;
  String? deviceId;
  String? appCode;
  String? otherMLoginId;
  String? roomId;
  String? roomName;
  InviteRoom(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.merchantNo,
      this.mLoginId,
      this.appId,
      this.deviceId,
      this.appCode,
      this.otherMLoginId,
      this.roomId,
      this.roomName});

  InviteRoom.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    merchantNo = json['merchantNo'];
    mLoginId = json['mLoginId'];
    appId = json['appId'];
    deviceId = json['deviceId'];
    appCode = json['appCode'];
    otherMLoginId = json['otherMLoginId'];
    roomId = json['roomId'];
    roomName = json['roomName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['merchantNo'] = this.merchantNo;
    data['mLoginId'] = this.mLoginId;
    data['appId'] = this.appId;
    data['deviceId'] = this.deviceId;
    data['appCode'] = this.appCode;
    data['otherMLoginId'] = this.otherMLoginId;
    data['roomId'] = this.roomId;
    data['roomName'] = this.roomName;
    return data;
  }
}
