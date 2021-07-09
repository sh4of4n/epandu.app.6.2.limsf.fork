import 'dart:typed_data';
import 'dart:convert';

class GetUserMeetingAccountResponse {
  List<ZmMeetingUser>? zmMeetingUser;

  GetUserMeetingAccountResponse({this.zmMeetingUser});

  GetUserMeetingAccountResponse.fromJson(Map<String, dynamic> json) {
    if (json['ZmMeetingUser'] != null) {
      zmMeetingUser = new List<ZmMeetingUser>.empty(growable: true);
      json['ZmMeetingUser'].forEach((v) {
        zmMeetingUser!.add(new ZmMeetingUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.zmMeetingUser != null) {
      data['ZmMeetingUser'] =
          this.zmMeetingUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ZmMeetingUser {
  String? dbCode;
  String? meetingTool;
  String? meetingUserId;
  String? personalMeetingId;
  String? refreshToken;

  ZmMeetingUser(
      {this.dbCode,
      this.meetingTool,
      this.meetingUserId,
      this.personalMeetingId,
      this.refreshToken});

  ZmMeetingUser.fromJson(Map<String, dynamic> json) {
    dbCode = json['dbcode'];
    meetingTool = json['meeting_tool'];
    meetingUserId = json['meeting_user_id'];
    personalMeetingId = json['personal_meeting_id'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dbcode'] = this.dbCode;
    data['meeting_tool'] = this.meetingTool;
    data['meeting_user_id'] = this.meetingUserId;
    data['personal_meeting_id'] = this.personalMeetingId;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}

// SavePickUp
class SaveUserMeetingAccount {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? dbcode;
  String? meetingTool;
  String? meetingUserID;
  String? personalMeetingId;
  String? refrshToken;

  SaveUserMeetingAccount(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.dbcode,
      this.meetingTool,
      this.meetingUserID,
      this.personalMeetingId,
      this.refrshToken});

  SaveUserMeetingAccount.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    dbcode = json['dbcode'];
    meetingTool = json['metingTool'];
    meetingUserID = json['meetingUserID'];
    personalMeetingId = json['personalMeetingId'];
    refrshToken = json['refrshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['dbcode'] = this.dbcode;
    data['meetingTool'] = this.meetingTool;
    data['meetingUserID'] = this.meetingUserID;
    data['personalMeetingId'] = this.personalMeetingId;
    data['refrshToken'] = this.refrshToken;
    return data;
  }
}

class SaveMeeting {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? dbcode;
  String? meetingTool;
  String? uuid;
  String? meetingId;
  String? password;
  String? meetingUrl;
  String? meetingStatus;
  String? purpose;
  String? meetingUserId;
  String? subject;
  String? description;
  String? meetingDateString;
  String? startTime;
  String? endTime;
  String? meetingSpeaker;
  String? meetingLanguage;
  String? audiences;
  int? fees;
  Uint8List? banner;
  String? bannerBase64String;
  bool? removeBanner;
  String? dataKey;

  SaveMeeting(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.dbcode,
      this.meetingTool,
      this.uuid,
      this.meetingId,
      this.password,
      this.meetingUrl,
      this.meetingUserId,
      this.meetingStatus,
      this.purpose,
      this.subject,
      this.description,
      this.meetingDateString,
      this.startTime,
      this.endTime,
      this.meetingSpeaker,
      this.meetingLanguage,
      this.audiences,
      this.fees,
      this.banner,
      this.bannerBase64String,
      this.removeBanner,
      this.dataKey});

  SaveMeeting.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    dbcode = json['dbcode'];
    meetingTool = json['meetingTool'];
    uuid = json['uuid'];
    meetingId = json['meetingId'];
    password = json['password'];
    meetingUrl = json['meetingUrl'];
    meetingUserId = json['meetingUserId'];
    meetingStatus = json['meetingStatus'];
    purpose = json['purpose'];
    subject = json['subject'];
    description = json['description'];
    meetingDateString = json['meetingDateString'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    meetingSpeaker = json['meetingSpeaker'];
    meetingLanguage = json['meetingLanguage'];
    audiences = json['audiences'];
    fees = json['fees'];
    banner = json['banner'];
    bannerBase64String = json['bannerBase64String'];
    removeBanner = json['removeBanner'];
    dataKey = json['dataKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['dbcode'] = this.dbcode;
    data['meetingTool'] = this.meetingTool;
    data['uuid'] = this.uuid;
    data['meetingId'] = this.meetingId;
    data['password'] = this.password;
    data['meetingUrl'] = this.meetingUrl;
    data['meetingUserId'] = this.meetingUserId;
    data['meetingStatus'] = this.meetingStatus;
    data['purpose'] = this.purpose;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['meetingDateString'] = this.meetingDateString;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['meetingSpeaker'] = this.meetingSpeaker;
    data['meetingLanguage'] = this.meetingLanguage;
    data['audiences'] = this.audiences;
    data['fees'] = this.fees;
    data['banner'] = this.banner;
    data['bannerBase64String'] = this.bannerBase64String;
    data['removeBanner'] = this.removeBanner;
    data['dataKey'] = this.dataKey;

    return data;
  }
}

class GetMeetingByStatusResponse {
  List<ZoomMeeting>? zoomMeeting;

  GetMeetingByStatusResponse({this.zoomMeeting});

  GetMeetingByStatusResponse.fromJson(Map<String, dynamic> json) {
    if (json['Meeting'] != null) {
      zoomMeeting = new List<ZoomMeeting>.empty(growable: true);
      json['Meeting'].forEach((v) {
        zoomMeeting!.add(new ZoomMeeting.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.zoomMeeting != null) {
      data['Meeting'] = this.zoomMeeting!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ZoomMeeting {
  String? meetingTool;
  String? dbCode;
  String? meetingId;
  String? meetingUrl;
  String? password;
  String? meetingSubject;
  String? meetingDesc;
  String? meetingDate;
  String? meetingStartTime;
  String? meetingEndTime;
  String? meetingSpeaker;
  String? meetingLang;
  String? picturePath;
  String? key;

  ZoomMeeting(
      {this.meetingTool,
      this.dbCode,
      this.meetingUrl,
      this.meetingId,
      this.password,
      this.meetingSubject,
      this.meetingDesc,
      this.meetingDate,
      this.meetingStartTime,
      this.meetingEndTime,
      this.meetingSpeaker,
      this.meetingLang,
      this.picturePath,
      this.key});

  ZoomMeeting.fromJson(Map<String, dynamic> json) {
    meetingTool = json['meeting_tool'];
    dbCode = json['dbcode'];
    meetingUrl = json['meeting_url'];
    meetingId = json['meeting_id'];
    password = json['password'];
    meetingSubject = json['meeting_subject'];
    meetingDesc = json['meeting_desc'];
    meetingDate = json['meeting_date'];
    meetingStartTime = json['meeting_start_time'];
    meetingEndTime = json['meeting_end_time'];
    meetingSpeaker = json['meeting_speaker'];
    meetingLang = json['meeting_lang'];
    picturePath = json['picture_path'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meeting_tool'] = this.meetingTool;
    data['dbcode'] = this.dbCode;
    data['meeting_url'] = this.meetingUrl;
    data['meeting_id'] = this.meetingId;
    data['password'] = this.password;
    data['meeting_subject'] = this.meetingSubject;
    data['meeting_desc'] = this.meetingDesc;
    data['meeting_date'] = this.meetingDate;
    data['meeting_start_time'] = this.meetingStartTime;
    data['meeting_end_time'] = this.meetingEndTime;
    data['meeting_speaker'] = this.meetingSpeaker;
    data['meeting_lang'] = this.meetingLang;
    data['picture_path'] = this.picturePath;
    data['key'] = this.key;

    return data;
  }
}

class GetUserRegisteredDIResponse {
  List<ZmUser>? zoomUser;

  GetUserRegisteredDIResponse({this.zoomUser});

  GetUserRegisteredDIResponse.fromJson(Map<String, dynamic> json) {
    if (json['ArmasterProfile'] != null) {
      zoomUser = new List<ZmUser>.empty(growable: true);
      json['ArmasterProfile'].forEach((v) {
        zoomUser!.add(new ZmUser.fromJson(v));
      });
      print("Zoom User length" + zoomUser!.length.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.zoomUser != null) {
      data['ArmasterProfile'] = this.zoomUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ZmUser {
  String? name;

  ZmUser({this.name});

  ZmUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

MeetingDB meetingFromJson(String str) {
  final jsonData = json.decode(str);
  return MeetingDB.fromMap(jsonData);
}

String meetingToJson(MeetingDB data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class MeetingDB {
  final String? uuid;
  final String? meetingid;
  final String? password;
  final String? datetime;
  final String? hostID;
  final String? status;
  final String? purpose;

  MeetingDB(
      {this.meetingid,
      this.password,
      this.datetime,
      this.hostID,
      this.status,
      this.purpose,
      this.uuid});

  factory MeetingDB.fromMap(Map<String, dynamic> json) {
    return new MeetingDB(
      uuid: json["uuid"] as String?,
      meetingid: json["meetingid"] as String?,
      password: json["password"] as String?,
      datetime: json["datetime"] as String?,
      hostID: json["hostid"] as String?,
      status: json["status"] as String?,
      purpose: json["purpose"] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "meetingid": meetingid,
        "password": password,
        "datetime": datetime,
        "hostid": hostID,
        "status": status,
        "purpose": purpose
      };
}

ScheduleDB scheduleFromJson(String str) {
  final jsonData = json.decode(str);
  return ScheduleDB.fromMap(jsonData);
}

class ScheduleDB {
  final String? uuid;
  final int? meetingid;
  final String? hostid;
  final String? topic;
  final int? type;
  final String? starttime;
  final int? duration;
  final String? timezone;
  final String? createdate;
  final String? joinurl;
  final String? agenda;

  ScheduleDB({
    this.uuid,
    this.meetingid,
    this.hostid,
    this.topic,
    this.type,
    this.starttime,
    this.duration,
    this.timezone,
    this.createdate,
    this.joinurl,
    this.agenda,
  });

  factory ScheduleDB.fromMap(Map<String, dynamic> json) {
    return new ScheduleDB(
      uuid: json["uuid"],
      meetingid: json["id"],
      hostid: json["host_id"],
      topic: json["topic"],
      type: json["type"],
      starttime: json["start_time"],
      duration: json["duration"],
      timezone: json["timezone"],
      createdate: json["created_at"],
      joinurl: json["join_url"],
      agenda: json["agenda"],
    );
  }
}

UserDB userFromJson(String str) {
  final jsonData = json.decode(str);
  return UserDB.fromMap(jsonData);
}

String userToJson(UserDB data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class UserDB {
  String? userID;
  String? username;
  String? zoomUID;
  String? pmi;
  String? code;

  UserDB({userID, username, zoomUID, pmi, code});

  factory UserDB.fromMap(Map<String, dynamic> json) => new UserDB(
        userID: json["user_id"],
        username: json["username"],
        zoomUID: json["zoom_uid"],
        pmi: json["pmi"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userID,
        "username": username,
        "zoom_uid": zoomUID,
        "pmi": pmi,
        "code": code,
      };
}

class ParticipantsDB {
  final String? id;
  final String? name;
  final String? useremail;

  ParticipantsDB({this.id, this.name, this.useremail});

  factory ParticipantsDB.fromMap(Map<String, dynamic> json) =>
      new ParticipantsDB(
        id: json["id"],
        name: json["name"],
        useremail: json["user_email"],
      );
}
