// Get Default SoS contact
class DefaultEmergencyContactResponse {
  List<SosContactHelpDesk>? sosContactHelpDesk;

  DefaultEmergencyContactResponse({this.sosContactHelpDesk});

  DefaultEmergencyContactResponse.fromJson(Map<String, dynamic> json) {
    if (json['SosContactHelpDesk'] != null) {
      sosContactHelpDesk = List<SosContactHelpDesk>.empty(growable: true);
      json['SosContactHelpDesk'].forEach((v) {
        sosContactHelpDesk!.add(SosContactHelpDesk.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sosContactHelpDesk != null) {
      data['SosContactHelpDesk'] =
          sosContactHelpDesk!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SosContactHelpDesk {
  String? sosCallPhone;
  String? sosSmsPhone;
  String? policeCallPhone;
  String? policeSmsPhone;
  String? ambulanceCallPhone;
  String? ambulanceSmsPhone;
  String? autoAssistCallPhone;
  String? autoAssistSmsPhone;
  String? sosSystemSmsPhone;
  String? locRequestPriority;
  String? locRequestFastestInterval;
  String? locRequestInterval;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sos_call_phone'] = sosCallPhone;
    data['sos_sms_phone'] = sosSmsPhone;
    data['police_call_phone'] = policeCallPhone;
    data['police_sms_phone'] = policeSmsPhone;
    data['ambulance_call_phone'] = ambulanceCallPhone;
    data['ambulance_sms_phone'] = ambulanceSmsPhone;
    data['auto_assist_call_phone'] = autoAssistCallPhone;
    data['auto_assist_sms_phone'] = autoAssistSmsPhone;
    data['sos_system_sms_phone'] = sosSystemSmsPhone;
    data['loc_request_priority'] = locRequestPriority;
    data['loc_request_fastest_interval'] = locRequestFastestInterval;
    data['loc_request_interval'] = locRequestInterval;
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
// class EmergencyContactResponse {
//   List<SosContact> sosContact;

//   EmergencyContactResponse({this.sosContact});

//   EmergencyContactResponse.fromJson(Map<String, dynamic> json) {
//     if (json['SosContact'] != null) {
//       sosContact = new List<SosContact>();
//       json['SosContact'].forEach((v) {
//         sosContact.add(new SosContact.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.sosContact != null) {
//       data['SosContact'] = this.sosContact.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// @HiveType(typeId: 1, adapterName: 'EmergencyContactAdapter')
// class SosContact {
//   @HiveField(0)
//   String iD;
//   @HiveField(1)
//   String sosContactType;
//   @HiveField(2)
//   String sosContactSubtype;
//   @HiveField(3)
//   String sosContactCode;
//   @HiveField(4)
//   String sosContactName;
//   @HiveField(5)
//   String add;
//   @HiveField(6)
//   String phone;
//   @HiveField(7)
//   String latitude;
//   @HiveField(8)
//   String longtitude;
//   @HiveField(9)
//   String areaCode;
//   @HiveField(10)
//   String skipCall;
//   @HiveField(11)
//   String createUser;
//   @HiveField(12)
//   String editUser;
//   @HiveField(13)
//   String editDate;
//   @HiveField(14)
//   dynamic compCode;
//   @HiveField(15)
//   dynamic branchCode;
//   @HiveField(16)
//   String rowKey;
//   @HiveField(17)
//   dynamic lastupload;
//   @HiveField(18)
//   String transtamp;
//   @HiveField(19)
//   String deleted;
//   @HiveField(20)
//   String lastEditedBy;
//   @HiveField(21)
//   String createdBy;
//   @HiveField(22)
//   String createDate;
//   @HiveField(23)
//   String remark;
//   @HiveField(24)
//   String distance;

//   SosContact({
//     this.iD,
//     this.sosContactType,
//     this.sosContactSubtype,
//     this.sosContactCode,
//     this.sosContactName,
//     this.add,
//     this.phone,
//     this.latitude,
//     this.longtitude,
//     this.areaCode,
//     this.skipCall,
//     this.createUser,
//     this.editUser,
//     this.editDate,
//     this.compCode,
//     this.branchCode,
//     this.rowKey,
//     this.lastupload,
//     this.transtamp,
//     this.deleted,
//     this.lastEditedBy,
//     this.createdBy,
//     this.createDate,
//     this.remark,
//     this.distance,
//   });

//   SosContact.fromJson(Map<String, dynamic> json) {
//     iD = json['ID'];
//     sosContactType = json['sos_contact_type'];
//     sosContactSubtype = json['sos_contact_subtype'];
//     sosContactCode = json['sos_contact_code'];
//     sosContactName = json['sos_contact_name'];
//     add = json['add'];
//     phone = json['phone'];
//     latitude = json['latitude'];
//     longtitude = json['longtitude'];
//     areaCode = json['area_code'];
//     skipCall = json['skip_call'];
//     createUser = json['create_user'];
//     editUser = json['edit_user'];
//     editDate = json['edit_date'];
//     compCode = json['comp_code'];
//     branchCode = json['branch_code'];
//     rowKey = json['row_key'];
//     lastupload = json['lastupload'];
//     transtamp = json['transtamp'];
//     deleted = json['deleted'];
//     lastEditedBy = json['last_edited_by'];
//     createdBy = json['created_by'];
//     createDate = json['create_date'];
//     remark = json['remark'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ID'] = this.iD;
//     data['sos_contact_type'] = this.sosContactType;
//     data['sos_contact_subtype'] = this.sosContactSubtype;
//     data['sos_contact_code'] = this.sosContactCode;
//     data['sos_contact_name'] = this.sosContactName;
//     data['add'] = this.add;
//     data['phone'] = this.phone;
//     data['latitude'] = this.latitude;
//     data['longtitude'] = this.longtitude;
//     data['area_code'] = this.areaCode;
//     data['skip_call'] = this.skipCall;
//     data['create_user'] = this.createUser;
//     data['edit_user'] = this.editUser;
//     data['edit_date'] = this.editDate;
//     data['comp_code'] = this.compCode;
//     data['branch_code'] = this.branchCode;
//     data['row_key'] = this.rowKey;
//     data['lastupload'] = this.lastupload;
//     data['transtamp'] = this.transtamp;
//     data['deleted'] = this.deleted;
//     data['last_edited_by'] = this.lastEditedBy;
//     data['created_by'] = this.createdBy;
//     data['create_date'] = this.createDate;
//     data['remark'] = this.remark;
//     return data;
//   }
// }

// GetSosContactSortByNearest
class GetSosContactSortByNearestResponse {
  List<SosContact>? sosContact;

  GetSosContactSortByNearestResponse({this.sosContact});

  GetSosContactSortByNearestResponse.fromJson(Map<String, dynamic> json) {
    if (json['SosContact'] != null) {
      sosContact = List<SosContact>.empty(growable: true);
      json['SosContact'].forEach((v) {
        sosContact!.add(SosContact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sosContact != null) {
      data['SosContact'] = sosContact!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SosContact {
  String? iD;
  String? sosContactType;
  String? sosContactSubtype;
  String? sosContactCode;
  String? sosContactName;
  String? add;
  String? phone;
  String? latitude;
  String? longtitude;
  String? areaCode;
  String? skipCall;
  String? remark;
  String? createUser;
  String? editUser;
  String? editDate;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? lastupload;
  String? transtamp;
  String? deleted;
  String? lastEditedBy;
  String? createdBy;
  String? distance;
  String? isEmpty;

  SosContact(
      {this.iD,
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
      this.remark,
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
      this.distance,
      this.isEmpty});

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
    remark = json['remark'];
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
    distance = json['distance'];
    isEmpty = json['isEmpty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['sos_contact_type'] = sosContactType;
    data['sos_contact_subtype'] = sosContactSubtype;
    data['sos_contact_code'] = sosContactCode;
    data['sos_contact_name'] = sosContactName;
    data['add'] = add;
    data['phone'] = phone;
    data['latitude'] = latitude;
    data['longtitude'] = longtitude;
    data['area_code'] = areaCode;
    data['skip_call'] = skipCall;
    data['remark'] = remark;
    data['create_user'] = createUser;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['lastupload'] = lastupload;
    data['transtamp'] = transtamp;
    data['deleted'] = deleted;
    data['last_edited_by'] = lastEditedBy;
    data['created_by'] = createdBy;
    data['distance'] = distance;
    data['isEmpty'] = isEmpty;
    return data;
  }
}

class GetPandemicPDFReportResponse {
  List<PDF>? pDF;

  GetPandemicPDFReportResponse({this.pDF});

  GetPandemicPDFReportResponse.fromJson(Map<String, dynamic> json) {
    if (json['PDF'] != null) {
      pDF = List<PDF>.empty(growable: true);
      json['PDF'].forEach((v) {
        pDF!.add(PDF.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pDF != null) {
      data['PDF'] = pDF!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PDF {
  String? fileName;

  PDF({this.fileName});

  PDF.fromJson(Map<String, dynamic> json) {
    fileName = json['file_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_name'] = fileName;
    return data;
  }
}

// GetPandemicTrack
class GetPandemicTrackResponse {
  List<PandemicTrack>? pandemicTrack;

  GetPandemicTrackResponse({this.pandemicTrack});

  GetPandemicTrackResponse.fromJson(Map<String, dynamic> json) {
    if (json['PandemicTrack'] != null) {
      pandemicTrack = List<PandemicTrack>.empty(growable: true);
      json['PandemicTrack'].forEach((v) {
        pandemicTrack!.add(PandemicTrack.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pandemicTrack != null) {
      data['PandemicTrack'] =
          pandemicTrack!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PandemicTrack {
  String? id;
  String? merchantNo;
  String? phone;
  String? name;
  String? trackingDate;
  String? trackingTime;
  String? bodyTemperature;
  String? scanCode;
  String? deleted;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? transtamp;
  String? lastupload;

  PandemicTrack(
      {this.id,
      this.merchantNo,
      this.phone,
      this.name,
      this.trackingDate,
      this.trackingTime,
      this.bodyTemperature,
      this.scanCode,
      this.deleted,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.transtamp,
      this.lastupload});

  PandemicTrack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantNo = json['merchant_no'];
    phone = json['phone'];
    name = json['name'];
    trackingDate = json['tracking_date'];
    trackingTime = json['tracking_time'];
    bodyTemperature = json['body_temperature'];
    scanCode = json['scan_code'];
    deleted = json['deleted'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
    lastupload = json['lastupload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_no'] = merchantNo;
    data['phone'] = phone;
    data['name'] = name;
    data['tracking_date'] = trackingDate;
    data['tracking_time'] = trackingTime;
    data['body_temperature'] = bodyTemperature;
    data['scan_code'] = scanCode;
    data['deleted'] = deleted;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['transtamp'] = transtamp;
    data['lastupload'] = lastupload;
    return data;
  }
}
