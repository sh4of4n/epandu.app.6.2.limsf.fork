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

// Invite Friends
/* class CreateAppAccount {
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

  CreateAppAccount(
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

  CreateAppAccount.fromJson(Map<String, dynamic> json) {
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
} */

class CreateAppAccountWithAppIdRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String appCode;
  String appId;
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

  CreateAppAccountWithAppIdRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.appCode,
      this.appId,
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

  CreateAppAccountWithAppIdRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    appCode = json['appCode'];
    appId = json['appId'];
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
    data['appId'] = this.appId;
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
  String appCode;
  String appId;
  String userId;
  String password;

  SaveUserPasswordRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.appCode,
      this.appId,
      this.userId,
      this.password});

  SaveUserPasswordRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    appCode = json['appCode'];
    appId = json['appId'];
    userId = json['userId'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['appCode'] = this.appCode;
    data['appId'] = this.appId;
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
    if (json['Armaster'] != null) {
      armasterProfile = new List<ArmasterProfile>();
      json['Armaster'].forEach((v) {
        armasterProfile.add(new ArmasterProfile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.armasterProfile != null) {
      data['Armaster'] = this.armasterProfile.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArmasterProfile {
  String iD;
  String diCode;
  String distributor;
  String masterAgent;
  String sponsor;
  String dbcode;
  String userType;
  String level;
  String inviteSms;
  String appBackgroundPhotoFilename;
  String appBackgroundPhotoPath;
  String playStorePath;
  String url;
  String acctUid;
  String acctPwd;
  String name;
  String nickName;
  String compName;
  String add;
  String postcode;
  String state;
  String country;
  String currency;
  String idType;
  String icNo;
  String passportNo;
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

  ArmasterProfile(
      {this.iD,
      this.diCode,
      this.distributor,
      this.masterAgent,
      this.sponsor,
      this.dbcode,
      this.userType,
      this.level,
      this.inviteSms,
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
      this.deleted});

  ArmasterProfile.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    diCode = json['di_code'];
    distributor = json['distributor'];
    masterAgent = json['master_agent'];
    sponsor = json['sponsor'];
    dbcode = json['dbcode'];
    userType = json['user_type'];
    level = json['level'];
    inviteSms = json['invite_sms'];
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

// Save enrollment
class SaveEnrollmentRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String diCode;
  String groupId;
  String icNo;
  String name;
  String nationality;
  String phoneCountryCode;
  String phone;
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
  String userId;

  SaveEnrollmentRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.diCode,
      this.groupId,
      this.icNo,
      this.name,
      this.nationality,
      this.phoneCountryCode,
      this.phone,
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
      this.email,
      this.userId});

  SaveEnrollmentRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    groupId = json['groupId'];
    icNo = json['icNo'];
    name = json['name'];
    nationality = json['nationality'];
    phoneCountryCode = json['phoneCountryCode'];
    phone = json['phone'];
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
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['groupId'] = this.groupId;
    data['icNo'] = this.icNo;
    data['name'] = this.name;
    data['nationality'] = this.nationality;
    data['phoneCountryCode'] = this.phoneCountryCode;
    data['phone'] = this.phone;
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
    data['userId'] = this.userId;
    return data;
  }
}

class EnrollmentArguments {
  final String diCode;
  final String groupId;

  EnrollmentArguments({this.diCode, this.groupId});
}

// GetActiveFeedResponse
class GetActiveFeedResponse {
  List<Feed> feed;

  GetActiveFeedResponse({this.feed});

  GetActiveFeedResponse.fromJson(Map<String, dynamic> json) {
    if (json['Feed'] != null) {
      feed = new List<Feed>();
      json['Feed'].forEach((v) {
        feed.add(new Feed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feed != null) {
      data['Feed'] = this.feed.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feed {
  String iD;
  String docDoc;
  String docRef;
  String feedDoc;
  String feedRef;
  String feedDesc;
  String bgDate;
  String durationDay;
  String active;
  String rowKey;
  String feedText;
  String feedMediaFilename;
  String feedNavigate;
  String merchantNo;
  String localFeed;
  String createUser;
  String editUser;
  String editDate;
  String deleted;
  String transtamp;

  Feed(
      {this.iD,
      this.docDoc,
      this.docRef,
      this.feedDoc,
      this.feedRef,
      this.feedDesc,
      this.bgDate,
      this.durationDay,
      this.active,
      this.rowKey,
      this.feedText,
      this.feedMediaFilename,
      this.feedNavigate,
      this.merchantNo,
      this.localFeed,
      this.createUser,
      this.editUser,
      this.editDate,
      this.deleted,
      this.transtamp});

  Feed.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    feedDoc = json['feed_doc'];
    feedRef = json['feed_ref'];
    feedDesc = json['feed_desc'];
    bgDate = json['bg_date'];
    durationDay = json['duration_day'];
    active = json['active'];
    rowKey = json['row_key'];
    feedText = json['feed_text'];
    feedMediaFilename = json['feed_media_filename'];
    feedNavigate = json['feed_navigate'];
    merchantNo = json['merchant_no'];
    localFeed = json['local_feed'];
    createUser = json['create_user'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    transtamp = json['transtamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['doc_doc'] = this.docDoc;
    data['doc_ref'] = this.docRef;
    data['feed_doc'] = this.feedDoc;
    data['feed_ref'] = this.feedRef;
    data['feed_desc'] = this.feedDesc;
    data['bg_date'] = this.bgDate;
    data['duration_day'] = this.durationDay;
    data['active'] = this.active;
    data['row_key'] = this.rowKey;
    data['feed_text'] = this.feedText;
    data['feed_media_filename'] = this.feedMediaFilename;
    data['feed_navigate'] = this.feedNavigate;
    data['merchant_no'] = this.merchantNo;
    data['local_feed'] = this.localFeed;
    data['create_user'] = this.createUser;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['deleted'] = this.deleted;
    data['transtamp'] = this.transtamp;
    return data;
  }
}

// GetEnrollHistoryResponse
class GetEnrollHistoryResponse {
  List<Enroll> enroll;

  GetEnrollHistoryResponse({this.enroll});

  GetEnrollHistoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['Enroll'] != null) {
      enroll = new List<Enroll>();
      json['Enroll'].forEach((v) {
        enroll.add(new Enroll.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.enroll != null) {
      data['Enroll'] = this.enroll.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Enroll {
  String id;
  String icNo;
  String trandate;
  String groupId;
  String kppGroupId;
  String kppGroupId2;
  String kppGroupId3;
  String blacklisted;
  String stuNo;
  String dsCode;
  String employeNo;
  String introBy;
  String commType;
  String feesAgree;
  String hrsAgree;
  String addhrChrg;
  String promptTes;
  String totalPaid;
  String retest;
  String certNo;
  String remark;
  String tlHrsTak;
  String exclIncml;
  String sm4No;
  String pickupPoint;
  String transtamp;
  String epretCode;
  String epretReqid;
  String ekppCode;
  String ekppReqid;
  String ej2bStat;
  String eserRemark;
  String ej2aTick;
  String ej2bTick;
  String addClass;
  String userId;
  String kpp02CertNo;
  String kpp02CertPath;
  String l2aPrnCount;
  String l2bPrnCount;
  String sm4PrnCount;
  String deleted;
  String productCode;
  String diCode;
  String compCode;
  String branchCode;
  String lastupload;
  String status;
  String fee;
  String totalTime;
  String name;
  String sex;
  String race;
  String birthDt;
  String citizenship;

  Enroll(
      {this.id,
      this.icNo,
      this.trandate,
      this.groupId,
      this.kppGroupId,
      this.kppGroupId2,
      this.kppGroupId3,
      this.blacklisted,
      this.stuNo,
      this.dsCode,
      this.employeNo,
      this.introBy,
      this.commType,
      this.feesAgree,
      this.hrsAgree,
      this.addhrChrg,
      this.promptTes,
      this.totalPaid,
      this.retest,
      this.certNo,
      this.remark,
      this.tlHrsTak,
      this.exclIncml,
      this.sm4No,
      this.pickupPoint,
      this.transtamp,
      this.epretCode,
      this.epretReqid,
      this.ekppCode,
      this.ekppReqid,
      this.ej2bStat,
      this.eserRemark,
      this.ej2aTick,
      this.ej2bTick,
      this.addClass,
      this.userId,
      this.kpp02CertNo,
      this.kpp02CertPath,
      this.l2aPrnCount,
      this.l2bPrnCount,
      this.sm4PrnCount,
      this.deleted,
      this.productCode,
      this.diCode,
      this.compCode,
      this.branchCode,
      this.lastupload,
      this.status,
      this.fee,
      this.totalTime,
      this.name,
      this.sex,
      this.race,
      this.birthDt,
      this.citizenship});

  Enroll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icNo = json['ic_no'];
    trandate = json['trandate'];
    groupId = json['group_id'];
    kppGroupId = json['kpp_group_id'];
    kppGroupId2 = json['kpp_group_id_2'];
    kppGroupId3 = json['kpp_group_id_3'];
    blacklisted = json['blacklisted'];
    stuNo = json['stu_no'];
    dsCode = json['ds_code'];
    employeNo = json['employe_no'];
    introBy = json['intro_by'];
    commType = json['comm_type'];
    feesAgree = json['fees_agree'];
    hrsAgree = json['hrs_agree'];
    addhrChrg = json['addhr_chrg'];
    promptTes = json['prompt_tes'];
    totalPaid = json['total_paid'];
    retest = json['retest'];
    certNo = json['cert_no'];
    remark = json['remark'];
    tlHrsTak = json['tl_hrs_tak'];
    exclIncml = json['excl_incml'];
    sm4No = json['sm4_no'];
    pickupPoint = json['pickup_point'];
    transtamp = json['transtamp'];
    epretCode = json['epret_code'];
    epretReqid = json['epret_reqid'];
    ekppCode = json['ekpp_code'];
    ekppReqid = json['ekpp_reqid'];
    ej2bStat = json['ej2b_stat'];
    eserRemark = json['eser_remark'];
    ej2aTick = json['ej2a_tick'];
    ej2bTick = json['ej2b_tick'];
    addClass = json['add_class'];
    userId = json['user_id'];
    kpp02CertNo = json['kpp02_cert_no'];
    kpp02CertPath = json['kpp02_cert_path'];
    l2aPrnCount = json['l2a_prn_count'];
    l2bPrnCount = json['l2b_prn_count'];
    sm4PrnCount = json['sm4_prn_count'];
    deleted = json['deleted'];
    productCode = json['product_code'];
    diCode = json['di_code'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    lastupload = json['lastupload'];
    status = json['status'];
    fee = json['fee'];
    totalTime = json['total_time'];
    name = json['name'];
    sex = json['sex'];
    race = json['race'];
    birthDt = json['birth_dt'];
    citizenship = json['citizenship'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ic_no'] = this.icNo;
    data['trandate'] = this.trandate;
    data['group_id'] = this.groupId;
    data['kpp_group_id'] = this.kppGroupId;
    data['kpp_group_id_2'] = this.kppGroupId2;
    data['kpp_group_id_3'] = this.kppGroupId3;
    data['blacklisted'] = this.blacklisted;
    data['stu_no'] = this.stuNo;
    data['ds_code'] = this.dsCode;
    data['employe_no'] = this.employeNo;
    data['intro_by'] = this.introBy;
    data['comm_type'] = this.commType;
    data['fees_agree'] = this.feesAgree;
    data['hrs_agree'] = this.hrsAgree;
    data['addhr_chrg'] = this.addhrChrg;
    data['prompt_tes'] = this.promptTes;
    data['total_paid'] = this.totalPaid;
    data['retest'] = this.retest;
    data['cert_no'] = this.certNo;
    data['remark'] = this.remark;
    data['tl_hrs_tak'] = this.tlHrsTak;
    data['excl_incml'] = this.exclIncml;
    data['sm4_no'] = this.sm4No;
    data['pickup_point'] = this.pickupPoint;
    data['transtamp'] = this.transtamp;
    data['epret_code'] = this.epretCode;
    data['epret_reqid'] = this.epretReqid;
    data['ekpp_code'] = this.ekppCode;
    data['ekpp_reqid'] = this.ekppReqid;
    data['ej2b_stat'] = this.ej2bStat;
    data['eser_remark'] = this.eserRemark;
    data['ej2a_tick'] = this.ej2aTick;
    data['ej2b_tick'] = this.ej2bTick;
    data['add_class'] = this.addClass;
    data['user_id'] = this.userId;
    data['kpp02_cert_no'] = this.kpp02CertNo;
    data['kpp02_cert_path'] = this.kpp02CertPath;
    data['l2a_prn_count'] = this.l2aPrnCount;
    data['l2b_prn_count'] = this.l2bPrnCount;
    data['sm4_prn_count'] = this.sm4PrnCount;
    data['deleted'] = this.deleted;
    data['product_code'] = this.productCode;
    data['di_code'] = this.diCode;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['lastupload'] = this.lastupload;
    data['status'] = this.status;
    data['fee'] = this.fee;
    data['total_time'] = this.totalTime;
    data['name'] = this.name;
    data['sex'] = this.sex;
    data['race'] = this.race;
    data['birth_dt'] = this.birthDt;
    data['citizenship'] = this.citizenship;
    return data;
  }
}

// Arguments
class EnrollmentData {
  String phoneCountryCode;
  String diCode;
  String icNo;
  String name;
  String email;
  String groupId;
  String gender;
  String dateOfBirthString;
  String nationality;
  String race;

  EnrollmentData({
    this.phoneCountryCode,
    this.diCode,
    this.icNo,
    this.name,
    this.email,
    this.groupId,
    this.gender,
    this.dateOfBirthString,
    this.nationality,
    this.race,
  });
}

// Delete member account

class DeleteAppMemberAccountRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String userId;

  DeleteAppMemberAccountRequest(
      {this.wsCodeCrypt, this.caUid, this.caPwd, this.userId});

  DeleteAppMemberAccountRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['userId'] = this.userId;
    return data;
  }
}

// New sign up
class RegisterRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
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
  String signUpPwd;
  String latitude;
  String longitude;
  String appCode;
  String appId;
  String deviceId;
  String appVersion;
  String deviceRemark;
  String phDeviceId;
  String phLine1Number;
  String phNetOpName;
  String phPhoneType;
  String phSimSerialNo;
  String bdBoard;
  String bdBrand;
  String bdDevice;
  String bdDisplay;
  String bdManufacturer;
  String bdModel;
  String bdProduct;
  String pfDeviceId;
  String regId;

  RegisterRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
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
      this.email,
      this.signUpPwd,
      this.latitude,
      this.longitude,
      this.appCode,
      this.appId,
      this.deviceId,
      this.appVersion,
      this.deviceRemark,
      this.phDeviceId,
      this.phLine1Number,
      this.phNetOpName,
      this.phPhoneType,
      this.phSimSerialNo,
      this.bdBoard,
      this.bdBrand,
      this.bdDevice,
      this.bdDisplay,
      this.bdManufacturer,
      this.bdModel,
      this.bdProduct,
      this.pfDeviceId,
      this.regId});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
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
    signUpPwd = json['signUpPwd'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    appCode = json['appCode'];
    appId = json['appId'];
    deviceId = json['deviceId'];
    appVersion = json['appVersion'];
    deviceRemark = json['deviceRemark'];
    phDeviceId = json['phDeviceId'];
    phLine1Number = json['phLine1Number'];
    phNetOpName = json['phNetOpName'];
    phPhoneType = json['phPhoneType'];
    phSimSerialNo = json['phSimSerialNo'];
    bdBoard = json['bdBoard'];
    bdBrand = json['bdBrand'];
    bdDevice = json['bdDevice'];
    bdDisplay = json['bdDisplay'];
    bdManufacturer = json['bdManufacturer'];
    bdModel = json['bdModel'];
    bdProduct = json['bdProduct'];
    pfDeviceId = json['pfDeviceId'];
    regId = json['regId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
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
    data['signUpPwd'] = this.signUpPwd;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['appCode'] = this.appCode;
    data['appId'] = this.appId;
    data['deviceId'] = this.deviceId;
    data['appVersion'] = this.appVersion;
    data['deviceRemark'] = this.deviceRemark;
    data['phDeviceId'] = this.phDeviceId;
    data['phLine1Number'] = this.phLine1Number;
    data['phNetOpName'] = this.phNetOpName;
    data['phPhoneType'] = this.phPhoneType;
    data['phSimSerialNo'] = this.phSimSerialNo;
    data['bdBoard'] = this.bdBoard;
    data['bdBrand'] = this.bdBrand;
    data['bdDevice'] = this.bdDevice;
    data['bdDisplay'] = this.bdDisplay;
    data['bdManufacturer'] = this.bdManufacturer;
    data['bdModel'] = this.bdModel;
    data['bdProduct'] = this.bdProduct;
    data['pfDeviceId'] = this.pfDeviceId;
    data['regId'] = this.regId;
    return data;
  }
}

class SignUpArguments {
  String phoneCountryCode;
  String phone;
  String verificationCode;

  SignUpArguments({this.phoneCountryCode, this.phone, this.verificationCode});
}

// RegisterToUserDI
class RegisterUserToDIRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String appCode;
  String appId;
  String diCode;
  String icNo;
  String name;
  String nationality;
  String phoneCountryCode;
  String phone;
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
  String userId;
  String bodyTemperature;
  String scanCode;

  RegisterUserToDIRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.appCode,
      this.appId,
      this.diCode,
      this.icNo,
      this.name,
      this.nationality,
      this.phoneCountryCode,
      this.phone,
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
      this.email,
      this.userId,
      this.bodyTemperature,
      this.scanCode});

  RegisterUserToDIRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    appCode = json['appCode'];
    appId = json['appId'];
    diCode = json['diCode'];
    icNo = json['icNo'];
    name = json['name'];
    nationality = json['nationality'];
    phoneCountryCode = json['phoneCountryCode'];
    phone = json['phone'];
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
    userId = json['userId'];
    bodyTemperature = json['bodyTemperature'];
    scanCode = json['scanCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['appCode'] = this.appCode;
    data['appId'] = this.appId;
    data['diCode'] = this.diCode;
    data['icNo'] = this.icNo;
    data['name'] = this.name;
    data['nationality'] = this.nationality;
    data['phoneCountryCode'] = this.phoneCountryCode;
    data['phone'] = this.phone;
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
    data['userId'] = this.userId;
    data['bodyTemperature'] = this.bodyTemperature;
    data['scanCode'] = this.scanCode;
    return data;
  }
}

// Scan response
class ScanResponse {
  List<QRCode> qRCode;

  ScanResponse({this.qRCode});

  ScanResponse.fromJson(Map<String, dynamic> json) {
    if (json['QRCode'] != null) {
      qRCode = new List<QRCode>();
      json['QRCode'].forEach((v) {
        qRCode.add(new QRCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.qRCode != null) {
      data['QRCode'] = this.qRCode.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QRCode {
  String appId;
  String appVersion;
  String phoneCountryCode;
  String phone;
  String name;
  String userId;
  String merchantDbCode;

  QRCode(
      {this.appId,
      this.appVersion,
      this.phoneCountryCode,
      this.phone,
      this.name,
      this.userId,
      this.merchantDbCode});

  QRCode.fromJson(Map<String, dynamic> json) {
    appId = json['appId'];
    appVersion = json['appVersion'];
    phoneCountryCode = json['phoneCountryCode'];
    phone = json['phone'];
    name = json['name'];
    userId = json['userId'];
    merchantDbCode = json['merchantDbCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appId'] = this.appId;
    data['appVersion'] = this.appVersion;
    data['phoneCountryCode'] = this.phoneCountryCode;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['userId'] = this.userId;
    data['merchantDbCode'] = this.merchantDbCode;
    return data;
  }
}

class ScanResultArgument {
  var barcode;
  String status;

  ScanResultArgument({this.barcode, this.status});
}
