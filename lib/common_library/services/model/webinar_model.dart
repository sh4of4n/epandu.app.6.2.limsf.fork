import 'dart:typed_data';
import 'dart:convert';

class GetUserMeetingAccountResponse {
  List<ZmMeetingUser>? zmMeetingUser;

  GetUserMeetingAccountResponse({this.zmMeetingUser});

  GetUserMeetingAccountResponse.fromJson(Map<String, dynamic> json) {
    if (json['ZmMeetingUser'] != null) {
      zmMeetingUser = List<ZmMeetingUser>.empty(growable: true);
      json['ZmMeetingUser'].forEach((v) {
        zmMeetingUser!.add(ZmMeetingUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (zmMeetingUser != null) {
      data['ZmMeetingUser'] =
          zmMeetingUser!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dbcode'] = dbCode;
    data['meeting_tool'] = meetingTool;
    data['meeting_user_id'] = meetingUserId;
    data['personal_meeting_id'] = personalMeetingId;
    data['refresh_token'] = refreshToken;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['dbcode'] = dbcode;
    data['meetingTool'] = meetingTool;
    data['meetingUserID'] = meetingUserID;
    data['personalMeetingId'] = personalMeetingId;
    data['refrshToken'] = refrshToken;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['dbcode'] = dbcode;
    data['meetingTool'] = meetingTool;
    data['uuid'] = uuid;
    data['meetingId'] = meetingId;
    data['password'] = password;
    data['meetingUrl'] = meetingUrl;
    data['meetingUserId'] = meetingUserId;
    data['meetingStatus'] = meetingStatus;
    data['purpose'] = purpose;
    data['subject'] = subject;
    data['description'] = description;
    data['meetingDateString'] = meetingDateString;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['meetingSpeaker'] = meetingSpeaker;
    data['meetingLanguage'] = meetingLanguage;
    data['audiences'] = audiences;
    data['fees'] = fees;
    data['banner'] = banner;
    data['bannerBase64String'] = bannerBase64String;
    data['removeBanner'] = removeBanner;
    data['dataKey'] = dataKey;

    return data;
  }
}

class GetMeetingByStatusResponse {
  List<ZoomMeeting>? zoomMeeting;

  GetMeetingByStatusResponse({this.zoomMeeting});

  GetMeetingByStatusResponse.fromJson(Map<String, dynamic> json) {
    if (json['Meeting'] != null) {
      zoomMeeting = List<ZoomMeeting>.empty(growable: true);
      json['Meeting'].forEach((v) {
        zoomMeeting!.add(ZoomMeeting.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (zoomMeeting != null) {
      data['Meeting'] = zoomMeeting!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meeting_tool'] = meetingTool;
    data['dbcode'] = dbCode;
    data['meeting_url'] = meetingUrl;
    data['meeting_id'] = meetingId;
    data['password'] = password;
    data['meeting_subject'] = meetingSubject;
    data['meeting_desc'] = meetingDesc;
    data['meeting_date'] = meetingDate;
    data['meeting_start_time'] = meetingStartTime;
    data['meeting_end_time'] = meetingEndTime;
    data['meeting_speaker'] = meetingSpeaker;
    data['meeting_lang'] = meetingLang;
    data['picture_path'] = picturePath;
    data['key'] = key;

    return data;
  }
}

class GetUserRegisteredDIResponse {
  List<ZmUser>? zoomUser;

  GetUserRegisteredDIResponse({this.zoomUser});

  GetUserRegisteredDIResponse.fromJson(Map<String, dynamic> json) {
    if (json['ArmasterProfile'] != null) {
      zoomUser = List<ZmUser>.empty(growable: true);
      json['ArmasterProfile'].forEach((v) {
        zoomUser!.add(ZmUser.fromJson(v));
      });
      print("Zoom User length${zoomUser!.length}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (zoomUser != null) {
      data['ArmasterProfile'] = zoomUser!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
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
    return MeetingDB(
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
    return ScheduleDB(
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

  factory UserDB.fromMap(Map<String, dynamic> json) => UserDB(
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
      ParticipantsDB(
        id: json["id"],
        name: json["name"],
        useremail: json["user_email"],
      );
}
