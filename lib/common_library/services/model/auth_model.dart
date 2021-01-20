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
  String deviceId;

  Table1({this.userId, this.sessionId, this.msg, this.deviceId});

  Table1.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    sessionId = json['sessionId'];
    msg = json['msg'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['sessionId'] = this.sessionId;
    data['msg'] = this.msg;
    data['deviceId'] = this.deviceId;
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
  List<RegisteredDiArmasterProfile> armasterProfile;

  UserRegisteredDiResponse({this.armasterProfile});

  UserRegisteredDiResponse.fromJson(Map<String, dynamic> json) {
    if (json['ArmasterProfile'] != null) {
      armasterProfile = new List<RegisteredDiArmasterProfile>();
      json['ArmasterProfile'].forEach((v) {
        armasterProfile.add(new RegisteredDiArmasterProfile.fromJson(v));
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

class RegisteredDiArmasterProfile {
  String iD;
  String appId;
  String merchantNo;
  String userId;
  String sponsor;
  String sponsorAppId;
  String appCode;
  String appVersion;
  String deleted;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String compCode;
  String branchCode;
  String transtamp;
  String appBackgroundPhotoPath;
  String name;
  String shortName;

  RegisteredDiArmasterProfile(
      {this.iD,
      this.appId,
      this.merchantNo,
      this.userId,
      this.sponsor,
      this.sponsorAppId,
      this.appCode,
      this.appVersion,
      this.deleted,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.compCode,
      this.branchCode,
      this.transtamp,
      this.appBackgroundPhotoPath,
      this.name,
      this.shortName});

  RegisteredDiArmasterProfile.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    appId = json['app_id'];
    merchantNo = json['merchant_no'];
    userId = json['user_id'];
    sponsor = json['sponsor'];
    sponsorAppId = json['sponsor_app_id'];
    appCode = json['app_code'];
    appVersion = json['app_version'];
    deleted = json['deleted'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    transtamp = json['transtamp'];
    appBackgroundPhotoPath = json['app_background_photo_path'];
    name = json['name'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['app_id'] = this.appId;
    data['merchant_no'] = this.merchantNo;
    data['user_id'] = this.userId;
    data['sponsor'] = this.sponsor;
    data['sponsor_app_id'] = this.sponsorAppId;
    data['app_code'] = this.appCode;
    data['app_version'] = this.appVersion;
    data['deleted'] = this.deleted;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['transtamp'] = this.transtamp;
    data['app_background_photo_path'] = this.appBackgroundPhotoPath;
    data['name'] = this.name;
    data['short_name'] = this.shortName;
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
  String appVersion;
  String diCode;
  String userId;
  String name;
  String nickName;
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
      this.appVersion,
      this.diCode,
      this.userId,
      this.name,
      this.nickName,
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
    appVersion = json['appVersion'];
    diCode = json['diCode'];
    userId = json['userId'];
    name = json['name'];
    nickName = json['nickName'];
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
    data['appVersion'] = this.appVersion;
    data['diCode'] = this.diCode;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['nickName'] = this.nickName;
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

// GetDiNearMe
class GetDiNearMeResponse {
  List<Merchant> merchant;

  GetDiNearMeResponse({this.merchant});

  GetDiNearMeResponse.fromJson(Map<String, dynamic> json) {
    if (json['Merchant'] != null) {
      merchant = new List<Merchant>();
      json['Merchant'].forEach((v) {
        merchant.add(new Merchant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.merchant != null) {
      data['Merchant'] = this.merchant.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Merchant {
  String iD;
  String merchantNo;
  String company;
  String brno;
  String merchantDesc;
  String merchantType;
  String name;
  String shortName;
  String category;
  String merchantIconFilename;
  String merchantProfilePhotoFilename;
  String merchantBannerFilename;
  String coMap;
  String webSite;
  String coDomain;
  String pic;
  String phoneOff1;
  String phoneExt1;
  String phoneOff2;
  String phoneExt2;
  String mobilePhone;
  String fax;
  String email;
  String contactPerson;
  String contactPost;
  String add1;
  String add2;
  String add3;
  String add4;
  String postcode;
  String cityCode;
  String stateCode;
  String countryCode;
  String latitude;
  String longitude;
  String durationDay;
  String active;
  String feedNavigate;
  String remark;
  String status;
  String indCode;
  String merchantApplicationStatus;
  String merchantStatus;
  String acctUid;
  String acctPwd;
  String playStorePath;
  String url;
  String inviteSms;
  String dbcode;
  String crcode;
  String coIntro;
  String businessHour;
  String businessDay;
  String homeBanner;
  String coOverview;
  String businessInfo;
  String offerGive;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String deleted;
  String transtamp;

  Merchant(
      {this.iD,
      this.merchantNo,
      this.company,
      this.brno,
      this.merchantDesc,
      this.merchantType,
      this.name,
      this.shortName,
      this.category,
      this.merchantIconFilename,
      this.merchantProfilePhotoFilename,
      this.merchantBannerFilename,
      this.coMap,
      this.webSite,
      this.coDomain,
      this.pic,
      this.phoneOff1,
      this.phoneExt1,
      this.phoneOff2,
      this.phoneExt2,
      this.mobilePhone,
      this.fax,
      this.email,
      this.contactPerson,
      this.contactPost,
      this.add1,
      this.add2,
      this.add3,
      this.add4,
      this.postcode,
      this.cityCode,
      this.stateCode,
      this.countryCode,
      this.latitude,
      this.longitude,
      this.durationDay,
      this.active,
      this.feedNavigate,
      this.remark,
      this.status,
      this.indCode,
      this.merchantApplicationStatus,
      this.merchantStatus,
      this.acctUid,
      this.acctPwd,
      this.playStorePath,
      this.url,
      this.inviteSms,
      this.dbcode,
      this.crcode,
      this.coIntro,
      this.businessHour,
      this.businessDay,
      this.homeBanner,
      this.coOverview,
      this.businessInfo,
      this.offerGive,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.deleted,
      this.transtamp});

  Merchant.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantNo = json['merchant_no'];
    company = json['company'];
    brno = json['brno'];
    merchantDesc = json['merchant_desc'];
    merchantType = json['merchant_type'];
    name = json['name'];
    shortName = json['short_name'];
    category = json['category'];
    merchantIconFilename = json['merchant_icon_filename'];
    merchantProfilePhotoFilename = json['merchant_profile_photo_filename'];
    merchantBannerFilename = json['merchant_banner_filename'];
    coMap = json['co_map'];
    webSite = json['web_site'];
    coDomain = json['co_domain'];
    pic = json['pic'];
    phoneOff1 = json['phone_off1'];
    phoneExt1 = json['phone_ext1'];
    phoneOff2 = json['phone_off2'];
    phoneExt2 = json['phone_ext2'];
    mobilePhone = json['mobile_phone'];
    fax = json['fax'];
    email = json['email'];
    contactPerson = json['contact_person'];
    contactPost = json['contact_post'];
    add1 = json['add1'];
    add2 = json['add2'];
    add3 = json['add3'];
    add4 = json['add4'];
    postcode = json['postcode'];
    cityCode = json['city_code'];
    stateCode = json['state_code'];
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    durationDay = json['duration_day'];
    active = json['active'];
    feedNavigate = json['feed_navigate'];
    remark = json['remark'];
    status = json['status'];
    indCode = json['ind_code'];
    merchantApplicationStatus = json['merchant_application_status'];
    merchantStatus = json['merchant_status'];
    acctUid = json['acct_uid'];
    acctPwd = json['acct_pwd'];
    playStorePath = json['play_store_path'];
    url = json['url'];
    inviteSms = json['invite_sms'];
    dbcode = json['dbcode'];
    crcode = json['crcode'];
    coIntro = json['co_intro'];
    businessHour = json['business_hour'];
    businessDay = json['business_day'];
    homeBanner = json['home_banner'];
    coOverview = json['co_overview'];
    businessInfo = json['business_Info'];
    offerGive = json['offer_give'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    transtamp = json['transtamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['merchant_no'] = this.merchantNo;
    data['company'] = this.company;
    data['brno'] = this.brno;
    data['merchant_desc'] = this.merchantDesc;
    data['merchant_type'] = this.merchantType;
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    data['category'] = this.category;
    data['merchant_icon_filename'] = this.merchantIconFilename;
    data['merchant_profile_photo_filename'] = this.merchantProfilePhotoFilename;
    data['merchant_banner_filename'] = this.merchantBannerFilename;
    data['co_map'] = this.coMap;
    data['web_site'] = this.webSite;
    data['co_domain'] = this.coDomain;
    data['pic'] = this.pic;
    data['phone_off1'] = this.phoneOff1;
    data['phone_ext1'] = this.phoneExt1;
    data['phone_off2'] = this.phoneOff2;
    data['phone_ext2'] = this.phoneExt2;
    data['mobile_phone'] = this.mobilePhone;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['contact_person'] = this.contactPerson;
    data['contact_post'] = this.contactPost;
    data['add1'] = this.add1;
    data['add2'] = this.add2;
    data['add3'] = this.add3;
    data['add4'] = this.add4;
    data['postcode'] = this.postcode;
    data['city_code'] = this.cityCode;
    data['state_code'] = this.stateCode;
    data['country_code'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['duration_day'] = this.durationDay;
    data['active'] = this.active;
    data['feed_navigate'] = this.feedNavigate;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['ind_code'] = this.indCode;
    data['merchant_application_status'] = this.merchantApplicationStatus;
    data['merchant_status'] = this.merchantStatus;
    data['acct_uid'] = this.acctUid;
    data['acct_pwd'] = this.acctPwd;
    data['play_store_path'] = this.playStorePath;
    data['url'] = this.url;
    data['invite_sms'] = this.inviteSms;
    data['dbcode'] = this.dbcode;
    data['crcode'] = this.crcode;
    data['co_intro'] = this.coIntro;
    data['business_hour'] = this.businessHour;
    data['business_day'] = this.businessDay;
    data['home_banner'] = this.homeBanner;
    data['co_overview'] = this.coOverview;
    data['business_Info'] = this.businessInfo;
    data['offer_give'] = this.offerGive;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['deleted'] = this.deleted;
    data['transtamp'] = this.transtamp;
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
  String appCode;
  String appId;
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
  List<int> userProfileImage;
  String userProfileImageBase64String;
  bool removeUserProfileImage;

  SaveEnrollmentRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.appCode,
      this.appId,
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
      this.userId,
      this.userProfileImage,
      this.userProfileImageBase64String,
      this.removeUserProfileImage});

  SaveEnrollmentRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    appCode = json['appCode'];
    appId = json['appId'];
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
    userProfileImage = json['userProfileImage'];
    userProfileImageBase64String = json['userProfileImageBase64String'];
    removeUserProfileImage = json['removeUserProfileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['appCode'] = this.appCode;
    data['appId'] = this.appId;
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
    data['userProfileImage'] = this.userProfileImage;
    data['userProfileImageBase64String'] = this.userProfileImageBase64String;
    data['removeUserProfileImage'] = this.removeUserProfileImage;
    return data;
  }
}

class SaveEnrollmentPackageRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String appCode;
  String appId;
  String diCode;
  String packageCode;
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
  List<int> userProfileImage;
  String userProfileImageBase64String;
  bool removeUserProfileImage;

  SaveEnrollmentPackageRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.appCode,
      this.appId,
      this.diCode,
      this.packageCode,
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
      this.userProfileImage,
      this.userProfileImageBase64String,
      this.removeUserProfileImage});

  SaveEnrollmentPackageRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    appCode = json['appCode'];
    appId = json['appId'];
    diCode = json['diCode'];
    packageCode = json['packageCode'];
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
    userProfileImage = json['userProfileImage'];
    userProfileImageBase64String = json['userProfileImageBase64String'];
    removeUserProfileImage = json['removeUserProfileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['appCode'] = this.appCode;
    data['appId'] = this.appId;
    data['diCode'] = this.diCode;
    data['packageCode'] = this.packageCode;
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
    data['userProfileImage'] = this.userProfileImage;
    data['userProfileImageBase64String'] = this.userProfileImageBase64String;
    data['removeUserProfileImage'] = this.removeUserProfileImage;
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
  String feedType;
  String bgDate;
  String durationDay;
  String active;
  String rowKey;
  String feedText;
  String feedMedia;
  String feedMediaFilename;
  String feedNavigate;
  String udfReturnParameter;
  String merchantNo;
  String localFeed;
  String remark;
  String createUser;
  String createDate;
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
      this.feedType,
      this.bgDate,
      this.durationDay,
      this.active,
      this.rowKey,
      this.feedText,
      this.feedMedia,
      this.feedMediaFilename,
      this.feedNavigate,
      this.udfReturnParameter,
      this.merchantNo,
      this.localFeed,
      this.remark,
      this.createUser,
      this.createDate,
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
    feedType = json['feed_type'];
    bgDate = json['bg_date'];
    durationDay = json['duration_day'];
    active = json['active'];
    rowKey = json['row_key'];
    feedText = json['feed_text'];
    feedMedia = json['feed_media'];
    feedMediaFilename = json['feed_media_filename'];
    feedNavigate = json['feed_navigate'];
    udfReturnParameter = json['udf_return_parameter'];
    merchantNo = json['merchant_no'];
    localFeed = json['local_feed'];
    remark = json['remark'];
    createUser = json['create_user'];
    createDate = json['create_date'];
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
    data['feed_type'] = this.feedType;
    data['bg_date'] = this.bgDate;
    data['duration_day'] = this.durationDay;
    data['active'] = this.active;
    data['row_key'] = this.rowKey;
    data['feed_text'] = this.feedText;
    data['feed_media'] = this.feedMedia;
    data['feed_media_filename'] = this.feedMediaFilename;
    data['feed_navigate'] = this.feedNavigate;
    data['udf_return_parameter'] = this.udfReturnParameter;
    data['merchant_no'] = this.merchantNo;
    data['local_feed'] = this.localFeed;
    data['remark'] = this.remark;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
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
  String profilePic;

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
    this.profilePic,
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
  String nickName;
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
  List<int> userProfileImage;
  String userProfileImageBase64String;
  bool removeUserProfileImage;
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
  String enqLdlGroup;
  String cdlGroup;
  String langCode;
  bool findDrvJobs;

  RegisterRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.diCode,
      this.userId,
      this.name,
      this.nickName,
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
      this.userProfileImage,
      this.userProfileImageBase64String,
      this.removeUserProfileImage,
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
      this.regId,
      this.enqLdlGroup,
      this.cdlGroup,
      this.langCode,
      this.findDrvJobs});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    userId = json['userId'];
    name = json['name'];
    nickName = json['nickName'];
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
    userProfileImage = json['userProfileImage'].cast<int>();
    userProfileImageBase64String = json['userProfileImageBase64String'];
    removeUserProfileImage = json['removeUserProfileImage'];
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
    enqLdlGroup = json['enqLdlGroup'];
    cdlGroup = json['cdlGroup'];
    langCode = json['langCode'];
    findDrvJobs = json['findDrvJobs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['nickName'] = this.nickName;
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
    data['userProfileImage'] = this.userProfileImage;
    data['userProfileImageBase64String'] = this.userProfileImageBase64String;
    data['removeUserProfileImage'] = this.removeUserProfileImage;
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
    data['enqLdlGroup'] = this.enqLdlGroup;
    data['cdlGroup'] = this.cdlGroup;
    data['langCode'] = this.langCode;
    data['findDrvJobs'] = this.findDrvJobs;
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
/* class RegisterUserToDIRequest {
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
} */

class RegisterUserToDIRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String appCode;
  String appId;
  String appVersion;
  String merchantNo;
  String loginId;
  String userId;
  String bodyTemperature;
  String scannedAppId;
  String scannedAppVer;
  String scannedLoginId;
  String scannedUserId;
  String scanCode;
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
  String latitude;
  String longitude;

  RegisterUserToDIRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.appCode,
      this.appId,
      this.appVersion,
      this.merchantNo,
      this.loginId,
      this.userId,
      this.bodyTemperature,
      this.scannedAppId,
      this.scannedAppVer,
      this.scannedLoginId,
      this.scannedUserId,
      this.scanCode,
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
      this.regId,
      this.latitude,
      this.longitude});

  RegisterUserToDIRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    appCode = json['appCode'];
    appId = json['appId'];
    appVersion = json['appVersion'];
    merchantNo = json['merchantNo'];
    loginId = json['loginId'];
    userId = json['userId'];
    bodyTemperature = json['bodyTemperature'];
    scannedAppId = json['scannedAppId'];
    scannedAppVer = json['scannedAppVer'];
    scannedLoginId = json['scannedLoginId'];
    scannedUserId = json['scannedUserId'];
    scanCode = json['scanCode'];
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
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['appCode'] = this.appCode;
    data['appId'] = this.appId;
    data['appVersion'] = this.appVersion;
    data['merchantNo'] = this.merchantNo;
    data['loginId'] = this.loginId;
    data['userId'] = this.userId;
    data['bodyTemperature'] = this.bodyTemperature;
    data['scannedAppId'] = this.scannedAppId;
    data['scannedAppVer'] = this.scannedAppVer;
    data['scannedLoginId'] = this.scannedLoginId;
    data['scannedUserId'] = this.scannedUserId;
    data['scanCode'] = this.scanCode;
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
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
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
  String loginId;
  String name;
  String userId;
  String merchantDbCode;
  String merchantName;

  QRCode(
      {this.appId,
      this.appVersion,
      this.loginId,
      this.name,
      this.userId,
      this.merchantDbCode,
      this.merchantName});

  QRCode.fromJson(Map<String, dynamic> json) {
    appId = json['appId'];
    appVersion = json['appVersion'];
    loginId = json['loginId'];
    name = json['name'];
    userId = json['userId'];
    merchantDbCode = json['merchantDbCode'];
    merchantName = json['merchantName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appId'] = this.appId;
    data['appVersion'] = this.appVersion;
    data['loginId'] = this.loginId;
    data['name'] = this.name;
    data['userId'] = this.userId;
    data['merchantDbCode'] = this.merchantDbCode;
    data['merchantName'] = this.merchantName;
    return data;
  }
}

class ScanResultArgument {
  var barcode;
  String status;

  ScanResultArgument({this.barcode, this.status});
}

class GetPackageListByPackageCodeListResponse {
  List<Package> package;

  GetPackageListByPackageCodeListResponse({this.package});

  GetPackageListByPackageCodeListResponse.fromJson(Map<String, dynamic> json) {
    if (json['Package'] != null) {
      package = new List<Package>();
      json['Package'].forEach((v) {
        package.add(new Package.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.package != null) {
      data['Package'] = this.package.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Package {
  String iD;
  String merchantNo;
  String packageCode;
  String packageDesc;
  String groupIdGrouping;
  String amt;
  String termConditionPolicy;
  String cancelPolicy;
  String offerFrom;
  String offerTo;
  String paymentMode;
  String paymentSchedule;
  String feedMedia;
  String feedMediaFilename;
  String createDate;
  String createUser;
  String editDate;
  String editUser;
  String lastupload;
  String transtamp;
  String compCode;
  String branchCode;
  String rowKey;
  String deleted;

  Package(
      {this.iD,
      this.merchantNo,
      this.packageCode,
      this.packageDesc,
      this.groupIdGrouping,
      this.amt,
      this.termConditionPolicy,
      this.cancelPolicy,
      this.offerFrom,
      this.offerTo,
      this.paymentMode,
      this.paymentSchedule,
      this.feedMedia,
      this.feedMediaFilename,
      this.createDate,
      this.createUser,
      this.editDate,
      this.editUser,
      this.lastupload,
      this.transtamp,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.deleted});

  Package.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantNo = json['merchant_no'];
    packageCode = json['package_code'];
    packageDesc = json['package_desc'];
    groupIdGrouping = json['group_id_grouping'];
    amt = json['amt'];
    termConditionPolicy = json['term_condition_policy'];
    cancelPolicy = json['cancel_policy'];
    offerFrom = json['offer_from'];
    offerTo = json['offer_to'];
    paymentMode = json['payment_mode'];
    paymentSchedule = json['payment_schedule'];
    feedMedia = json['feed_media'];
    feedMediaFilename = json['feed_media_filename'];
    createDate = json['create_date'];
    createUser = json['create_user'];
    editDate = json['edit_date'];
    editUser = json['edit_user'];
    lastupload = json['lastupload'];
    transtamp = json['transtamp'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['merchant_no'] = this.merchantNo;
    data['package_code'] = this.packageCode;
    data['package_desc'] = this.packageDesc;
    data['group_id_grouping'] = this.groupIdGrouping;
    data['amt'] = this.amt;
    data['term_condition_policy'] = this.termConditionPolicy;
    data['cancel_policy'] = this.cancelPolicy;
    data['offer_from'] = this.offerFrom;
    data['offer_to'] = this.offerTo;
    data['payment_mode'] = this.paymentMode;
    data['payment_schedule'] = this.paymentSchedule;
    data['feed_media'] = this.feedMedia;
    data['feed_media_filename'] = this.feedMediaFilename;
    data['create_date'] = this.createDate;
    data['create_user'] = this.createUser;
    data['edit_date'] = this.editDate;
    data['edit_user'] = this.editUser;
    data['lastupload'] = this.lastupload;
    data['transtamp'] = this.transtamp;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['deleted'] = this.deleted;
    return data;
  }
}

class GetPackageDetlListResponse {
  List<PackageDetl> packageDetl;

  GetPackageDetlListResponse({this.packageDetl});

  GetPackageDetlListResponse.fromJson(Map<String, dynamic> json) {
    if (json['PackageDetl'] != null) {
      packageDetl = new List<PackageDetl>();
      json['PackageDetl'].forEach((v) {
        packageDetl.add(new PackageDetl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packageDetl != null) {
      data['PackageDetl'] = this.packageDetl.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackageDetl {
  String iD;
  String merchantNo;
  String packageCode;
  String prodCode;
  String groupId;
  String qty;
  String uom;
  String amt;
  String createDate;
  String createUser;
  String editDate;
  String editUser;
  String lastupload;
  String transtamp;
  String compCode;
  String branchCode;
  String rowKey;
  String deleted;
  String prodDesc;

  PackageDetl(
      {this.iD,
      this.merchantNo,
      this.packageCode,
      this.prodCode,
      this.groupId,
      this.qty,
      this.uom,
      this.amt,
      this.createDate,
      this.createUser,
      this.editDate,
      this.editUser,
      this.lastupload,
      this.transtamp,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.deleted,
      this.prodDesc});

  PackageDetl.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantNo = json['merchant_no'];
    packageCode = json['package_code'];
    prodCode = json['prod_code'];
    groupId = json['group_id'];
    qty = json['qty'];
    uom = json['uom'];
    amt = json['amt'];
    createDate = json['create_date'];
    createUser = json['create_user'];
    editDate = json['edit_date'];
    editUser = json['edit_user'];
    lastupload = json['lastupload'];
    transtamp = json['transtamp'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    deleted = json['deleted'];
    prodDesc = json['prod_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['merchant_no'] = this.merchantNo;
    data['package_code'] = this.packageCode;
    data['prod_code'] = this.prodCode;
    data['group_id'] = this.groupId;
    data['qty'] = this.qty;
    data['uom'] = this.uom;
    data['amt'] = this.amt;
    data['create_date'] = this.createDate;
    data['create_user'] = this.createUser;
    data['edit_date'] = this.editDate;
    data['edit_user'] = this.editUser;
    data['lastupload'] = this.lastupload;
    data['transtamp'] = this.transtamp;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['deleted'] = this.deleted;
    data['prod_desc'] = this.prodDesc;
    return data;
  }
}

class GetAuthorizationStatusListResponse {
  List<AuthzStatus> authzStatus;

  GetAuthorizationStatusListResponse({this.authzStatus});

  GetAuthorizationStatusListResponse.fromJson(Map<String, dynamic> json) {
    if (json['AuthzStatus'] != null) {
      authzStatus = new List<AuthzStatus>();
      json['AuthzStatus'].forEach((v) {
        authzStatus.add(new AuthzStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.authzStatus != null) {
      data['AuthzStatus'] = this.authzStatus.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AuthzStatus {
  String authzStatus;

  AuthzStatus({this.authzStatus});

  AuthzStatus.fromJson(Map<String, dynamic> json) {
    authzStatus = json['authz_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authz_status'] = this.authzStatus;
    return data;
  }
}

// GetDeviceRequestList
class GetDeviceRequestListResponse {
  List<UserDevice> userDevice;

  GetDeviceRequestListResponse({this.userDevice});

  GetDeviceRequestListResponse.fromJson(Map<String, dynamic> json) {
    if (json['UserDevice'] != null) {
      userDevice = new List<UserDevice>();
      json['UserDevice'].forEach((v) {
        userDevice.add(new UserDevice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDevice != null) {
      data['UserDevice'] = this.userDevice.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserDevice {
  String iD;
  String merchantNo;
  String userId;
  String loginId;
  String deviceId;
  String deviceRegDatetime;
  String authzStatus;
  String lastAuthzDatetime;
  String lastAuthzBy;
  String appCode;
  String appId;
  String appVersion;
  String deviceName;
  String latitude;
  String longitude;
  String createUser;
  String createDate;
  String editUser;
  String compCode;
  String branchCode;
  String rowKey;
  String lastupload;
  String transtamp;
  String editDate;
  String deleted;
  String nickName;
  String name;
  String authzName;
  String authzNickName;
  String lastEditedBy;
  String createdBy;

  UserDevice(
      {this.iD,
      this.merchantNo,
      this.userId,
      this.loginId,
      this.deviceId,
      this.deviceRegDatetime,
      this.authzStatus,
      this.lastAuthzDatetime,
      this.lastAuthzBy,
      this.appCode,
      this.appId,
      this.appVersion,
      this.deviceName,
      this.latitude,
      this.longitude,
      this.createUser,
      this.createDate,
      this.editUser,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.lastupload,
      this.transtamp,
      this.editDate,
      this.deleted,
      this.nickName,
      this.name,
      this.authzName,
      this.authzNickName,
      this.lastEditedBy,
      this.createdBy});

  UserDevice.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantNo = json['merchant_no'];
    userId = json['user_id'];
    loginId = json['login_id'];
    deviceId = json['device_id'];
    deviceRegDatetime = json['device_reg_datetime'];
    authzStatus = json['authz_status'];
    lastAuthzDatetime = json['last_authz_datetime'];
    lastAuthzBy = json['last_authz_by'];
    appCode = json['app_code'];
    appId = json['app_id'];
    appVersion = json['app_version'];
    deviceName = json['device_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    lastupload = json['lastupload'];
    transtamp = json['transtamp'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    nickName = json['nick_name'];
    name = json['name'];
    authzName = json['authz_name'];
    authzNickName = json['authz_nick_name'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['merchant_no'] = this.merchantNo;
    data['user_id'] = this.userId;
    data['login_id'] = this.loginId;
    data['device_id'] = this.deviceId;
    data['device_reg_datetime'] = this.deviceRegDatetime;
    data['authz_status'] = this.authzStatus;
    data['last_authz_datetime'] = this.lastAuthzDatetime;
    data['last_authz_by'] = this.lastAuthzBy;
    data['app_code'] = this.appCode;
    data['app_id'] = this.appId;
    data['app_version'] = this.appVersion;
    data['device_name'] = this.deviceName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['lastupload'] = this.lastupload;
    data['transtamp'] = this.transtamp;
    data['edit_date'] = this.editDate;
    data['deleted'] = this.deleted;
    data['nick_name'] = this.nickName;
    data['name'] = this.name;
    data['authz_name'] = this.authzName;
    data['authz_nick_name'] = this.authzNickName;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}

// UpdateUserDeviceStatus

class UpdateUserDeviceStatusRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String merchantNo;
  String userId;
  String appCode;
  String appId;
  String deviceId;
  String deviceMerchantNo;
  String deviceUserId;
  String deviceAppCode;
  String deviceAppId;
  String deviceDeviceId;
  String deviceAuthzStatus;
  String authzUser;

  UpdateUserDeviceStatusRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.merchantNo,
      this.userId,
      this.appCode,
      this.appId,
      this.deviceId,
      this.deviceMerchantNo,
      this.deviceUserId,
      this.deviceAppCode,
      this.deviceAppId,
      this.deviceDeviceId,
      this.deviceAuthzStatus,
      this.authzUser});

  UpdateUserDeviceStatusRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    merchantNo = json['merchantNo'];
    userId = json['userId'];
    appCode = json['appCode'];
    appId = json['appId'];
    deviceId = json['deviceId'];
    deviceMerchantNo = json['deviceMerchantNo'];
    deviceUserId = json['deviceUserId'];
    deviceAppCode = json['deviceAppCode'];
    deviceAppId = json['deviceAppId'];
    deviceDeviceId = json['deviceDeviceId'];
    deviceAuthzStatus = json['deviceAuthzStatus'];
    authzUser = json['authzUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['merchantNo'] = this.merchantNo;
    data['userId'] = this.userId;
    data['appCode'] = this.appCode;
    data['appId'] = this.appId;
    data['deviceId'] = this.deviceId;
    data['deviceMerchantNo'] = this.deviceMerchantNo;
    data['deviceUserId'] = this.deviceUserId;
    data['deviceAppCode'] = this.deviceAppCode;
    data['deviceAppId'] = this.deviceAppId;
    data['deviceDeviceId'] = this.deviceDeviceId;
    data['deviceAuthzStatus'] = this.deviceAuthzStatus;
    data['authzUser'] = this.authzUser;
    return data;
  }
}

class GetLdlkEnqGroupListResponse {
  List<LdlEnqGroupList> ldlEnqGroupList;

  GetLdlkEnqGroupListResponse({this.ldlEnqGroupList});

  GetLdlkEnqGroupListResponse.fromJson(Map<String, dynamic> json) {
    if (json['LdlEnqGroupList'] != null) {
      ldlEnqGroupList = new List<LdlEnqGroupList>();
      json['LdlEnqGroupList'].forEach((v) {
        ldlEnqGroupList.add(new LdlEnqGroupList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ldlEnqGroupList != null) {
      data['LdlEnqGroupList'] =
          this.ldlEnqGroupList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LdlEnqGroupList {
  String groupId;
  String groupDesc;

  LdlEnqGroupList({this.groupId, this.groupDesc});

  LdlEnqGroupList.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    groupDesc = json['group_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['group_desc'] = this.groupDesc;
    return data;
  }
}

class GetCdlListResponse {
  List<CdlList> cdlList;

  GetCdlListResponse({this.cdlList});

  GetCdlListResponse.fromJson(Map<String, dynamic> json) {
    if (json['CdlList'] != null) {
      cdlList = new List<CdlList>();
      json['CdlList'].forEach((v) {
        cdlList.add(new CdlList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cdlList != null) {
      data['CdlList'] = this.cdlList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CdlList {
  String groupId;
  String groupDesc;

  CdlList({this.groupId, this.groupDesc});

  CdlList.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    groupDesc = json['group_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['group_desc'] = this.groupDesc;
    return data;
  }
}

class GetLanguageListResponse {
  List<LanguageList> languageList;

  GetLanguageListResponse({this.languageList});

  GetLanguageListResponse.fromJson(Map<String, dynamic> json) {
    if (json['LanguageList'] != null) {
      languageList = new List<LanguageList>();
      json['LanguageList'].forEach((v) {
        languageList.add(new LanguageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.languageList != null) {
      data['LanguageList'] = this.languageList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LanguageList {
  String langCode;
  String langDesc;

  LanguageList({this.langCode, this.langDesc});

  LanguageList.fromJson(Map<String, dynamic> json) {
    langCode = json['lang_code'];
    langDesc = json['lang_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang_code'] = this.langCode;
    data['lang_desc'] = this.langDesc;
    return data;
  }
}
