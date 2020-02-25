class GetWsUrlResponse {
  LoginAcctInfo loginAcctInfo;

  GetWsUrlResponse({this.loginAcctInfo});

  GetWsUrlResponse.fromJson(Map<String, dynamic> json) {
    loginAcctInfo = json['LoginAcctInfo'] != null
        ? new LoginAcctInfo.fromJson(json['LoginAcctInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loginAcctInfo != null) {
      data['LoginAcctInfo'] = this.loginAcctInfo.toJson();
    }
    return data;
  }
}

class LoginAcctInfo {
  LoginAcct loginAcct;

  LoginAcctInfo({this.loginAcct});

  LoginAcctInfo.fromJson(Map<String, dynamic> json) {
    loginAcct = json['LoginAcct'] != null
        ? new LoginAcct.fromJson(json['LoginAcct'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loginAcct != null) {
      data['LoginAcct'] = this.loginAcct.toJson();
    }
    return data;
  }
}

class LoginAcct {
  String loginAcctId;
  String acctUid;
  String acctPwd;
  String acctName;
  String acctStatus;
  String loginType;
  String loginIp;
  String loginUid;
  String loginPwd;
  String loginDb;
  String loginDir;
  String loginAcctno;
  String loginMisc;
  String loginPort;
  String checkLoginInterval;
  String deleted;
  String createUser;
  String editUser;
  String lastupload;
  String wsUrl;

  LoginAcct(
      {this.loginAcctId,
      this.acctUid,
      this.acctPwd,
      this.acctName,
      this.acctStatus,
      this.loginType,
      this.loginIp,
      this.loginUid,
      this.loginPwd,
      this.loginDb,
      this.loginDir,
      this.loginAcctno,
      this.loginMisc,
      this.loginPort,
      this.checkLoginInterval,
      this.deleted,
      this.createUser,
      this.editUser,
      this.lastupload,
      this.wsUrl});

  LoginAcct.fromJson(Map<String, dynamic> json) {
    loginAcctId = json['login_acct_id'];
    acctUid = json['acct_uid'];
    acctPwd = json['acct_pwd'];
    acctName = json['acct_name'];
    acctStatus = json['acct_status'];
    loginType = json['login_type'];
    loginIp = json['login_ip'];
    loginUid = json['login_uid'];
    loginPwd = json['login_pwd'];
    loginDb = json['login_db'];
    loginDir = json['login_dir'];
    loginAcctno = json['login_acctno'];
    loginMisc = json['login_misc'];
    loginPort = json['login_port'];
    checkLoginInterval = json['check_login_interval'];
    deleted = json['deleted'];
    createUser = json['create_user'];
    editUser = json['edit_user'];
    lastupload = json['lastupload'];
    wsUrl = json['WsUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_acct_id'] = this.loginAcctId;
    data['acct_uid'] = this.acctUid;
    data['acct_pwd'] = this.acctPwd;
    data['acct_name'] = this.acctName;
    data['acct_status'] = this.acctStatus;
    data['login_type'] = this.loginType;
    data['login_ip'] = this.loginIp;
    data['login_uid'] = this.loginUid;
    data['login_pwd'] = this.loginPwd;
    data['login_db'] = this.loginDb;
    data['login_dir'] = this.loginDir;
    data['login_acctno'] = this.loginAcctno;
    data['login_misc'] = this.loginMisc;
    data['login_port'] = this.loginPort;
    data['check_login_interval'] = this.checkLoginInterval;
    data['deleted'] = this.deleted;
    data['create_user'] = this.createUser;
    data['edit_user'] = this.editUser;
    data['lastupload'] = this.lastupload;
    data['WsUrl'] = this.wsUrl;
    return data;
  }
}

/* class LoginRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String diCode;
  String userPhone;
  String userPwd;
  String ipAddress;

  LoginRequest({
    this.wsCodeCrypt,
    this.caUid,
    this.caPwd,
    this.diCode,
    this.userPhone,
    this.userPwd,
    this.ipAddress,
  });

  LoginRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    userPhone = json['userPhone'];
    userPwd = json['userPwd'];
    ipAddress = json['ipAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['userPhone'] = this.userPhone;
    data['userPwd'] = this.userPwd;
    data['ipAddress'] = this.ipAddress;
    return data;
  }
} */

// LoginResponse
class LoginResponse {
  List<Table1> table1;

  LoginResponse({this.table1});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json['Table1'] != null) {
      table1 = new List<Table1>();
      json['Table1'].forEach((v) {
        table1.add(new Table1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table1 != null) {
      data['Table1'] = this.table1.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table1 {
  String userId;
  String sessionId;
  String msg;

  Table1({this.userId, this.sessionId, this.msg});

  Table1.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    sessionId = json['sessionId'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['sessionId'] = this.sessionId;
    data['msg'] = this.msg;
    return data;
  }
}

// End LoginResponse

/* class UserRegisteredDiRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String diCode;
  String userId;

  UserRegisteredDiRequest(
      {this.wsCodeCrypt, this.caUid, this.caPwd, this.diCode, this.userId});

  UserRegisteredDiRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['userId'] = this.userId;
    return data;
  }
} */

// UserRegisteredDiResponse
class UserRegisteredDiResponse {
  List<Armaster> armaster;

  UserRegisteredDiResponse({this.armaster});

  UserRegisteredDiResponse.fromJson(Map<String, dynamic> json) {
    if (json['Armaster'] != null) {
      armaster = new List<Armaster>();
      json['Armaster'].forEach((v) {
        armaster.add(new Armaster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.armaster != null) {
      data['Armaster'] = this.armaster.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Armaster {
  String iD;
  String diCode;
  String distributor;
  String masterAgent;
  String sponsor;
  String dbcode;
  String userType;
  String level;
  String inviteSms;
  String appBackgroundPhoto;
  String appBackgroundPhotoFilename;
  String appBackgroundPhotoPath;
  String playStorePath;
  String url;
  String acctUid;
  String acctPwd;
  String name;
  String nickName;
  String compName;
  dynamic add;
  String postcode;
  String state;
  String country;
  String currency;
  String idType;
  String icNo;
  String passportNo;
  String birthDate;
  String nationality;
  String gender;
  String phone;
  String phoneCountryCode;
  String mobilePlan;
  String telco;
  String eMail;
  String authorizationCode;
  String mobileTopupPin;
  String remittanceTopupPin;
  String securityQuestion;
  String securityAnswer;
  String securityAnswerAttempt;
  String authorizationName;
  String authorizationPhone;
  String authorizationPhoneCountryCode;
  String authorizationEmail;
  String commRate;
  String commRateUom;
  String compBrn;
  String organisationType;
  String fax;
  String bankName;
  String bankAdd;
  String bankAccNo;
  String creditCardNo;
  String creditCardName;
  String creditCardIssueBank;
  String creditCardCv;
  String felmoWalletId;
  String felmoWalletExpdt;
  String finexusWalletId;
  String finexusWalletExpdt;
  String finexusUrn;
  String signaturePhotoFilename;
  String hotWalletId;
  String hotWalletExpdt;
  String mpayCardNo;
  String mpayCardNoToken;
  String mpayCardNo2;
  String mpayCardNoToken2;
  String mpayId;
  String bankAccType;
  String ptcName;
  String ptcPosition;
  String ptcPhone;
  String ptcPhoneCountryCode;
  String ptcOff;
  String ptcOffCountryCode;
  String ptcEMail;
  String districtOperate;
  String corporateName;
  String corporateIcNo;
  String deviceId;
  String appPw;
  String lowCreditAlert;
  String criticalAirtimeAlert;
  String remindAirtimeAlert;
  String criticalAirtimePhone;
  String criticalAirtimePhoneCountryCode;
  String remindAirtimePhone;
  String remindAirtimePhoneCountryCode;
  String airtimeMarkupRate;
  String finnetMerchantId;
  String finnetPwd;
  String remark1;
  String remark2;
  String remark3;
  String createUser;
  String editUser;
  String deleted;
  String diName;

  Armaster(
      {this.iD,
      this.diCode,
      this.distributor,
      this.masterAgent,
      this.sponsor,
      this.dbcode,
      this.userType,
      this.level,
      this.inviteSms,
      this.appBackgroundPhoto,
      this.appBackgroundPhotoFilename,
      this.appBackgroundPhotoPath,
      this.playStorePath,
      this.url,
      this.acctUid,
      this.acctPwd,
      this.name,
      this.nickName,
      this.compName,
      this.add,
      this.postcode,
      this.state,
      this.country,
      this.currency,
      this.idType,
      this.icNo,
      this.passportNo,
      this.birthDate,
      this.nationality,
      this.gender,
      this.phone,
      this.phoneCountryCode,
      this.mobilePlan,
      this.telco,
      this.eMail,
      this.authorizationCode,
      this.mobileTopupPin,
      this.remittanceTopupPin,
      this.securityQuestion,
      this.securityAnswer,
      this.securityAnswerAttempt,
      this.authorizationName,
      this.authorizationPhone,
      this.authorizationPhoneCountryCode,
      this.authorizationEmail,
      this.commRate,
      this.commRateUom,
      this.compBrn,
      this.organisationType,
      this.fax,
      this.bankName,
      this.bankAdd,
      this.bankAccNo,
      this.creditCardNo,
      this.creditCardName,
      this.creditCardIssueBank,
      this.creditCardCv,
      this.felmoWalletId,
      this.felmoWalletExpdt,
      this.finexusWalletId,
      this.finexusWalletExpdt,
      this.finexusUrn,
      this.signaturePhotoFilename,
      this.hotWalletId,
      this.hotWalletExpdt,
      this.mpayCardNo,
      this.mpayCardNoToken,
      this.mpayCardNo2,
      this.mpayCardNoToken2,
      this.mpayId,
      this.bankAccType,
      this.ptcName,
      this.ptcPosition,
      this.ptcPhone,
      this.ptcPhoneCountryCode,
      this.ptcOff,
      this.ptcOffCountryCode,
      this.ptcEMail,
      this.districtOperate,
      this.corporateName,
      this.corporateIcNo,
      this.deviceId,
      this.appPw,
      this.lowCreditAlert,
      this.criticalAirtimeAlert,
      this.remindAirtimeAlert,
      this.criticalAirtimePhone,
      this.criticalAirtimePhoneCountryCode,
      this.remindAirtimePhone,
      this.remindAirtimePhoneCountryCode,
      this.airtimeMarkupRate,
      this.finnetMerchantId,
      this.finnetPwd,
      this.remark1,
      this.remark2,
      this.remark3,
      this.createUser,
      this.editUser,
      this.deleted,
      this.diName});

  Armaster.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    diCode = json['di_code'];
    distributor = json['distributor'];
    masterAgent = json['master_agent'];
    sponsor = json['sponsor'];
    dbcode = json['dbcode'];
    userType = json['user_type'];
    level = json['level'];
    inviteSms = json['invite_sms'];
    appBackgroundPhoto = json['app_background_photo'];
    appBackgroundPhotoFilename = json['app_background_photo_filename'];
    appBackgroundPhotoPath = json['app_background_photo_path'];
    playStorePath = json['play_store_path'];
    url = json['url'];
    acctUid = json['acct_uid'];
    acctPwd = json['acct_pwd'];
    name = json['name'];
    nickName = json['nick_name'];
    compName = json['comp_name'];
    add = json['add'];
    postcode = json['postcode'];
    state = json['state'];
    country = json['country'];
    currency = json['currency'];
    idType = json['id_type'];
    icNo = json['ic_no'];
    passportNo = json['passport_no'];
    birthDate = json['birth_date'];
    nationality = json['nationality'];
    gender = json['gender'];
    phone = json['phone'];
    phoneCountryCode = json['phone_country_code'];
    mobilePlan = json['mobile_plan'];
    telco = json['telco'];
    eMail = json['e_mail'];
    authorizationCode = json['authorization_code'];
    mobileTopupPin = json['mobile_topup_pin'];
    remittanceTopupPin = json['remittance_topup_pin'];
    securityQuestion = json['security_question'];
    securityAnswer = json['security_answer'];
    securityAnswerAttempt = json['security_answer_attempt'];
    authorizationName = json['authorization_name'];
    authorizationPhone = json['authorization_phone'];
    authorizationPhoneCountryCode = json['authorization_phone_country_code'];
    authorizationEmail = json['authorization_email'];
    commRate = json['comm_rate'];
    commRateUom = json['comm_rate_uom'];
    compBrn = json['comp_brn'];
    organisationType = json['organisation_type'];
    fax = json['fax'];
    bankName = json['bank_name'];
    bankAdd = json['bank_add'];
    bankAccNo = json['bank_acc_no'];
    creditCardNo = json['credit_card_no'];
    creditCardName = json['credit_card_name'];
    creditCardIssueBank = json['credit_card_issue_bank'];
    creditCardCv = json['credit_card_cv'];
    felmoWalletId = json['felmo_wallet_id'];
    felmoWalletExpdt = json['felmo_wallet_expdt'];
    finexusWalletId = json['finexus_wallet_id'];
    finexusWalletExpdt = json['finexus_wallet_expdt'];
    finexusUrn = json['finexus_urn'];
    signaturePhotoFilename = json['signature_photo_filename'];
    hotWalletId = json['hot_wallet_id'];
    hotWalletExpdt = json['hot_wallet_expdt'];
    mpayCardNo = json['mpay_card_no'];
    mpayCardNoToken = json['mpay_card_no_token'];
    mpayCardNo2 = json['mpay_card_no2'];
    mpayCardNoToken2 = json['mpay_card_no_token2'];
    mpayId = json['mpay_id'];
    bankAccType = json['bank_acc_type'];
    ptcName = json['ptc_name'];
    ptcPosition = json['ptc_position'];
    ptcPhone = json['ptc_phone'];
    ptcPhoneCountryCode = json['ptc_phone_country_code'];
    ptcOff = json['ptc_off'];
    ptcOffCountryCode = json['ptc_off_country_code'];
    ptcEMail = json['ptc_e_mail'];
    districtOperate = json['district_operate'];
    corporateName = json['corporate_name'];
    corporateIcNo = json['corporate_ic_no'];
    deviceId = json['device_id'];
    appPw = json['app_pw'];
    lowCreditAlert = json['low_credit_alert'];
    criticalAirtimeAlert = json['critical_airtime_alert'];
    remindAirtimeAlert = json['remind_airtime_alert'];
    criticalAirtimePhone = json['critical_airtime_phone'];
    criticalAirtimePhoneCountryCode =
        json['critical_airtime_phone_country_code'];
    remindAirtimePhone = json['remind_airtime_phone'];
    remindAirtimePhoneCountryCode = json['remind_airtime_phone_country_code'];
    airtimeMarkupRate = json['airtime_markup_rate'];
    finnetMerchantId = json['finnet_merchant_id'];
    finnetPwd = json['finnet_pwd'];
    remark1 = json['remark1'];
    remark2 = json['remark2'];
    remark3 = json['remark3'];
    createUser = json['create_user'];
    editUser = json['edit_user'];
    deleted = json['deleted'];
    diName = json['di_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['di_code'] = this.diCode;
    data['distributor'] = this.distributor;
    data['master_agent'] = this.masterAgent;
    data['sponsor'] = this.sponsor;
    data['dbcode'] = this.dbcode;
    data['user_type'] = this.userType;
    data['level'] = this.level;
    data['invite_sms'] = this.inviteSms;
    data['app_background_photo'] = this.appBackgroundPhoto;
    data['app_background_photo_filename'] = this.appBackgroundPhotoFilename;
    data['app_background_photo_path'] = this.appBackgroundPhotoPath;
    data['play_store_path'] = this.playStorePath;
    data['url'] = this.url;
    data['acct_uid'] = this.acctUid;
    data['acct_pwd'] = this.acctPwd;
    data['name'] = this.name;
    data['nick_name'] = this.nickName;
    data['comp_name'] = this.compName;
    data['add'] = this.add;
    data['postcode'] = this.postcode;
    data['state'] = this.state;
    data['country'] = this.country;
    data['currency'] = this.currency;
    data['id_type'] = this.idType;
    data['ic_no'] = this.icNo;
    data['passport_no'] = this.passportNo;
    data['birth_date'] = this.birthDate;
    data['nationality'] = this.nationality;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['phone_country_code'] = this.phoneCountryCode;
    data['mobile_plan'] = this.mobilePlan;
    data['telco'] = this.telco;
    data['e_mail'] = this.eMail;
    data['authorization_code'] = this.authorizationCode;
    data['mobile_topup_pin'] = this.mobileTopupPin;
    data['remittance_topup_pin'] = this.remittanceTopupPin;
    data['security_question'] = this.securityQuestion;
    data['security_answer'] = this.securityAnswer;
    data['security_answer_attempt'] = this.securityAnswerAttempt;
    data['authorization_name'] = this.authorizationName;
    data['authorization_phone'] = this.authorizationPhone;
    data['authorization_phone_country_code'] =
        this.authorizationPhoneCountryCode;
    data['authorization_email'] = this.authorizationEmail;
    data['comm_rate'] = this.commRate;
    data['comm_rate_uom'] = this.commRateUom;
    data['comp_brn'] = this.compBrn;
    data['organisation_type'] = this.organisationType;
    data['fax'] = this.fax;
    data['bank_name'] = this.bankName;
    data['bank_add'] = this.bankAdd;
    data['bank_acc_no'] = this.bankAccNo;
    data['credit_card_no'] = this.creditCardNo;
    data['credit_card_name'] = this.creditCardName;
    data['credit_card_issue_bank'] = this.creditCardIssueBank;
    data['credit_card_cv'] = this.creditCardCv;
    data['felmo_wallet_id'] = this.felmoWalletId;
    data['felmo_wallet_expdt'] = this.felmoWalletExpdt;
    data['finexus_wallet_id'] = this.finexusWalletId;
    data['finexus_wallet_expdt'] = this.finexusWalletExpdt;
    data['finexus_urn'] = this.finexusUrn;
    data['signature_photo_filename'] = this.signaturePhotoFilename;
    data['hot_wallet_id'] = this.hotWalletId;
    data['hot_wallet_expdt'] = this.hotWalletExpdt;
    data['mpay_card_no'] = this.mpayCardNo;
    data['mpay_card_no_token'] = this.mpayCardNoToken;
    data['mpay_card_no2'] = this.mpayCardNo2;
    data['mpay_card_no_token2'] = this.mpayCardNoToken2;
    data['mpay_id'] = this.mpayId;
    data['bank_acc_type'] = this.bankAccType;
    data['ptc_name'] = this.ptcName;
    data['ptc_position'] = this.ptcPosition;
    data['ptc_phone'] = this.ptcPhone;
    data['ptc_phone_country_code'] = this.ptcPhoneCountryCode;
    data['ptc_off'] = this.ptcOff;
    data['ptc_off_country_code'] = this.ptcOffCountryCode;
    data['ptc_e_mail'] = this.ptcEMail;
    data['district_operate'] = this.districtOperate;
    data['corporate_name'] = this.corporateName;
    data['corporate_ic_no'] = this.corporateIcNo;
    data['device_id'] = this.deviceId;
    data['app_pw'] = this.appPw;
    data['low_credit_alert'] = this.lowCreditAlert;
    data['critical_airtime_alert'] = this.criticalAirtimeAlert;
    data['remind_airtime_alert'] = this.remindAirtimeAlert;
    data['critical_airtime_phone'] = this.criticalAirtimePhone;
    data['critical_airtime_phone_country_code'] =
        this.criticalAirtimePhoneCountryCode;
    data['remind_airtime_phone'] = this.remindAirtimePhone;
    data['remind_airtime_phone_country_code'] =
        this.remindAirtimePhoneCountryCode;
    data['airtime_markup_rate'] = this.airtimeMarkupRate;
    data['finnet_merchant_id'] = this.finnetMerchantId;
    data['finnet_pwd'] = this.finnetPwd;
    data['remark1'] = this.remark1;
    data['remark2'] = this.remark2;
    data['remark3'] = this.remark3;
    data['create_user'] = this.createUser;
    data['edit_user'] = this.editUser;
    data['deleted'] = this.deleted;
    data['di_name'] = this.diName;
    return data;
  }
}

// End UserRegisteredDiResponse

// Register
class RegisterRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String appCode;
  String diCode;
  String userId;
  String name;
  String icNo;
  String passportNo;
  String phoneCountryCode;
  String phone;
  String nationality;
  String dateOfBirthString;
  String gender;
  String race;
  String add1;
  String add2;
  String add3;
  String postcode;
  String city;
  String state;
  String country;
  String email;

  RegisterRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.appCode,
      this.diCode,
      this.userId,
      this.name,
      this.icNo,
      this.passportNo,
      this.phoneCountryCode,
      this.phone,
      this.nationality,
      this.dateOfBirthString,
      this.gender,
      this.race,
      this.add1,
      this.add2,
      this.add3,
      this.postcode,
      this.city,
      this.state,
      this.country,
      this.email});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    appCode = json['appCode'];
    diCode = json['diCode'];
    userId = json['userId'];
    name = json['name'];
    icNo = json['icNo'];
    passportNo = json['passportNo'];
    phoneCountryCode = json['phoneCountryCode'];
    phone = json['phone'];
    nationality = json['nationality'];
    dateOfBirthString = json['dateOfBirthString'];
    gender = json['gender'];
    race = json['race'];
    add1 = json['add1'];
    add2 = json['add2'];
    add3 = json['add3'];
    postcode = json['postcode'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['appCode'] = this.appCode;
    data['diCode'] = this.diCode;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['icNo'] = this.icNo;
    data['passportNo'] = this.passportNo;
    data['phoneCountryCode'] = this.phoneCountryCode;
    data['phone'] = this.phone;
    data['nationality'] = this.nationality;
    data['dateOfBirthString'] = this.dateOfBirthString;
    data['gender'] = this.gender;
    data['race'] = this.race;
    data['add1'] = this.add1;
    data['add2'] = this.add2;
    data['add3'] = this.add3;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['email'] = this.email;
    return data;
  }
}

class SaveUserPasswordRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String userId;
  String password;

  SaveUserPasswordRequest(
      {this.wsCodeCrypt, this.caUid, this.caPwd, this.userId, this.password});

  SaveUserPasswordRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    userId = json['userId'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['userId'] = this.userId;
    data['password'] = this.password;
    return data;
  }
}

// GetDiList

class GetDiListResponse {
  List<ArmasterProfile> armasterProfile;

  GetDiListResponse({this.armasterProfile});

  GetDiListResponse.fromJson(Map<String, dynamic> json) {
    if (json['ArmasterProfile'] != null) {
      armasterProfile = new List<ArmasterProfile>();
      json['ArmasterProfile'].forEach((v) {
        armasterProfile.add(new ArmasterProfile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.armasterProfile != null) {
      data['ArmasterProfile'] =
          this.armasterProfile.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArmasterProfile {
  String diCode;
  String distributor;
  String masterAgent;
  String sponsor;
  String dbcode;
  String userType;
  String name;
  String add;
  String postcode;
  String state;
  String country;
  String icNo;
  String passportNo;
  String nationality;
  String gender;
  String phone;
  String phoneCountryCode;
  String eMail;
  String appBackgroundPhotoFilename;
  String appBackgroundPhotoPath;
  String diName;
  String nickName;

  ArmasterProfile(
      {this.diCode,
      this.distributor,
      this.masterAgent,
      this.sponsor,
      this.dbcode,
      this.userType,
      this.name,
      this.add,
      this.postcode,
      this.state,
      this.country,
      this.icNo,
      this.passportNo,
      this.nationality,
      this.gender,
      this.phone,
      this.phoneCountryCode,
      this.eMail,
      this.appBackgroundPhotoFilename,
      this.appBackgroundPhotoPath,
      this.diName,
      this.nickName});

  ArmasterProfile.fromJson(Map<String, dynamic> json) {
    diCode = json['di_code'];
    distributor = json['distributor'];
    masterAgent = json['master_agent'];
    sponsor = json['sponsor'];
    dbcode = json['dbcode'];
    userType = json['user_type'];
    name = json['name'];
    add = json['add'];
    postcode = json['postcode'];
    state = json['state'];
    country = json['country'];
    icNo = json['ic_no'];
    passportNo = json['passport_no'];
    nationality = json['nationality'];
    gender = json['gender'];
    phone = json['phone'];
    phoneCountryCode = json['phone_country_code'];
    eMail = json['e_mail'];
    appBackgroundPhotoFilename = json['app_background_photo_filename'];
    appBackgroundPhotoPath = json['app_background_photo_path'];
    diName = json['di_name'];
    nickName = json['nick_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['di_code'] = this.diCode;
    data['distributor'] = this.distributor;
    data['master_agent'] = this.masterAgent;
    data['sponsor'] = this.sponsor;
    data['dbcode'] = this.dbcode;
    data['user_type'] = this.userType;
    data['name'] = this.name;
    data['add'] = this.add;
    data['postcode'] = this.postcode;
    data['state'] = this.state;
    data['country'] = this.country;
    data['ic_no'] = this.icNo;
    data['passport_no'] = this.passportNo;
    data['nationality'] = this.nationality;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['phone_country_code'] = this.phoneCountryCode;
    data['e_mail'] = this.eMail;
    data['app_background_photo_filename'] = this.appBackgroundPhotoFilename;
    data['app_background_photo_path'] = this.appBackgroundPhotoPath;
    data['di_name'] = this.diName;
    data['nick_name'] = this.nickName;
    return data;
  }
}

// GetGroupIdByDiCodeForOnline

class GetGroupIdByDiCodeForOnlineResponse {
  List<Dgroup> dgroup;

  GetGroupIdByDiCodeForOnlineResponse({this.dgroup});

  GetGroupIdByDiCodeForOnlineResponse.fromJson(Map<String, dynamic> json) {
    if (json['Dgroup'] != null) {
      dgroup = new List<Dgroup>();
      json['Dgroup'].forEach((v) {
        dgroup.add(new Dgroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dgroup != null) {
      data['Dgroup'] = this.dgroup.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dgroup {
  String groupId;
  String grpDesc;
  String tranCateg;
  String defaAmt;
  String handChrg;
  String servChrg;
  String servTax;
  String taxCode;
  String priceIncludeGst;
  String transtamp;
  String totalTime;
  String serialType;
  String commAmt;
  String agentCommAmt;
  String cshSlsAcct;
  String cshSlsDept;
  String lesenType;
  String onlineEnroll;
  String productCode;
  String productDesc1;
  String productDesc2;
  String fee;
  String defaultPictureFilename;
  String diCode;
  String compCode;
  String branchCode;
  String lastupload;
  String deleted;

  Dgroup(
      {this.groupId,
      this.grpDesc,
      this.tranCateg,
      this.defaAmt,
      this.handChrg,
      this.servChrg,
      this.servTax,
      this.taxCode,
      this.priceIncludeGst,
      this.transtamp,
      this.totalTime,
      this.serialType,
      this.commAmt,
      this.agentCommAmt,
      this.cshSlsAcct,
      this.cshSlsDept,
      this.lesenType,
      this.onlineEnroll,
      this.productCode,
      this.productDesc1,
      this.productDesc2,
      this.fee,
      this.defaultPictureFilename,
      this.diCode,
      this.compCode,
      this.branchCode,
      this.lastupload,
      this.deleted});

  Dgroup.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    grpDesc = json['grp_desc'];
    tranCateg = json['tran_categ'];
    defaAmt = json['defa_amt'];
    handChrg = json['hand_chrg'];
    servChrg = json['serv_chrg'];
    servTax = json['serv_tax'];
    taxCode = json['tax_code'];
    priceIncludeGst = json['price_include_gst'];
    transtamp = json['transtamp'];
    totalTime = json['total_time'];
    serialType = json['serial_type'];
    commAmt = json['comm_amt'];
    agentCommAmt = json['agent_comm_amt'];
    cshSlsAcct = json['csh_sls_acct'];
    cshSlsDept = json['csh_sls_dept'];
    lesenType = json['lesen_type'];
    onlineEnroll = json['online_enroll'];
    productCode = json['product_code'];
    productDesc1 = json['product_desc1'];
    productDesc2 = json['product_desc2'];
    fee = json['fee'];
    defaultPictureFilename = json['default_picture_filename'];
    diCode = json['di_code'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    lastupload = json['lastupload'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['grp_desc'] = this.grpDesc;
    data['tran_categ'] = this.tranCateg;
    data['defa_amt'] = this.defaAmt;
    data['hand_chrg'] = this.handChrg;
    data['serv_chrg'] = this.servChrg;
    data['serv_tax'] = this.servTax;
    data['tax_code'] = this.taxCode;
    data['price_include_gst'] = this.priceIncludeGst;
    data['transtamp'] = this.transtamp;
    data['total_time'] = this.totalTime;
    data['serial_type'] = this.serialType;
    data['comm_amt'] = this.commAmt;
    data['agent_comm_amt'] = this.agentCommAmt;
    data['csh_sls_acct'] = this.cshSlsAcct;
    data['csh_sls_dept'] = this.cshSlsDept;
    data['lesen_type'] = this.lesenType;
    data['online_enroll'] = this.onlineEnroll;
    data['product_code'] = this.productCode;
    data['product_desc1'] = this.productDesc1;
    data['product_desc2'] = this.productDesc2;
    data['fee'] = this.fee;
    data['default_picture_filename'] = this.defaultPictureFilename;
    data['di_code'] = this.diCode;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['lastupload'] = this.lastupload;
    data['deleted'] = this.deleted;
    return data;
  }
}

class SaveEnrollmentRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String diCode;
  String icNo;
  String groupId;
  String userId;

  SaveEnrollmentRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.diCode,
      this.icNo,
      this.groupId,
      this.userId});

  SaveEnrollmentRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    icNo = json['icNo'];
    groupId = json['groupId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['icNo'] = this.icNo;
    data['groupId'] = this.groupId;
    data['userId'] = this.userId;
    return data;
  }
}

class EnrollmentArguments {
  final String diCode;
  final String groupId;

  EnrollmentArguments({this.diCode, this.groupId});
}
