// Get Default SoS contact
class DefaultEmergencyContactResponse {
  GetDefaultSosContactResult getDefaultSosContactResult;

  DefaultEmergencyContactResponse({this.getDefaultSosContactResult});

  DefaultEmergencyContactResponse.fromJson(Map<String, dynamic> json) {
    getDefaultSosContactResult = json['GetDefaultSosContactResult'] != null
        ? new GetDefaultSosContactResult.fromJson(
            json['GetDefaultSosContactResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getDefaultSosContactResult != null) {
      data['GetDefaultSosContactResult'] =
          this.getDefaultSosContactResult.toJson();
    }
    return data;
  }
}

class GetDefaultSosContactResult {
  SosContactInfo sosContactInfo;

  GetDefaultSosContactResult({this.sosContactInfo});

  GetDefaultSosContactResult.fromJson(Map<String, dynamic> json) {
    sosContactInfo = json['SosContactInfo'] != null
        ? new SosContactInfo.fromJson(json['SosContactInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sosContactInfo != null) {
      data['SosContactInfo'] = this.sosContactInfo.toJson();
    }
    return data;
  }
}

class SosContactInfo {
  SosContactHelpDesk sosContactHelpDesk;

  SosContactInfo({this.sosContactHelpDesk});

  SosContactInfo.fromJson(Map<String, dynamic> json) {
    sosContactHelpDesk = json['SosContactHelpDesk'] != null
        ? new SosContactHelpDesk.fromJson(json['SosContactHelpDesk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sosContactHelpDesk != null) {
      data['SosContactHelpDesk'] = this.sosContactHelpDesk.toJson();
    }
    return data;
  }
}

class SosContactHelpDesk {
  Null sosCallPhone;
  Null sosSmsPhone;
  Null policeCallPhone;
  Null policeSmsPhone;
  Null ambulanceCallPhone;
  Null ambulanceSmsPhone;
  Null autoAssistCallPhone;
  Null autoAssistSmsPhone;
  Null sosSystemSmsPhone;
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
class EmergencyContactRequest {
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
}
