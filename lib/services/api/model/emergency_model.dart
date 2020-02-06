import 'package:hive/hive.dart';

part 'emergency_model.g.dart';

// Get Default SoS contact
class DefaultEmergencyContactResponse {
  List<SosContactHelpDesk> sosContactHelpDesk;

  DefaultEmergencyContactResponse({this.sosContactHelpDesk});

  DefaultEmergencyContactResponse.fromJson(Map<String, dynamic> json) {
    if (json['SosContactHelpDesk'] != null) {
      sosContactHelpDesk = new List<SosContactHelpDesk>();
      json['SosContactHelpDesk'].forEach((v) {
        sosContactHelpDesk.add(new SosContactHelpDesk.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sosContactHelpDesk != null) {
      data['SosContactHelpDesk'] =
          this.sosContactHelpDesk.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SosContactHelpDesk {
  String sosCallPhone;
  String sosSmsPhone;
  String policeCallPhone;
  String policeSmsPhone;
  String ambulanceCallPhone;
  String ambulanceSmsPhone;
  String autoAssistCallPhone;
  String autoAssistSmsPhone;
  String sosSystemSmsPhone;
  String locRequestPriority;
  String locRequestFastestInterval;
  String locRequestInterval;

  SosContactHelpDesk(
      {this.sosCallPhone,
      this.sosSmsPhone,
      this.policeCallPhone,
      this.policeSmsPhone,
      this.ambulanceCallPhone,
      this.ambulanceSmsPhone,
      this.autoAssistCallPhone,
      this.autoAssistSmsPhone,
      this.sosSystemSmsPhone,
      this.locRequestPriority,
      this.locRequestFastestInterval,
      this.locRequestInterval});

  SosContactHelpDesk.fromJson(Map<String, dynamic> json) {
    sosCallPhone = json['sos_call_phone'];
    sosSmsPhone = json['sos_sms_phone'];
    policeCallPhone = json['police_call_phone'];
    policeSmsPhone = json['police_sms_phone'];
    ambulanceCallPhone = json['ambulance_call_phone'];
    ambulanceSmsPhone = json['ambulance_sms_phone'];
    autoAssistCallPhone = json['auto_assist_call_phone'];
    autoAssistSmsPhone = json['auto_assist_sms_phone'];
    sosSystemSmsPhone = json['sos_system_sms_phone'];
    locRequestPriority = json['loc_request_priority'];
    locRequestFastestInterval = json['loc_request_fastest_interval'];
    locRequestInterval = json['loc_request_interval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sos_call_phone'] = this.sosCallPhone;
    data['sos_sms_phone'] = this.sosSmsPhone;
    data['police_call_phone'] = this.policeCallPhone;
    data['police_sms_phone'] = this.policeSmsPhone;
    data['ambulance_call_phone'] = this.ambulanceCallPhone;
    data['ambulance_sms_phone'] = this.ambulanceSmsPhone;
    data['auto_assist_call_phone'] = this.autoAssistCallPhone;
    data['auto_assist_sms_phone'] = this.autoAssistSmsPhone;
    data['sos_system_sms_phone'] = this.sosSystemSmsPhone;
    data['loc_request_priority'] = this.locRequestPriority;
    data['loc_request_fastest_interval'] = this.locRequestFastestInterval;
    data['loc_request_interval'] = this.locRequestInterval;
    return data;
  }
}

// Get Sos Contact
/* class EmergencyContactRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String sosContactType;
  String sosContactCode;
  String areaCode;

  EmergencyContactRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.sosContactType,
      this.sosContactCode,
      this.areaCode});

  EmergencyContactRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    sosContactType = json['sosContactType'];
    sosContactCode = json['sosContactCode'];
    areaCode = json['areaCode'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['sosContactType'] = this.sosContactType;
    data['sosContactCode'] = this.sosContactCode;
    data['areaCode'] = this.areaCode;
    return data;
  }
} */

// get sos contact response
class EmergencyContactResponse {
  List<SosContact> sosContact;

  EmergencyContactResponse({this.sosContact});

  EmergencyContactResponse.fromJson(Map<String, dynamic> json) {
    if (json['SosContact'] != null) {
      sosContact = new List<SosContact>();
      json['SosContact'].forEach((v) {
        sosContact.add(new SosContact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sosContact != null) {
      data['SosContact'] = this.sosContact.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 1, adapterName: 'EmergencyContactAdapter')
class SosContact {
  @HiveField(0)
  String iD;
  @HiveField(1)
  String sosContactType;
  @HiveField(2)
  String sosContactSubtype;
  @HiveField(3)
  String sosContactCode;
  @HiveField(4)
  String sosContactName;
  @HiveField(5)
  String add;
  @HiveField(6)
  String phone;
  @HiveField(7)
  String latitude;
  @HiveField(8)
  String longtitude;
  @HiveField(9)
  String areaCode;
  @HiveField(10)
  String skipCall;
  @HiveField(11)
  String createUser;
  @HiveField(12)
  String editUser;
  @HiveField(13)
  String editDate;
  @HiveField(14)
  dynamic compCode;
  @HiveField(15)
  dynamic branchCode;
  @HiveField(16)
  String rowKey;
  @HiveField(17)
  dynamic lastupload;
  @HiveField(18)
  String transtamp;
  @HiveField(19)
  String deleted;
  @HiveField(20)
  String lastEditedBy;
  @HiveField(21)
  String createdBy;
  @HiveField(22)
  String createDate;
  @HiveField(23)
  String remark;
  @HiveField(24)
  String distance;

  SosContact({
    this.iD,
    this.sosContactType,
    this.sosContactSubtype,
    this.sosContactCode,
    this.sosContactName,
    this.add,
    this.phone,
    this.latitude,
    this.longtitude,
    this.areaCode,
    this.skipCall,
    this.createUser,
    this.editUser,
    this.editDate,
    this.compCode,
    this.branchCode,
    this.rowKey,
    this.lastupload,
    this.transtamp,
    this.deleted,
    this.lastEditedBy,
    this.createdBy,
    this.createDate,
    this.remark,
    this.distance,
  });

  SosContact.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    sosContactType = json['sos_contact_type'];
    sosContactSubtype = json['sos_contact_subtype'];
    sosContactCode = json['sos_contact_code'];
    sosContactName = json['sos_contact_name'];
    add = json['add'];
    phone = json['phone'];
    latitude = json['latitude'];
    longtitude = json['longtitude'];
    areaCode = json['area_code'];
    skipCall = json['skip_call'];
    createUser = json['create_user'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    lastupload = json['lastupload'];
    transtamp = json['transtamp'];
    deleted = json['deleted'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
    createDate = json['create_date'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['sos_contact_type'] = this.sosContactType;
    data['sos_contact_subtype'] = this.sosContactSubtype;
    data['sos_contact_code'] = this.sosContactCode;
    data['sos_contact_name'] = this.sosContactName;
    data['add'] = this.add;
    data['phone'] = this.phone;
    data['latitude'] = this.latitude;
    data['longtitude'] = this.longtitude;
    data['area_code'] = this.areaCode;
    data['skip_call'] = this.skipCall;
    data['create_user'] = this.createUser;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['lastupload'] = this.lastupload;
    data['transtamp'] = this.transtamp;
    data['deleted'] = this.deleted;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    data['create_date'] = this.createDate;
    data['remark'] = this.remark;
    return data;
  }
}

/* @HiveType(typeId: 0)
class PoliceContact {
  @HiveField(0)
  final String sosContactType;

  @HiveField(1)
  final String sosContactSubtype;

  @HiveField(2)
  final String sosContactCode;

  @HiveField(3)
  final String sosContactName;

  @HiveField(4)
  final String add;

  @HiveField(5)
  final String phone;

  @HiveField(6)
  final String latitude;

  @HiveField(7)
  final String longitude;

  @HiveField(8)
  final String areaCode;

  @HiveField(9)
  final String skipCall;

  @HiveField(10)
  final String distance;

  PoliceContact({
    this.sosContactType,
    this.sosContactSubtype,
    this.sosContactCode,
    this.sosContactName,
    this.add,
    this.phone,
    this.latitude,
    this.longitude,
    this.areaCode,
    this.skipCall,
    this.distance,
  });
}

@HiveType(typeId: 0)
class AmbulanceContact {
  @HiveField(0)
  final String sosContactType;

  @HiveField(1)
  final String sosContactSubtype;

  @HiveField(2)
  final String sosContactCode;

  @HiveField(3)
  final String sosContactName;

  @HiveField(4)
  final String add;

  @HiveField(5)
  final String phone;

  @HiveField(6)
  final String latitude;

  @HiveField(7)
  final String longitude;

  @HiveField(8)
  final String areaCode;

  @HiveField(9)
  final String skipCall;

  @HiveField(10)
  final String distance;

  AmbulanceContact({
    this.sosContactType,
    this.sosContactSubtype,
    this.sosContactCode,
    this.sosContactName,
    this.add,
    this.phone,
    this.latitude,
    this.longitude,
    this.areaCode,
    this.skipCall,
    this.distance,
  });
}

@HiveType(typeId: 0)
class EmbassyContact {
  @HiveField(0)
  final String sosContactType;

  @HiveField(1)
  final String sosContactSubtype;

  @HiveField(2)
  final String sosContactCode;

  @HiveField(3)
  final String sosContactName;

  @HiveField(4)
  final String add;

  @HiveField(5)
  final String phone;

  @HiveField(6)
  final String latitude;

  @HiveField(7)
  final String longitude;

  @HiveField(8)
  final String areaCode;

  @HiveField(9)
  final String skipCall;

  @HiveField(10)
  final String distance;

  EmbassyContact({
    this.sosContactType,
    this.sosContactSubtype,
    this.sosContactCode,
    this.sosContactName,
    this.add,
    this.phone,
    this.latitude,
    this.longitude,
    this.areaCode,
    this.skipCall,
    this.distance,
  });
} */
