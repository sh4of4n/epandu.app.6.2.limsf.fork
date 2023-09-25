class CreateRoom {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? merchantNo;
  String? mLoginId;
  String? appId;
  String? deviceId;
  String? appCode;
  // String? userId;
  // String? nickName;

  CreateRoom({
    this.wsCodeCrypt,
    this.caUid,
    this.caPwd,
    this.merchantNo,
    this.mLoginId,
    this.appId,
    this.deviceId,
    this.appCode,
    // this.userId,
    // this.nickName
    //
  });

  CreateRoom.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    merchantNo = json['merchantNo'];
    mLoginId = json['mLoginId'];
    appId = json['appId'];
    deviceId = json['deviceId'];
    appCode = json['appCode'];
    // userId = json['userId'];
    // nickName = json['nickName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['merchantNo'] = merchantNo;
    data['mLoginId'] = mLoginId;
    data['appId'] = appId;
    data['deviceId'] = deviceId;
    data['appCode'] = appCode;
    // data['userId'] = this.userId;
    // data['nickName'] = this.nickName;
    return data;
  }
}
