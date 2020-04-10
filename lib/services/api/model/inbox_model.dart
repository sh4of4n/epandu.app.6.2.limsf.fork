class GetNotificationListByUserIdResponse {
  List<MsgOutbox> msgOutbox;

  GetNotificationListByUserIdResponse({this.msgOutbox});

  GetNotificationListByUserIdResponse.fromJson(Map<String, dynamic> json) {
    if (json['MsgOutbox'] != null) {
      msgOutbox = new List<MsgOutbox>();
      json['MsgOutbox'].forEach((v) {
        msgOutbox.add(new MsgOutbox.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.msgOutbox != null) {
      data['MsgOutbox'] = this.msgOutbox.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MsgOutbox {
  String id;
  String acctNo;
  String sendType;
  String msgFrom;
  String mobileNo;
  String appId;
  String acctUid;
  String deviceId;
  String location;
  String sendMsg;
  String credit;
  String creditAmt;
  String apiId;
  String inTime;
  String inDate;
  String priority;
  String status;
  String statusMsg;
  String sessionId;
  String refNo;
  String createUser;
  String createDate;
  String timeLog;
  String transtamp;

  MsgOutbox(
      {this.id,
      this.acctNo,
      this.sendType,
      this.msgFrom,
      this.mobileNo,
      this.appId,
      this.acctUid,
      this.deviceId,
      this.location,
      this.sendMsg,
      this.credit,
      this.creditAmt,
      this.apiId,
      this.inTime,
      this.inDate,
      this.priority,
      this.status,
      this.statusMsg,
      this.sessionId,
      this.refNo,
      this.createUser,
      this.createDate,
      this.timeLog,
      this.transtamp});

  MsgOutbox.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acctNo = json['acct_no'];
    sendType = json['send_type'];
    msgFrom = json['msg_from'];
    mobileNo = json['mobile_no'];
    appId = json['app_id'];
    acctUid = json['acct_uid'];
    deviceId = json['device_id'];
    location = json['location'];
    sendMsg = json['send_msg'];
    credit = json['credit'];
    creditAmt = json['credit_amt'];
    apiId = json['api_id'];
    inTime = json['in_time'];
    inDate = json['in_date'];
    priority = json['priority'];
    status = json['status'];
    statusMsg = json['status_msg'];
    sessionId = json['session_id'];
    refNo = json['ref_no'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    timeLog = json['time_log'];
    transtamp = json['transtamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['acct_no'] = this.acctNo;
    data['send_type'] = this.sendType;
    data['msg_from'] = this.msgFrom;
    data['mobile_no'] = this.mobileNo;
    data['app_id'] = this.appId;
    data['acct_uid'] = this.acctUid;
    data['device_id'] = this.deviceId;
    data['location'] = this.location;
    data['send_msg'] = this.sendMsg;
    data['credit'] = this.credit;
    data['credit_amt'] = this.creditAmt;
    data['api_id'] = this.apiId;
    data['in_time'] = this.inTime;
    data['in_date'] = this.inDate;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['status_msg'] = this.statusMsg;
    data['session_id'] = this.sessionId;
    data['ref_no'] = this.refNo;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['time_log'] = this.timeLog;
    data['transtamp'] = this.transtamp;
    return data;
  }
}
