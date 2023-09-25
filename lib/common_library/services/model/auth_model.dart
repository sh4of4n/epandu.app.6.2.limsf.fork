import 'package:hive/hive.dart';

part 'auth_model.g.dart';

class GetWsUrlResponse {
  LoginAcctInfo? loginAcctInfo;

  GetWsUrlResponse({this.loginAcctInfo});

  GetWsUrlResponse.fromJson(Map<String, dynamic> json) {
    loginAcctInfo = json['LoginAcctInfo'] != null
        ? LoginAcctInfo.fromJson(json['LoginAcctInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (loginAcctInfo != null) {
      data['LoginAcctInfo'] = loginAcctInfo!.toJson();
    }
    return data;
  }
}

class LoginAcctInfo {
  LoginAcct? loginAcct;

  LoginAcctInfo({this.loginAcct});

  LoginAcctInfo.fromJson(Map<String, dynamic> json) {
    loginAcct = json['LoginAcct'] != null
        ? LoginAcct.fromJson(json['LoginAcct'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (loginAcct != null) {
      data['LoginAcct'] = loginAcct!.toJson();
    }
    return data;
  }
}

class LoginAcct {
  String? loginAcctId;
  String? acctUid;
  String? acctPwd;
  String? acctName;
  String? acctStatus;
  String? loginType;
  String? loginIp;
  String? loginUid;
  String? loginPwd;
  String? loginDb;
  String? loginDir;
  String? loginAcctno;
  String? loginMisc;
  String? loginPort;
  String? checkLoginInterval;
  String? deleted;
  String? createUser;
  String? editUser;
  String? lastupload;
  String? wsUrl;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login_acct_id'] = loginAcctId;
    data['acct_uid'] = acctUid;
    data['acct_pwd'] = acctPwd;
    data['acct_name'] = acctName;
    data['acct_status'] = acctStatus;
    data['login_type'] = loginType;
    data['login_ip'] = loginIp;
    data['login_uid'] = loginUid;
    data['login_pwd'] = loginPwd;
    data['login_db'] = loginDb;
    data['login_dir'] = loginDir;
    data['login_acctno'] = loginAcctno;
    data['login_misc'] = loginMisc;
    data['login_port'] = loginPort;
    data['check_login_interval'] = checkLoginInterval;
    data['deleted'] = deleted;
    data['create_user'] = createUser;
    data['edit_user'] = editUser;
    data['lastupload'] = lastupload;
    data['WsUrl'] = wsUrl;
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
  List<Table1>? table1;

  LoginResponse({this.table1});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json['Table1'] != null) {
      table1 = List<Table1>.empty(growable: true);
      json['Table1'].forEach((v) {
        table1!.add(Table1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (table1 != null) {
      data['Table1'] = table1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table1 {
  String? userId;
  String? sessionId;
  String? msg;
  String? deviceId;

  Table1({this.userId, this.sessionId, this.msg, this.deviceId});

  Table1.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    sessionId = json['sessionId'];
    msg = json['msg'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['sessionId'] = sessionId;
    data['msg'] = msg;
    data['deviceId'] = deviceId;
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
  List<RegisteredDiArmasterProfile>? armasterProfile;

  UserRegisteredDiResponse({this.armasterProfile});

  UserRegisteredDiResponse.fromJson(Map<String, dynamic> json) {
    if (json['ArmasterProfile'] != null) {
      armasterProfile =
          List<RegisteredDiArmasterProfile>.empty(growable: true);
      json['ArmasterProfile'].forEach((v) {
        armasterProfile!.add(RegisteredDiArmasterProfile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (armasterProfile != null) {
      data['ArmasterProfile'] =
          armasterProfile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 5, adapterName: 'DiListAdapter')
class RegisteredDiArmasterProfile {
  @HiveField(0)
  String? iD;
  @HiveField(1)
  String? appId;
  @HiveField(2)
  String? merchantNo;
  @HiveField(3)
  String? userId;
  @HiveField(4)
  String? sponsor;
  @HiveField(5)
  String? sponsorAppId;
  @HiveField(6)
  String? appCode;
  @HiveField(7)
  String? appVersion;
  @HiveField(8)
  String? deleted;
  @HiveField(9)
  String? createUser;
  @HiveField(10)
  String? createDate;
  @HiveField(11)
  String? editUser;
  @HiveField(12)
  String? editDate;
  @HiveField(13)
  String? compCode;
  @HiveField(14)
  String? branchCode;
  @HiveField(15)
  String? transtamp;
  @HiveField(16)
  String? appBackgroundPhotoPath;
  @HiveField(17)
  String? merchantIconFilename;
  @HiveField(18)
  String? merchantBannerFilename;
  @HiveField(19)
  String? merchantProfilePhotoFilename;
  @HiveField(20)
  String? name;
  @HiveField(21)
  String? shortName;

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
      this.merchantIconFilename,
      this.merchantBannerFilename,
      this.merchantProfilePhotoFilename,
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
    merchantIconFilename = json['merchant_icon_filename'];
    merchantBannerFilename = json['merchant_banner_filename'];
    merchantProfilePhotoFilename = json['merchant_profile_photo_filename'];
    name = json['name'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['app_id'] = appId;
    data['merchant_no'] = merchantNo;
    data['user_id'] = userId;
    data['sponsor'] = sponsor;
    data['sponsor_app_id'] = sponsorAppId;
    data['app_code'] = appCode;
    data['app_version'] = appVersion;
    data['deleted'] = deleted;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['transtamp'] = transtamp;
    data['app_background_photo_path'] = appBackgroundPhotoPath;
    data['merchant_icon_filename'] = merchantIconFilename;
    data['merchant_banner_filename'] = merchantBannerFilename;
    data['merchant_profile_photo_filename'] = merchantProfilePhotoFilename;
    data['name'] = name;
    data['short_name'] = shortName;
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
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? appCode;
  String? appId;
  String? appVersion;
  String? diCode;
  String? userId;
  String? name;
  String? nickName;
  String? icNo;
  String? passportNo;
  String? phoneCountryCode;
  String? phone;
  String? nationality;
  String? dateOfBirthString;
  String? gender;
  String? race;
  String? add1;
  String? add2;
  String? add3;
  String? postcode;
  String? city;
  String? state;
  String? country;
  String? email;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['appCode'] = appCode;
    data['appId'] = appId;
    data['appVersion'] = appVersion;
    data['diCode'] = diCode;
    data['userId'] = userId;
    data['name'] = name;
    data['nickName'] = nickName;
    data['icNo'] = icNo;
    data['passportNo'] = passportNo;
    data['phoneCountryCode'] = phoneCountryCode;
    data['phone'] = phone;
    data['nationality'] = nationality;
    data['dateOfBirthString'] = dateOfBirthString;
    data['gender'] = gender;
    data['race'] = race;
    data['add1'] = add1;
    data['add2'] = add2;
    data['add3'] = add3;
    data['postcode'] = postcode;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['email'] = email;
    return data;
  }
}

class SaveUserPasswordRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? appCode;
  String? appId;
  String? userId;
  String? password;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['appCode'] = appCode;
    data['appId'] = appId;
    data['userId'] = userId;
    data['password'] = password;
    return data;
  }
}

// GetDiList

class GetDiListResponse {
  List<ArmasterProfile>? armasterProfile;

  GetDiListResponse({this.armasterProfile});

  GetDiListResponse.fromJson(Map<String, dynamic> json) {
    if (json['Armaster'] != null) {
      armasterProfile = List<ArmasterProfile>.empty(growable: true);
      json['Armaster'].forEach((v) {
        armasterProfile!.add(ArmasterProfile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (armasterProfile != null) {
      data['Armaster'] = armasterProfile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArmasterProfile {
  String? iD;
  String? diCode;
  String? distributor;
  String? masterAgent;
  String? sponsor;
  String? dbcode;
  String? userType;
  String? level;
  String? inviteSms;
  String? appBackgroundPhotoFilename;
  String? appBackgroundPhotoPath;
  String? playStorePath;
  String? url;
  String? acctUid;
  String? acctPwd;
  String? name;
  String? nickName;
  String? compName;
  String? add;
  String? postcode;
  String? state;
  String? country;
  String? currency;
  String? idType;
  String? icNo;
  String? passportNo;
  String? nationality;
  String? gender;
  String? phone;
  String? phoneCountryCode;
  String? mobilePlan;
  String? telco;
  String? eMail;
  String? authorizationCode;
  String? mobileTopupPin;
  String? remittanceTopupPin;
  String? securityQuestion;
  String? securityAnswer;
  String? securityAnswerAttempt;
  String? authorizationName;
  String? authorizationPhone;
  String? authorizationPhoneCountryCode;
  String? authorizationEmail;
  String? commRate;
  String? commRateUom;
  String? compBrn;
  String? organisationType;
  String? fax;
  String? bankName;
  String? bankAdd;
  String? bankAccNo;
  String? creditCardNo;
  String? creditCardName;
  String? creditCardIssueBank;
  String? creditCardCv;
  String? felmoWalletId;
  String? felmoWalletExpdt;
  String? finexusWalletId;
  String? finexusWalletExpdt;
  String? finexusUrn;
  String? signaturePhotoFilename;
  String? hotWalletId;
  String? hotWalletExpdt;
  String? mpayCardNo;
  String? mpayCardNoToken;
  String? mpayCardNo2;
  String? mpayCardNoToken2;
  String? mpayId;
  String? bankAccType;
  String? ptcName;
  String? ptcPosition;
  String? ptcPhone;
  String? ptcPhoneCountryCode;
  String? ptcOff;
  String? ptcOffCountryCode;
  String? ptcEMail;
  String? districtOperate;
  String? corporateName;
  String? corporateIcNo;
  String? deviceId;
  String? appPw;
  String? lowCreditAlert;
  String? criticalAirtimeAlert;
  String? remindAirtimeAlert;
  String? criticalAirtimePhone;
  String? criticalAirtimePhoneCountryCode;
  String? remindAirtimePhone;
  String? remindAirtimePhoneCountryCode;
  String? airtimeMarkupRate;
  String? finnetMerchantId;
  String? finnetPwd;
  String? remark1;
  String? remark2;
  String? remark3;
  String? createUser;
  String? editUser;
  String? deleted;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['di_code'] = diCode;
    data['distributor'] = distributor;
    data['master_agent'] = masterAgent;
    data['sponsor'] = sponsor;
    data['dbcode'] = dbcode;
    data['user_type'] = userType;
    data['level'] = level;
    data['invite_sms'] = inviteSms;
    data['app_background_photo_filename'] = appBackgroundPhotoFilename;
    data['app_background_photo_path'] = appBackgroundPhotoPath;
    data['play_store_path'] = playStorePath;
    data['url'] = url;
    data['acct_uid'] = acctUid;
    data['acct_pwd'] = acctPwd;
    data['name'] = name;
    data['nick_name'] = nickName;
    data['comp_name'] = compName;
    data['add'] = add;
    data['postcode'] = postcode;
    data['state'] = state;
    data['country'] = country;
    data['currency'] = currency;
    data['id_type'] = idType;
    data['ic_no'] = icNo;
    data['passport_no'] = passportNo;
    data['nationality'] = nationality;
    data['gender'] = gender;
    data['phone'] = phone;
    data['phone_country_code'] = phoneCountryCode;
    data['mobile_plan'] = mobilePlan;
    data['telco'] = telco;
    data['e_mail'] = eMail;
    data['authorization_code'] = authorizationCode;
    data['mobile_topup_pin'] = mobileTopupPin;
    data['remittance_topup_pin'] = remittanceTopupPin;
    data['security_question'] = securityQuestion;
    data['security_answer'] = securityAnswer;
    data['security_answer_attempt'] = securityAnswerAttempt;
    data['authorization_name'] = authorizationName;
    data['authorization_phone'] = authorizationPhone;
    data['authorization_phone_country_code'] =
        authorizationPhoneCountryCode;
    data['authorization_email'] = authorizationEmail;
    data['comm_rate'] = commRate;
    data['comm_rate_uom'] = commRateUom;
    data['comp_brn'] = compBrn;
    data['organisation_type'] = organisationType;
    data['fax'] = fax;
    data['bank_name'] = bankName;
    data['bank_add'] = bankAdd;
    data['bank_acc_no'] = bankAccNo;
    data['credit_card_no'] = creditCardNo;
    data['credit_card_name'] = creditCardName;
    data['credit_card_issue_bank'] = creditCardIssueBank;
    data['credit_card_cv'] = creditCardCv;
    data['felmo_wallet_id'] = felmoWalletId;
    data['felmo_wallet_expdt'] = felmoWalletExpdt;
    data['finexus_wallet_id'] = finexusWalletId;
    data['finexus_wallet_expdt'] = finexusWalletExpdt;
    data['finexus_urn'] = finexusUrn;
    data['signature_photo_filename'] = signaturePhotoFilename;
    data['hot_wallet_id'] = hotWalletId;
    data['hot_wallet_expdt'] = hotWalletExpdt;
    data['mpay_card_no'] = mpayCardNo;
    data['mpay_card_no_token'] = mpayCardNoToken;
    data['mpay_card_no2'] = mpayCardNo2;
    data['mpay_card_no_token2'] = mpayCardNoToken2;
    data['mpay_id'] = mpayId;
    data['bank_acc_type'] = bankAccType;
    data['ptc_name'] = ptcName;
    data['ptc_position'] = ptcPosition;
    data['ptc_phone'] = ptcPhone;
    data['ptc_phone_country_code'] = ptcPhoneCountryCode;
    data['ptc_off'] = ptcOff;
    data['ptc_off_country_code'] = ptcOffCountryCode;
    data['ptc_e_mail'] = ptcEMail;
    data['district_operate'] = districtOperate;
    data['corporate_name'] = corporateName;
    data['corporate_ic_no'] = corporateIcNo;
    data['device_id'] = deviceId;
    data['app_pw'] = appPw;
    data['low_credit_alert'] = lowCreditAlert;
    data['critical_airtime_alert'] = criticalAirtimeAlert;
    data['remind_airtime_alert'] = remindAirtimeAlert;
    data['critical_airtime_phone'] = criticalAirtimePhone;
    data['critical_airtime_phone_country_code'] =
        criticalAirtimePhoneCountryCode;
    data['remind_airtime_phone'] = remindAirtimePhone;
    data['remind_airtime_phone_country_code'] =
        remindAirtimePhoneCountryCode;
    data['airtime_markup_rate'] = airtimeMarkupRate;
    data['finnet_merchant_id'] = finnetMerchantId;
    data['finnet_pwd'] = finnetPwd;
    data['remark1'] = remark1;
    data['remark2'] = remark2;
    data['remark3'] = remark3;
    data['create_user'] = createUser;
    data['edit_user'] = editUser;
    data['deleted'] = deleted;
    return data;
  }
}

// GetDiNearMe
class GetDiNearMeResponse {
  List<Merchant>? merchant;

  GetDiNearMeResponse({this.merchant});

  GetDiNearMeResponse.fromJson(Map<String, dynamic> json) {
    if (json['Merchant'] != null) {
      merchant = List<Merchant>.empty(growable: true);
      json['Merchant'].forEach((v) {
        merchant!.add(Merchant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (merchant != null) {
      data['Merchant'] = merchant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Merchant {
  String? iD;
  String? merchantNo;
  String? company;
  String? brno;
  String? merchantDesc;
  String? merchantType;
  String? name;
  String? shortName;
  String? category;
  String? merchantIconFilename;
  String? merchantProfilePhotoFilename;
  String? merchantBannerFilename;
  String? coMap;
  String? webSite;
  String? coDomain;
  String? pic;
  String? phoneOff1;
  String? phoneExt1;
  String? phoneOff2;
  String? phoneExt2;
  String? mobilePhone;
  String? fax;
  String? email;
  String? contactPerson;
  String? contactPost;
  String? add1;
  String? add2;
  String? add3;
  String? add4;
  String? postcode;
  String? cityCode;
  String? stateCode;
  String? countryCode;
  String? latitude;
  String? longitude;
  String? durationDay;
  String? active;
  String? feedNavigate;
  String? remark;
  String? status;
  String? indCode;
  String? merchantApplicationStatus;
  String? merchantStatus;
  String? acctUid;
  String? acctPwd;
  String? playStorePath;
  String? url;
  String? inviteSms;
  String? dbcode;
  String? crcode;
  String? coIntro;
  String? businessHour;
  String? businessDay;
  String? homeBanner;
  String? coOverview;
  String? businessInfo;
  String? offerGive;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? deleted;
  String? transtamp;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['merchant_no'] = merchantNo;
    data['company'] = company;
    data['brno'] = brno;
    data['merchant_desc'] = merchantDesc;
    data['merchant_type'] = merchantType;
    data['name'] = name;
    data['short_name'] = shortName;
    data['category'] = category;
    data['merchant_icon_filename'] = merchantIconFilename;
    data['merchant_profile_photo_filename'] = merchantProfilePhotoFilename;
    data['merchant_banner_filename'] = merchantBannerFilename;
    data['co_map'] = coMap;
    data['web_site'] = webSite;
    data['co_domain'] = coDomain;
    data['pic'] = pic;
    data['phone_off1'] = phoneOff1;
    data['phone_ext1'] = phoneExt1;
    data['phone_off2'] = phoneOff2;
    data['phone_ext2'] = phoneExt2;
    data['mobile_phone'] = mobilePhone;
    data['fax'] = fax;
    data['email'] = email;
    data['contact_person'] = contactPerson;
    data['contact_post'] = contactPost;
    data['add1'] = add1;
    data['add2'] = add2;
    data['add3'] = add3;
    data['add4'] = add4;
    data['postcode'] = postcode;
    data['city_code'] = cityCode;
    data['state_code'] = stateCode;
    data['country_code'] = countryCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['duration_day'] = durationDay;
    data['active'] = active;
    data['feed_navigate'] = feedNavigate;
    data['remark'] = remark;
    data['status'] = status;
    data['ind_code'] = indCode;
    data['merchant_application_status'] = merchantApplicationStatus;
    data['merchant_status'] = merchantStatus;
    data['acct_uid'] = acctUid;
    data['acct_pwd'] = acctPwd;
    data['play_store_path'] = playStorePath;
    data['url'] = url;
    data['invite_sms'] = inviteSms;
    data['dbcode'] = dbcode;
    data['crcode'] = crcode;
    data['co_intro'] = coIntro;
    data['business_hour'] = businessHour;
    data['business_day'] = businessDay;
    data['home_banner'] = homeBanner;
    data['co_overview'] = coOverview;
    data['business_Info'] = businessInfo;
    data['offer_give'] = offerGive;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['deleted'] = deleted;
    data['transtamp'] = transtamp;
    return data;
  }
}

// GetGroupIdByDiCodeForOnline

class GetGroupIdByDiCodeForOnlineResponse {
  List<Dgroup>? dgroup;

  GetGroupIdByDiCodeForOnlineResponse({this.dgroup});

  GetGroupIdByDiCodeForOnlineResponse.fromJson(Map<String, dynamic> json) {
    if (json['Dgroup'] != null) {
      dgroup = List<Dgroup>.empty(growable: true);
      json['Dgroup'].forEach((v) {
        dgroup!.add(Dgroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dgroup != null) {
      data['Dgroup'] = dgroup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dgroup {
  String? groupId;
  String? grpDesc;
  String? tranCateg;
  String? defaAmt;
  String? handChrg;
  String? servChrg;
  String? servTax;
  String? taxCode;
  String? priceIncludeGst;
  String? transtamp;
  String? totalTime;
  String? serialType;
  String? commAmt;
  String? agentCommAmt;
  String? cshSlsAcct;
  String? cshSlsDept;
  String? lesenType;
  String? onlineEnroll;
  String? productCode;
  String? productDesc1;
  String? productDesc2;
  String? fee;
  String? defaultPictureFilename;
  String? diCode;
  String? compCode;
  String? branchCode;
  String? lastupload;
  String? deleted;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_id'] = groupId;
    data['grp_desc'] = grpDesc;
    data['tran_categ'] = tranCateg;
    data['defa_amt'] = defaAmt;
    data['hand_chrg'] = handChrg;
    data['serv_chrg'] = servChrg;
    data['serv_tax'] = servTax;
    data['tax_code'] = taxCode;
    data['price_include_gst'] = priceIncludeGst;
    data['transtamp'] = transtamp;
    data['total_time'] = totalTime;
    data['serial_type'] = serialType;
    data['comm_amt'] = commAmt;
    data['agent_comm_amt'] = agentCommAmt;
    data['csh_sls_acct'] = cshSlsAcct;
    data['csh_sls_dept'] = cshSlsDept;
    data['lesen_type'] = lesenType;
    data['online_enroll'] = onlineEnroll;
    data['product_code'] = productCode;
    data['product_desc1'] = productDesc1;
    data['product_desc2'] = productDesc2;
    data['fee'] = fee;
    data['default_picture_filename'] = defaultPictureFilename;
    data['di_code'] = diCode;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['lastupload'] = lastupload;
    data['deleted'] = deleted;
    return data;
  }
}

// Save enrollment
class SaveEnrollmentRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? appCode;
  String? appId;
  String? diCode;
  String? groupId;
  String? icNo;
  String? name;
  String? nationality;
  String? phoneCountryCode;
  String? phone;
  String? dateOfBirthString;
  String? gender;
  String? race;
  String? add1;
  String? add2;
  String? add3;
  String? postcode;
  String? city;
  String? state;
  String? country;
  String? email;
  String? userId;
  List<int>? userProfileImage;
  String? userProfileImageBase64String;
  bool? removeUserProfileImage;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['appCode'] = appCode;
    data['appId'] = appId;
    data['diCode'] = diCode;
    data['groupId'] = groupId;
    data['icNo'] = icNo;
    data['name'] = name;
    data['nationality'] = nationality;
    data['phoneCountryCode'] = phoneCountryCode;
    data['phone'] = phone;
    data['dateOfBirthString'] = dateOfBirthString;
    data['gender'] = gender;
    data['race'] = race;
    data['add1'] = add1;
    data['add2'] = add2;
    data['add3'] = add3;
    data['postcode'] = postcode;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['email'] = email;
    data['userId'] = userId;
    data['userProfileImage'] = userProfileImage;
    data['userProfileImageBase64String'] = userProfileImageBase64String;
    data['removeUserProfileImage'] = removeUserProfileImage;
    return data;
  }
}

class SaveEnrollmentPackageRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? appCode;
  String? appId;
  String? diCode;
  String? packageCode;
  String? icNo;
  String? name;
  String? nationality;
  String? phoneCountryCode;
  String? phone;
  String? dateOfBirthString;
  String? gender;
  String? race;
  String? add1;
  String? add2;
  String? add3;
  String? postcode;
  String? city;
  String? state;
  String? country;
  String? email;
  String? userId;
  List<int>? userProfileImage;
  String? userProfileImageBase64String;
  bool? removeUserProfileImage;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['appCode'] = appCode;
    data['appId'] = appId;
    data['diCode'] = diCode;
    data['packageCode'] = packageCode;
    data['icNo'] = icNo;
    data['name'] = name;
    data['nationality'] = nationality;
    data['phoneCountryCode'] = phoneCountryCode;
    data['phone'] = phone;
    data['dateOfBirthString'] = dateOfBirthString;
    data['gender'] = gender;
    data['race'] = race;
    data['add1'] = add1;
    data['add2'] = add2;
    data['add3'] = add3;
    data['postcode'] = postcode;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['email'] = email;
    data['userId'] = userId;
    data['userProfileImage'] = userProfileImage;
    data['userProfileImageBase64String'] = userProfileImageBase64String;
    data['removeUserProfileImage'] = removeUserProfileImage;
    return data;
  }
}

class EnrollmentArguments {
  final String? diCode;
  final String? groupId;

  EnrollmentArguments({this.diCode, this.groupId});
}

// GetActiveFeedResponse
class GetActiveFeedResponse {
  List<Feed>? feed;

  GetActiveFeedResponse({this.feed});

  GetActiveFeedResponse.fromJson(Map<String, dynamic> json) {
    if (json['Feed'] != null) {
      feed = List<Feed>.empty(growable: true);
      json['Feed'].forEach((v) {
        feed!.add(Feed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feed != null) {
      data['Feed'] = feed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feed {
  String? iD;
  String? docDoc;
  String? docRef;
  String? feedDoc;
  String? feedRef;
  String? feedDesc;
  String? feedType;
  String? bgDate;
  String? durationDay;
  String? active;
  String? rowKey;
  String? feedText;
  String? feedMedia;
  String? feedMediaFilename;
  String? feedNavigate;
  String? udfReturnParameter;
  String? merchantNo;
  String? localFeed;
  String? remark;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? deleted;
  String? transtamp;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['feed_doc'] = feedDoc;
    data['feed_ref'] = feedRef;
    data['feed_desc'] = feedDesc;
    data['feed_type'] = feedType;
    data['bg_date'] = bgDate;
    data['duration_day'] = durationDay;
    data['active'] = active;
    data['row_key'] = rowKey;
    data['feed_text'] = feedText;
    data['feed_media'] = feedMedia;
    data['feed_media_filename'] = feedMediaFilename;
    data['feed_navigate'] = feedNavigate;
    data['udf_return_parameter'] = udfReturnParameter;
    data['merchant_no'] = merchantNo;
    data['local_feed'] = localFeed;
    data['remark'] = remark;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['deleted'] = deleted;
    data['transtamp'] = transtamp;
    return data;
  }
}

class GetActiveFeedByLevelResponse {
  List<FeedByLevel>? feed;

  GetActiveFeedByLevelResponse({this.feed});

  GetActiveFeedByLevelResponse.fromJson(Map<String, dynamic> json) {
    if (json['Feed'] != null) {
      feed = List<FeedByLevel>.empty(growable: true);
      json['Feed'].forEach((v) {
        feed!.add(FeedByLevel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feed != null) {
      data['Feed'] = feed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeedByLevel {
  String? iD;
  String? docDoc;
  String? docRef;
  String? feedDoc;
  String? feedRef;
  String? feedDesc;
  String? feedType;
  String? bgDate;
  String? durationDay;
  String? seqNo;
  String? active;
  String? rowKey;
  String? feedText;
  String? feedMedia;
  String? feedMediaFilename;
  String? feedNavigate;
  String? udfReturnParameter;
  String? merchantNo;
  String? localFeed;
  String? remark;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? deleted;
  String? transtamp;

  FeedByLevel(
      {this.iD,
      this.docDoc,
      this.docRef,
      this.feedDoc,
      this.feedRef,
      this.feedDesc,
      this.feedType,
      this.bgDate,
      this.durationDay,
      this.seqNo,
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

  FeedByLevel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    feedDoc = json['feed_doc'];
    feedRef = json['feed_ref'];
    feedDesc = json['feed_desc'];
    feedType = json['feed_type'];
    bgDate = json['bg_date'];
    durationDay = json['duration_day'];
    seqNo = json['seq_no'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['feed_doc'] = feedDoc;
    data['feed_ref'] = feedRef;
    data['feed_desc'] = feedDesc;
    data['feed_type'] = feedType;
    data['bg_date'] = bgDate;
    data['duration_day'] = durationDay;
    data['seq_no'] = seqNo;
    data['active'] = active;
    data['row_key'] = rowKey;
    data['feed_text'] = feedText;
    data['feed_media'] = feedMedia;
    data['feed_media_filename'] = feedMediaFilename;
    data['feed_navigate'] = feedNavigate;
    data['udf_return_parameter'] = udfReturnParameter;
    data['merchant_no'] = merchantNo;
    data['local_feed'] = localFeed;
    data['remark'] = remark;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['deleted'] = deleted;
    data['transtamp'] = transtamp;
    return data;
  }
}

// GetEnrollHistoryResponse
class GetEnrollHistoryResponse {
  List<Enroll>? enroll;

  GetEnrollHistoryResponse({this.enroll});

  GetEnrollHistoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['Enroll'] != null) {
      enroll = List<Enroll>.empty(growable: true);
      json['Enroll'].forEach((v) {
        enroll!.add(Enroll.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (enroll != null) {
      data['Enroll'] = enroll!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Enroll {
  String? id;
  String? icNo;
  String? trandate;
  String? groupId;
  String? kppGroupId;
  String? kppGroupId2;
  String? kppGroupId3;
  String? blacklisted;
  String? stuNo;
  String? dsCode;
  String? employeNo;
  String? introBy;
  String? commType;
  String? feesAgree;
  String? hrsAgree;
  String? addhrChrg;
  String? promptTes;
  String? totalPaid;
  String? retest;
  String? certNo;
  String? remark;
  String? tlHrsTak;
  String? exclIncml;
  String? sm4No;
  String? pickupPoint;
  String? transtamp;
  String? epretCode;
  String? epretReqid;
  String? ekppCode;
  String? ekppReqid;
  String? ej2bStat;
  String? eserRemark;
  String? ej2aTick;
  String? ej2bTick;
  String? addClass;
  String? userId;
  String? kpp02CertNo;
  String? kpp02CertPath;
  String? l2aPrnCount;
  String? l2bPrnCount;
  String? sm4PrnCount;
  String? deleted;
  String? productCode;
  String? diCode;
  String? compCode;
  String? branchCode;
  String? lastupload;
  String? status;
  String? fee;
  String? totalTime;
  String? name;
  String? sex;
  String? race;
  String? birthDt;
  String? citizenship;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ic_no'] = icNo;
    data['trandate'] = trandate;
    data['group_id'] = groupId;
    data['kpp_group_id'] = kppGroupId;
    data['kpp_group_id_2'] = kppGroupId2;
    data['kpp_group_id_3'] = kppGroupId3;
    data['blacklisted'] = blacklisted;
    data['stu_no'] = stuNo;
    data['ds_code'] = dsCode;
    data['employe_no'] = employeNo;
    data['intro_by'] = introBy;
    data['comm_type'] = commType;
    data['fees_agree'] = feesAgree;
    data['hrs_agree'] = hrsAgree;
    data['addhr_chrg'] = addhrChrg;
    data['prompt_tes'] = promptTes;
    data['total_paid'] = totalPaid;
    data['retest'] = retest;
    data['cert_no'] = certNo;
    data['remark'] = remark;
    data['tl_hrs_tak'] = tlHrsTak;
    data['excl_incml'] = exclIncml;
    data['sm4_no'] = sm4No;
    data['pickup_point'] = pickupPoint;
    data['transtamp'] = transtamp;
    data['epret_code'] = epretCode;
    data['epret_reqid'] = epretReqid;
    data['ekpp_code'] = ekppCode;
    data['ekpp_reqid'] = ekppReqid;
    data['ej2b_stat'] = ej2bStat;
    data['eser_remark'] = eserRemark;
    data['ej2a_tick'] = ej2aTick;
    data['ej2b_tick'] = ej2bTick;
    data['add_class'] = addClass;
    data['user_id'] = userId;
    data['kpp02_cert_no'] = kpp02CertNo;
    data['kpp02_cert_path'] = kpp02CertPath;
    data['l2a_prn_count'] = l2aPrnCount;
    data['l2b_prn_count'] = l2bPrnCount;
    data['sm4_prn_count'] = sm4PrnCount;
    data['deleted'] = deleted;
    data['product_code'] = productCode;
    data['di_code'] = diCode;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['lastupload'] = lastupload;
    data['status'] = status;
    data['fee'] = fee;
    data['total_time'] = totalTime;
    data['name'] = name;
    data['sex'] = sex;
    data['race'] = race;
    data['birth_dt'] = birthDt;
    data['citizenship'] = citizenship;
    return data;
  }
}

// Arguments
class EnrollmentData {
  String? phoneCountryCode;
  String? diCode;
  String? icNo;
  String? name;
  String? email;
  String? groupId;
  String? gender;
  String? dateOfBirthString;
  String? nationality;
  String? race;
  String? profilePic;

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
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? userId;

  DeleteAppMemberAccountRequest(
      {this.wsCodeCrypt, this.caUid, this.caPwd, this.userId});

  DeleteAppMemberAccountRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['userId'] = userId;
    return data;
  }
}

// New sign up
class RegisterRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? diCode;
  String? userId;
  String? name;
  String? nickName;
  String? icNo;
  String? passportNo;
  String? phoneCountryCode;
  String? phone;
  String? nationality;
  String? dateOfBirthString;
  String? gender;
  String? race;
  String? add1;
  String? add2;
  String? add3;
  String? postcode;
  String? city;
  String? state;
  String? country;
  String? email;
  String? signUpPwd;
  List<int>? userProfileImage;
  String? userProfileImageBase64String;
  bool? removeUserProfileImage;
  String? latitude;
  String? longitude;
  String? appCode;
  String? appId;
  String? deviceId;
  String? appVersion;
  String? deviceRemark;
  String? phDeviceId;
  String? phLine1Number;
  String? phNetOpName;
  String? phPhoneType;
  String? phSimSerialNo;
  String? bdBoard;
  String? bdBrand;
  String? bdDevice;
  String? bdDisplay;
  String? bdManufacturer;
  String? bdModel;
  String? bdProduct;
  String? pfDeviceId;
  String? regId;
  String? enqLdlGroup;
  String? cdlGroup;
  String? langCode;
  bool? findDrvJobs;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['diCode'] = diCode;
    data['userId'] = userId;
    data['name'] = name;
    data['nickName'] = nickName;
    data['icNo'] = icNo;
    data['passportNo'] = passportNo;
    data['phoneCountryCode'] = phoneCountryCode;
    data['phone'] = phone;
    data['nationality'] = nationality;
    data['dateOfBirthString'] = dateOfBirthString;
    data['gender'] = gender;
    data['race'] = race;
    data['add1'] = add1;
    data['add2'] = add2;
    data['add3'] = add3;
    data['postcode'] = postcode;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['email'] = email;
    data['signUpPwd'] = signUpPwd;
    data['userProfileImage'] = userProfileImage;
    data['userProfileImageBase64String'] = userProfileImageBase64String;
    data['removeUserProfileImage'] = removeUserProfileImage;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['appCode'] = appCode;
    data['appId'] = appId;
    data['deviceId'] = deviceId;
    data['appVersion'] = appVersion;
    data['deviceRemark'] = deviceRemark;
    data['phDeviceId'] = phDeviceId;
    data['phLine1Number'] = phLine1Number;
    data['phNetOpName'] = phNetOpName;
    data['phPhoneType'] = phPhoneType;
    data['phSimSerialNo'] = phSimSerialNo;
    data['bdBoard'] = bdBoard;
    data['bdBrand'] = bdBrand;
    data['bdDevice'] = bdDevice;
    data['bdDisplay'] = bdDisplay;
    data['bdManufacturer'] = bdManufacturer;
    data['bdModel'] = bdModel;
    data['bdProduct'] = bdProduct;
    data['pfDeviceId'] = pfDeviceId;
    data['regId'] = regId;
    data['enqLdlGroup'] = enqLdlGroup;
    data['cdlGroup'] = cdlGroup;
    data['langCode'] = langCode;
    data['findDrvJobs'] = findDrvJobs;
    return data;
  }
}

class SignUpArguments {
  String? phoneCountryCode;
  String? phone;
  String? verificationCode;

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
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? appCode;
  String? appId;
  String? appVersion;
  String? merchantNo;
  String? loginId;
  String? userId;
  String? bodyTemperature;
  String? scannedAppId;
  String? scannedAppVer;
  String? scannedLoginId;
  String? scannedUserId;
  String? scanCode;
  String? deviceRemark;
  String? phDeviceId;
  String? phLine1Number;
  String? phNetOpName;
  String? phPhoneType;
  String? phSimSerialNo;
  String? bdBoard;
  String? bdBrand;
  String? bdDevice;
  String? bdDisplay;
  String? bdManufacturer;
  String? bdModel;
  String? bdProduct;
  String? pfDeviceId;
  String? regId;
  String? latitude;
  String? longitude;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['appCode'] = appCode;
    data['appId'] = appId;
    data['appVersion'] = appVersion;
    data['merchantNo'] = merchantNo;
    data['loginId'] = loginId;
    data['userId'] = userId;
    data['bodyTemperature'] = bodyTemperature;
    data['scannedAppId'] = scannedAppId;
    data['scannedAppVer'] = scannedAppVer;
    data['scannedLoginId'] = scannedLoginId;
    data['scannedUserId'] = scannedUserId;
    data['scanCode'] = scanCode;
    data['deviceRemark'] = deviceRemark;
    data['phDeviceId'] = phDeviceId;
    data['phLine1Number'] = phLine1Number;
    data['phNetOpName'] = phNetOpName;
    data['phPhoneType'] = phPhoneType;
    data['phSimSerialNo'] = phSimSerialNo;
    data['bdBoard'] = bdBoard;
    data['bdBrand'] = bdBrand;
    data['bdDevice'] = bdDevice;
    data['bdDisplay'] = bdDisplay;
    data['bdManufacturer'] = bdManufacturer;
    data['bdModel'] = bdModel;
    data['bdProduct'] = bdProduct;
    data['pfDeviceId'] = pfDeviceId;
    data['regId'] = regId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

// Old Scan response
class ScanResponse {
  List<QRCode>? qRCode;

  ScanResponse({this.qRCode});

  ScanResponse.fromJson(Map<String, dynamic> json) {
    if (json['QRCode'] != null) {
      qRCode = List<QRCode>.empty(growable: true);
      json['QRCode'].forEach((v) {
        qRCode!.add(QRCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (qRCode != null) {
      data['QRCode'] = qRCode!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QRCode {
  String? appId;
  String? appVersion;
  String? loginId;
  String? name;
  String? userId;
  String? merchantDbCode;
  String? merchantName;
  String? merchantNo;

  QRCode(
      {this.appId,
      this.appVersion,
      this.loginId,
      this.name,
      this.userId,
      this.merchantDbCode,
      this.merchantName,
      this.merchantNo});

  QRCode.fromJson(Map<String, dynamic> json) {
    appId = json['appId'];
    appVersion = json['appVersion'];
    loginId = json['loginId'];
    name = json['name'];
    userId = json['userId'];
    merchantDbCode = json['merchantDbCode'];
    merchantName = json['merchantName'];
    merchantNo = json['merchantNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appId'] = appId;
    data['appVersion'] = appVersion;
    data['loginId'] = loginId;
    data['name'] = name;
    data['userId'] = userId;
    data['merchantDbCode'] = merchantDbCode;
    data['merchantName'] = merchantName;
    data['merchantNo'] = merchantNo;
    return data;
  }
}

// Scan Response
class CheckInScanResponse {
  List<CheckInQRCode>? table1;

  CheckInScanResponse({this.table1});

  CheckInScanResponse.fromJson(Map<String, dynamic> json) {
    if (json['Table1'] != null) {
      table1 = List<CheckInQRCode>.empty(growable: true);
      json['Table1'].forEach((v) {
        table1!.add(CheckInQRCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (table1 != null) {
      data['Table1'] = table1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckInQRCode {
  String? merchantNo;
  String? action;
  String? datetime;

  CheckInQRCode({this.merchantNo, this.action, this.datetime});

  CheckInQRCode.fromJson(Map<String, dynamic> json) {
    merchantNo = json['merchant_no'];
    action = json['action'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['merchant_no'] = merchantNo;
    data['action'] = action;
    data['datetime'] = datetime;
    return data;
  }
}

class ScanResultArgument {
  var barcode;
  String? status;

  ScanResultArgument({this.barcode, this.status});
}

class GetPackageListByPackageCodeListResponse {
  List<Package>? package;

  GetPackageListByPackageCodeListResponse({this.package});

  GetPackageListByPackageCodeListResponse.fromJson(Map<String, dynamic> json) {
    if (json['Package'] != null) {
      package = List<Package>.empty(growable: true);
      json['Package'].forEach((v) {
        package!.add(Package.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (package != null) {
      data['Package'] = package!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Package {
  String? iD;
  String? merchantNo;
  String? packageCode;
  String? packageDesc;
  String? packageName;
  String? groupIdGrouping;
  String? amt;
  String? termConditionPolicy;
  String? cancelPolicy;
  String? offerFrom;
  String? offerTo;
  String? paymentMode;
  String? paymentSchedule;
  String? feedMedia;
  String? feedMediaFilename;
  String? createDate;
  String? createUser;
  String? editDate;
  String? editUser;
  String? lastupload;
  String? transtamp;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? deleted;

  Package(
      {this.iD,
      this.merchantNo,
      this.packageCode,
      this.packageDesc,
      this.packageName,
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
    packageName = json['package_name'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['merchant_no'] = merchantNo;
    data['package_code'] = packageCode;
    data['package_desc'] = packageDesc;
    data['package_name'] = packageName;
    data['group_id_grouping'] = groupIdGrouping;
    data['amt'] = amt;
    data['term_condition_policy'] = termConditionPolicy;
    data['cancel_policy'] = cancelPolicy;
    data['offer_from'] = offerFrom;
    data['offer_to'] = offerTo;
    data['payment_mode'] = paymentMode;
    data['payment_schedule'] = paymentSchedule;
    data['feed_media'] = feedMedia;
    data['feed_media_filename'] = feedMediaFilename;
    data['create_date'] = createDate;
    data['create_user'] = createUser;
    data['edit_date'] = editDate;
    data['edit_user'] = editUser;
    data['lastupload'] = lastupload;
    data['transtamp'] = transtamp;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['deleted'] = deleted;
    return data;
  }
}

class GetPackageDetlListResponse {
  List<PackageDetl>? packageDetl;

  GetPackageDetlListResponse({this.packageDetl});

  GetPackageDetlListResponse.fromJson(Map<String, dynamic> json) {
    if (json['PackageDetl'] != null) {
      packageDetl = List<PackageDetl>.empty(growable: true);
      json['PackageDetl'].forEach((v) {
        packageDetl!.add(PackageDetl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (packageDetl != null) {
      data['PackageDetl'] = packageDetl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackageDetl {
  String? iD;
  String? merchantNo;
  String? packageCode;
  String? prodCode;
  String? groupId;
  String? qty;
  String? uom;
  String? amt;
  String? createDate;
  String? createUser;
  String? editDate;
  String? editUser;
  String? lastupload;
  String? transtamp;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? deleted;
  String? prodDesc;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['merchant_no'] = merchantNo;
    data['package_code'] = packageCode;
    data['prod_code'] = prodCode;
    data['group_id'] = groupId;
    data['qty'] = qty;
    data['uom'] = uom;
    data['amt'] = amt;
    data['create_date'] = createDate;
    data['create_user'] = createUser;
    data['edit_date'] = editDate;
    data['edit_user'] = editUser;
    data['lastupload'] = lastupload;
    data['transtamp'] = transtamp;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['deleted'] = deleted;
    data['prod_desc'] = prodDesc;
    return data;
  }
}

class GetAuthorizationStatusListResponse {
  List<AuthzStatus>? authzStatus;

  GetAuthorizationStatusListResponse({this.authzStatus});

  GetAuthorizationStatusListResponse.fromJson(Map<String, dynamic> json) {
    if (json['AuthzStatus'] != null) {
      authzStatus = List<AuthzStatus>.empty(growable: true);
      json['AuthzStatus'].forEach((v) {
        authzStatus!.add(AuthzStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (authzStatus != null) {
      data['AuthzStatus'] = authzStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AuthzStatus {
  String? authzStatus;

  AuthzStatus({this.authzStatus});

  AuthzStatus.fromJson(Map<String, dynamic> json) {
    authzStatus = json['authz_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authz_status'] = authzStatus;
    return data;
  }
}

// GetDeviceRequestList
class GetDeviceRequestListResponse {
  List<UserDevice>? userDevice;

  GetDeviceRequestListResponse({this.userDevice});

  GetDeviceRequestListResponse.fromJson(Map<String, dynamic> json) {
    if (json['UserDevice'] != null) {
      userDevice = List<UserDevice>.empty(growable: true);
      json['UserDevice'].forEach((v) {
        userDevice!.add(UserDevice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userDevice != null) {
      data['UserDevice'] = userDevice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserDevice {
  String? iD;
  String? merchantNo;
  String? userId;
  String? loginId;
  String? deviceId;
  String? deviceRegDatetime;
  String? authzStatus;
  String? lastAuthzDatetime;
  String? lastAuthzBy;
  String? appCode;
  String? appId;
  String? appVersion;
  String? deviceName;
  String? latitude;
  String? longitude;
  String? createUser;
  String? createDate;
  String? editUser;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? lastupload;
  String? transtamp;
  String? editDate;
  String? deleted;
  String? nickName;
  String? name;
  String? authzName;
  String? authzNickName;
  String? lastEditedBy;
  String? createdBy;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['merchant_no'] = merchantNo;
    data['user_id'] = userId;
    data['login_id'] = loginId;
    data['device_id'] = deviceId;
    data['device_reg_datetime'] = deviceRegDatetime;
    data['authz_status'] = authzStatus;
    data['last_authz_datetime'] = lastAuthzDatetime;
    data['last_authz_by'] = lastAuthzBy;
    data['app_code'] = appCode;
    data['app_id'] = appId;
    data['app_version'] = appVersion;
    data['device_name'] = deviceName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['lastupload'] = lastupload;
    data['transtamp'] = transtamp;
    data['edit_date'] = editDate;
    data['deleted'] = deleted;
    data['nick_name'] = nickName;
    data['name'] = name;
    data['authz_name'] = authzName;
    data['authz_nick_name'] = authzNickName;
    data['last_edited_by'] = lastEditedBy;
    data['created_by'] = createdBy;
    return data;
  }
}

// UpdateUserDeviceStatus

class UpdateUserDeviceStatusRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? merchantNo;
  String? userId;
  String? appCode;
  String? appId;
  String? deviceId;
  String? deviceMerchantNo;
  String? deviceUserId;
  String? deviceAppCode;
  String? deviceAppId;
  String? deviceDeviceId;
  String? deviceAuthzStatus;
  String? authzUser;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['merchantNo'] = merchantNo;
    data['userId'] = userId;
    data['appCode'] = appCode;
    data['appId'] = appId;
    data['deviceId'] = deviceId;
    data['deviceMerchantNo'] = deviceMerchantNo;
    data['deviceUserId'] = deviceUserId;
    data['deviceAppCode'] = deviceAppCode;
    data['deviceAppId'] = deviceAppId;
    data['deviceDeviceId'] = deviceDeviceId;
    data['deviceAuthzStatus'] = deviceAuthzStatus;
    data['authzUser'] = authzUser;
    return data;
  }
}

class GetLdlkEnqGroupListResponse {
  List<LdlEnqGroupList>? ldlEnqGroupList;

  GetLdlkEnqGroupListResponse({this.ldlEnqGroupList});

  GetLdlkEnqGroupListResponse.fromJson(Map<String, dynamic> json) {
    if (json['LdlEnqGroupList'] != null) {
      ldlEnqGroupList = List<LdlEnqGroupList>.empty(growable: true);
      json['LdlEnqGroupList'].forEach((v) {
        ldlEnqGroupList!.add(LdlEnqGroupList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ldlEnqGroupList != null) {
      data['LdlEnqGroupList'] =
          ldlEnqGroupList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LdlEnqGroupList {
  String? groupId;
  String? groupDesc;

  LdlEnqGroupList({this.groupId, this.groupDesc});

  LdlEnqGroupList.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    groupDesc = json['group_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_id'] = groupId;
    data['group_desc'] = groupDesc;
    return data;
  }
}

class GetCdlListResponse {
  List<CdlList>? cdlList;

  GetCdlListResponse({this.cdlList});

  GetCdlListResponse.fromJson(Map<String, dynamic> json) {
    if (json['CdlList'] != null) {
      cdlList = List<CdlList>.empty(growable: true);
      json['CdlList'].forEach((v) {
        cdlList!.add(CdlList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cdlList != null) {
      data['CdlList'] = cdlList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CdlList {
  String? groupId;
  String? groupDesc;

  CdlList({this.groupId, this.groupDesc});

  CdlList.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    groupDesc = json['group_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_id'] = groupId;
    data['group_desc'] = groupDesc;
    return data;
  }
}

class GetLanguageListResponse {
  List<LanguageList>? languageList;

  GetLanguageListResponse({this.languageList});

  GetLanguageListResponse.fromJson(Map<String, dynamic> json) {
    if (json['LanguageList'] != null) {
      languageList = List<LanguageList>.empty(growable: true);
      json['LanguageList'].forEach((v) {
        languageList!.add(LanguageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (languageList != null) {
      data['LanguageList'] = languageList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LanguageList {
  String? langCode;
  String? langDesc;

  LanguageList({this.langCode, this.langDesc});

  LanguageList.fromJson(Map<String, dynamic> json) {
    langCode = json['lang_code'];
    langDesc = json['lang_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lang_code'] = langCode;
    data['lang_desc'] = langDesc;
    return data;
  }
}

// Change password
class GetUserByUserIdPwdResponse {
  List<GetUserByUserIdPwdTable1>? table1;

  GetUserByUserIdPwdResponse({this.table1});

  GetUserByUserIdPwdResponse.fromJson(Map<String, dynamic> json) {
    if (json['Table1'] != null) {
      table1 = List<GetUserByUserIdPwdTable1>.empty(growable: true);
      json['Table1'].forEach((v) {
        table1!.add(GetUserByUserIdPwdTable1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (table1 != null) {
      data['Table1'] = table1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetUserByUserIdPwdTable1 {
  String? result;

  GetUserByUserIdPwdTable1({this.result});

  GetUserByUserIdPwdTable1.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    return data;
  }
}

class GetOrderListByDateRangeResponse {
  List<SlsTrn>? slsTrn;

  GetOrderListByDateRangeResponse({this.slsTrn});

  GetOrderListByDateRangeResponse.fromJson(Map<String, dynamic> json) {
    if (json['SlsTrn'] != null) {
      slsTrn = List<SlsTrn>.empty(growable: true);
      json['SlsTrn'].forEach((v) {
        slsTrn!.add(SlsTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (slsTrn != null) {
      data['SlsTrn'] = slsTrn!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SlsTrn {
  String? iD;
  String? merchantNo;
  String? docDoc;
  String? docRef;
  String? slsDoc;
  String? slsRef;
  String? revNo;
  String? ordDate;
  String? ordTime;
  String? wfStatus;
  String? refNo;
  String? subject;
  String? validity;
  String? leadTime;
  String? dbcode;
  String? icNo;
  String? name;
  String? branch;
  String? locCode;
  String? areaCode;
  String? currency;
  String? rate;
  String? terms;
  String? salesPer;
  String? projCode;
  String? orderBy;
  String? custPoNo;
  String? custPoDate;
  String? shipmentTerm;
  String? shipmentTermDetl;
  String? shipMode;
  String? shipCode;
  String? shipTo;
  String? shipName;
  String? shipAdd;
  String? shipAdd1;
  String? shipAdd2;
  String? shipAdd3;
  String? shipAdd4;
  String? shipArea;
  String? shipPhone;
  String? shipFax;
  String? shipPtc;
  String? shipRemark;
  String? misc1;
  String? misc2;
  String? misc3;
  String? misc4;
  String? misc5;
  String? misc6;
  String? misc13;
  String? misc14;
  String? misc15;
  String? misc16;
  String? misc17;
  String? misc18;
  String? tlOrdQty;
  String? tlOrdAmt;
  String? tlNettDetlAmt;
  String? tlLocDetlAmt;
  String? tlNettOrdAmt;
  String? tlLocOrdAmt;
  String? tlDiscAmt;
  String? tlLocDiscAmt;
  String? tlSlsTax;
  String? tlLocSlsTax;
  String? tlSerTax;
  String? tlLocSerTax;
  String? bdiscRate;
  String? bdiscAmt;
  String? transChrg;
  String? transRate;
  String? mfgCurrency;
  String? mfgRate;
  String? mfgTlNettOrdAmt;
  String? mfgTlLocOrdAmt;
  String? hold;
  String? cj5No;
  String? dbAcct;
  String? dbDept;
  String? tlDlvQty;
  String? doDoc;
  String? doRef;
  String? invDoc;
  String? invRef;
  String? title1;
  String? title2;
  String? title3;
  String? remark;
  String? remark1;
  String? remark2;
  String? prnCount;
  String? printLog;
  String? trnStatus;
  String? creditBlockReason;
  String? creditBlockInfo;
  String? creditReqApprv;
  String? creditApprvUser;
  String? creditApprvDate;
  String? creditApprvAmt;
  String? creditApprvLog;
  String? pending;
  String? cancel;
  String? cancelDate;
  String? posted;
  String? complete;
  String? clear;
  String? fullyBilled;
  String? tlBilledAmt;
  String? tlPaidAmt;
  String? readOnly;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? deleted;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? validateRemark;
  String? lastValidate;
  String? transtamp;
  String? accept;
  String? acceptUser;
  String? acceptDate;
  String? orderStatus;

  SlsTrn(
      {this.iD,
      this.merchantNo,
      this.docDoc,
      this.docRef,
      this.slsDoc,
      this.slsRef,
      this.revNo,
      this.ordDate,
      this.ordTime,
      this.wfStatus,
      this.refNo,
      this.subject,
      this.validity,
      this.leadTime,
      this.dbcode,
      this.icNo,
      this.name,
      this.branch,
      this.locCode,
      this.areaCode,
      this.currency,
      this.rate,
      this.terms,
      this.salesPer,
      this.projCode,
      this.orderBy,
      this.custPoNo,
      this.custPoDate,
      this.shipmentTerm,
      this.shipmentTermDetl,
      this.shipMode,
      this.shipCode,
      this.shipTo,
      this.shipName,
      this.shipAdd,
      this.shipAdd1,
      this.shipAdd2,
      this.shipAdd3,
      this.shipAdd4,
      this.shipArea,
      this.shipPhone,
      this.shipFax,
      this.shipPtc,
      this.shipRemark,
      this.misc1,
      this.misc2,
      this.misc3,
      this.misc4,
      this.misc5,
      this.misc6,
      this.misc13,
      this.misc14,
      this.misc15,
      this.misc16,
      this.misc17,
      this.misc18,
      this.tlOrdQty,
      this.tlOrdAmt,
      this.tlNettDetlAmt,
      this.tlLocDetlAmt,
      this.tlNettOrdAmt,
      this.tlLocOrdAmt,
      this.tlDiscAmt,
      this.tlLocDiscAmt,
      this.tlSlsTax,
      this.tlLocSlsTax,
      this.tlSerTax,
      this.tlLocSerTax,
      this.bdiscRate,
      this.bdiscAmt,
      this.transChrg,
      this.transRate,
      this.mfgCurrency,
      this.mfgRate,
      this.mfgTlNettOrdAmt,
      this.mfgTlLocOrdAmt,
      this.hold,
      this.cj5No,
      this.dbAcct,
      this.dbDept,
      this.tlDlvQty,
      this.doDoc,
      this.doRef,
      this.invDoc,
      this.invRef,
      this.title1,
      this.title2,
      this.title3,
      this.remark,
      this.remark1,
      this.remark2,
      this.prnCount,
      this.printLog,
      this.trnStatus,
      this.creditBlockReason,
      this.creditBlockInfo,
      this.creditReqApprv,
      this.creditApprvUser,
      this.creditApprvDate,
      this.creditApprvAmt,
      this.creditApprvLog,
      this.pending,
      this.cancel,
      this.cancelDate,
      this.posted,
      this.complete,
      this.clear,
      this.fullyBilled,
      this.tlBilledAmt,
      this.tlPaidAmt,
      this.readOnly,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.deleted,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.validateRemark,
      this.lastValidate,
      this.transtamp,
      this.accept,
      this.acceptUser,
      this.acceptDate,
      this.orderStatus});

  SlsTrn.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantNo = json['merchant_no'];
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    slsDoc = json['sls_doc'];
    slsRef = json['sls_ref'];
    revNo = json['rev_no'];
    ordDate = json['ord_date'];
    ordTime = json['ord_time'];
    wfStatus = json['wf_status'];
    refNo = json['ref_no'];
    subject = json['subject'];
    validity = json['validity'];
    leadTime = json['lead_time'];
    dbcode = json['dbcode'];
    icNo = json['ic_no'];
    name = json['name'];
    branch = json['branch'];
    locCode = json['loc_code'];
    areaCode = json['area_code'];
    currency = json['currency'];
    rate = json['rate'];
    terms = json['terms'];
    salesPer = json['sales_per'];
    projCode = json['proj_code'];
    orderBy = json['order_by'];
    custPoNo = json['cust_po_no'];
    custPoDate = json['cust_po_date'];
    shipmentTerm = json['shipment_term'];
    shipmentTermDetl = json['shipment_term_detl'];
    shipMode = json['ship_mode'];
    shipCode = json['ship_code'];
    shipTo = json['ship_to'];
    shipName = json['ship_name'];
    shipAdd = json['ship_add'];
    shipAdd1 = json['ship_add1'];
    shipAdd2 = json['ship_add2'];
    shipAdd3 = json['ship_add3'];
    shipAdd4 = json['ship_add4'];
    shipArea = json['ship_area'];
    shipPhone = json['ship_phone'];
    shipFax = json['ship_fax'];
    shipPtc = json['ship_ptc'];
    shipRemark = json['ship_remark'];
    misc1 = json['misc1'];
    misc2 = json['misc2'];
    misc3 = json['misc3'];
    misc4 = json['misc4'];
    misc5 = json['misc5'];
    misc6 = json['misc6'];
    misc13 = json['misc13'];
    misc14 = json['misc14'];
    misc15 = json['misc15'];
    misc16 = json['misc16'];
    misc17 = json['misc17'];
    misc18 = json['misc18'];
    tlOrdQty = json['tl_ord_qty'];
    tlOrdAmt = json['tl_ord_amt'];
    tlNettDetlAmt = json['tl_nett_detl_amt'];
    tlLocDetlAmt = json['tl_loc_detl_amt'];
    tlNettOrdAmt = json['tl_nett_ord_amt'];
    tlLocOrdAmt = json['tl_loc_ord_amt'];
    tlDiscAmt = json['tl_disc_amt'];
    tlLocDiscAmt = json['tl_loc_disc_amt'];
    tlSlsTax = json['tl_sls_tax'];
    tlLocSlsTax = json['tl_loc_sls_tax'];
    tlSerTax = json['tl_ser_tax'];
    tlLocSerTax = json['tl_loc_ser_tax'];
    bdiscRate = json['bdisc_rate'];
    bdiscAmt = json['bdisc_amt'];
    transChrg = json['trans_chrg'];
    transRate = json['trans_rate'];
    mfgCurrency = json['mfg_currency'];
    mfgRate = json['mfg_rate'];
    mfgTlNettOrdAmt = json['mfg_tl_nett_ord_amt'];
    mfgTlLocOrdAmt = json['mfg_tl_loc_ord_amt'];
    hold = json['hold'];
    cj5No = json['cj5_no'];
    dbAcct = json['db_acct'];
    dbDept = json['db_dept'];
    tlDlvQty = json['tl_dlv_qty'];
    doDoc = json['do_doc'];
    doRef = json['do_ref'];
    invDoc = json['inv_doc'];
    invRef = json['inv_ref'];
    title1 = json['title1'];
    title2 = json['title2'];
    title3 = json['title3'];
    remark = json['remark'];
    remark1 = json['remark1'];
    remark2 = json['remark2'];
    prnCount = json['prn_count'];
    printLog = json['print_log'];
    trnStatus = json['trn_status'];
    creditBlockReason = json['credit_block_reason'];
    creditBlockInfo = json['credit_block_info'];
    creditReqApprv = json['credit_req_apprv'];
    creditApprvUser = json['credit_apprv_user'];
    creditApprvDate = json['credit_apprv_date'];
    creditApprvAmt = json['credit_apprv_amt'];
    creditApprvLog = json['credit_apprv_log'];
    pending = json['pending'];
    cancel = json['cancel'];
    cancelDate = json['cancel_date'];
    posted = json['posted'];
    complete = json['complete'];
    clear = json['clear'];
    fullyBilled = json['fully_billed'];
    tlBilledAmt = json['tl_billed_amt'];
    tlPaidAmt = json['tl_paid_amt'];
    readOnly = json['read_only'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    validateRemark = json['validate_remark'];
    lastValidate = json['last_validate'];
    transtamp = json['transtamp'];
    accept = json['accept'];
    acceptUser = json['accept_user'];
    acceptDate = json['accept_date'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['merchant_no'] = merchantNo;
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['sls_doc'] = slsDoc;
    data['sls_ref'] = slsRef;
    data['rev_no'] = revNo;
    data['ord_date'] = ordDate;
    data['ord_time'] = ordTime;
    data['wf_status'] = wfStatus;
    data['ref_no'] = refNo;
    data['subject'] = subject;
    data['validity'] = validity;
    data['lead_time'] = leadTime;
    data['dbcode'] = dbcode;
    data['ic_no'] = icNo;
    data['name'] = name;
    data['branch'] = branch;
    data['loc_code'] = locCode;
    data['area_code'] = areaCode;
    data['currency'] = currency;
    data['rate'] = rate;
    data['terms'] = terms;
    data['sales_per'] = salesPer;
    data['proj_code'] = projCode;
    data['order_by'] = orderBy;
    data['cust_po_no'] = custPoNo;
    data['cust_po_date'] = custPoDate;
    data['shipment_term'] = shipmentTerm;
    data['shipment_term_detl'] = shipmentTermDetl;
    data['ship_mode'] = shipMode;
    data['ship_code'] = shipCode;
    data['ship_to'] = shipTo;
    data['ship_name'] = shipName;
    data['ship_add'] = shipAdd;
    data['ship_add1'] = shipAdd1;
    data['ship_add2'] = shipAdd2;
    data['ship_add3'] = shipAdd3;
    data['ship_add4'] = shipAdd4;
    data['ship_area'] = shipArea;
    data['ship_phone'] = shipPhone;
    data['ship_fax'] = shipFax;
    data['ship_ptc'] = shipPtc;
    data['ship_remark'] = shipRemark;
    data['misc1'] = misc1;
    data['misc2'] = misc2;
    data['misc3'] = misc3;
    data['misc4'] = misc4;
    data['misc5'] = misc5;
    data['misc6'] = misc6;
    data['misc13'] = misc13;
    data['misc14'] = misc14;
    data['misc15'] = misc15;
    data['misc16'] = misc16;
    data['misc17'] = misc17;
    data['misc18'] = misc18;
    data['tl_ord_qty'] = tlOrdQty;
    data['tl_ord_amt'] = tlOrdAmt;
    data['tl_nett_detl_amt'] = tlNettDetlAmt;
    data['tl_loc_detl_amt'] = tlLocDetlAmt;
    data['tl_nett_ord_amt'] = tlNettOrdAmt;
    data['tl_loc_ord_amt'] = tlLocOrdAmt;
    data['tl_disc_amt'] = tlDiscAmt;
    data['tl_loc_disc_amt'] = tlLocDiscAmt;
    data['tl_sls_tax'] = tlSlsTax;
    data['tl_loc_sls_tax'] = tlLocSlsTax;
    data['tl_ser_tax'] = tlSerTax;
    data['tl_loc_ser_tax'] = tlLocSerTax;
    data['bdisc_rate'] = bdiscRate;
    data['bdisc_amt'] = bdiscAmt;
    data['trans_chrg'] = transChrg;
    data['trans_rate'] = transRate;
    data['mfg_currency'] = mfgCurrency;
    data['mfg_rate'] = mfgRate;
    data['mfg_tl_nett_ord_amt'] = mfgTlNettOrdAmt;
    data['mfg_tl_loc_ord_amt'] = mfgTlLocOrdAmt;
    data['hold'] = hold;
    data['cj5_no'] = cj5No;
    data['db_acct'] = dbAcct;
    data['db_dept'] = dbDept;
    data['tl_dlv_qty'] = tlDlvQty;
    data['do_doc'] = doDoc;
    data['do_ref'] = doRef;
    data['inv_doc'] = invDoc;
    data['inv_ref'] = invRef;
    data['title1'] = title1;
    data['title2'] = title2;
    data['title3'] = title3;
    data['remark'] = remark;
    data['remark1'] = remark1;
    data['remark2'] = remark2;
    data['prn_count'] = prnCount;
    data['print_log'] = printLog;
    data['trn_status'] = trnStatus;
    data['credit_block_reason'] = creditBlockReason;
    data['credit_block_info'] = creditBlockInfo;
    data['credit_req_apprv'] = creditReqApprv;
    data['credit_apprv_user'] = creditApprvUser;
    data['credit_apprv_date'] = creditApprvDate;
    data['credit_apprv_amt'] = creditApprvAmt;
    data['credit_apprv_log'] = creditApprvLog;
    data['pending'] = pending;
    data['cancel'] = cancel;
    data['cancel_date'] = cancelDate;
    data['posted'] = posted;
    data['complete'] = complete;
    data['clear'] = clear;
    data['fully_billed'] = fullyBilled;
    data['tl_billed_amt'] = tlBilledAmt;
    data['tl_paid_amt'] = tlPaidAmt;
    data['read_only'] = readOnly;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['deleted'] = deleted;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['validate_remark'] = validateRemark;
    data['last_validate'] = lastValidate;
    data['transtamp'] = transtamp;
    data['accept'] = accept;
    data['accept_user'] = acceptUser;
    data['accept_date'] = acceptDate;
    data['order_status'] = orderStatus;
    return data;
  }
}

class AcceptOrderRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? diCode;
  String? userId;
  String? docDoc;
  String? docRef;

  AcceptOrderRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.diCode,
      this.userId,
      this.docDoc,
      this.docRef});

  AcceptOrderRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    userId = json['userId'];
    docDoc = json['docDoc'];
    docRef = json['docRef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['diCode'] = diCode;
    data['userId'] = userId;
    data['docDoc'] = docDoc;
    data['docRef'] = docRef;
    return data;
  }
}

class AcceptOrderResponse {
  List<AcceptOrderSlsTrn>? slsTrn;

  AcceptOrderResponse({this.slsTrn});

  AcceptOrderResponse.fromJson(Map<String, dynamic> json) {
    if (json['SlsTrn'] != null) {
      slsTrn = List<AcceptOrderSlsTrn>.empty(growable: true);
      json['SlsTrn'].forEach((v) {
        slsTrn!.add(AcceptOrderSlsTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (slsTrn != null) {
      data['SlsTrn'] = slsTrn!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AcceptOrderSlsTrn {
  String? iD;
  String? merchantNo;
  String? docDoc;
  String? docRef;
  String? slsDoc;
  String? slsRef;
  String? revNo;
  String? ordDate;
  String? ordTime;
  String? wfStatus;
  String? refNo;
  String? subject;
  String? validity;
  String? leadTime;
  String? dbcode;
  String? icNo;
  String? name;
  String? branch;
  String? locCode;
  String? areaCode;
  String? currency;
  String? rate;
  String? terms;
  String? salesPer;
  String? projCode;
  String? orderBy;
  String? custPoNo;
  String? custPoDate;
  String? shipmentTerm;
  String? shipmentTermDetl;
  String? shipMode;
  String? shipCode;
  String? shipTo;
  String? shipName;
  String? shipAdd;
  String? shipAdd1;
  String? shipAdd2;
  String? shipAdd3;
  String? shipAdd4;
  String? shipArea;
  String? shipPhone;
  String? shipFax;
  String? shipPtc;
  String? shipRemark;
  String? misc1;
  String? misc2;
  String? misc3;
  String? misc4;
  String? misc5;
  String? misc6;
  String? misc13;
  String? misc14;
  String? misc15;
  String? misc16;
  String? misc17;
  String? misc18;
  String? tlOrdQty;
  String? tlOrdAmt;
  String? tlNettDetlAmt;
  String? tlLocDetlAmt;
  String? tlNettOrdAmt;
  String? tlLocOrdAmt;
  String? tlDiscAmt;
  String? tlLocDiscAmt;
  String? tlSlsTax;
  String? tlLocSlsTax;
  String? tlSerTax;
  String? tlLocSerTax;
  String? bdiscRate;
  String? bdiscAmt;
  String? transChrg;
  String? transRate;
  String? mfgCurrency;
  String? mfgRate;
  String? mfgTlNettOrdAmt;
  String? mfgTlLocOrdAmt;
  String? hold;
  String? cj5No;
  String? dbAcct;
  String? dbDept;
  String? tlDlvQty;
  String? doDoc;
  String? doRef;
  String? invDoc;
  String? invRef;
  String? title1;
  String? title2;
  String? title3;
  String? remark;
  String? remark1;
  String? remark2;
  String? prnCount;
  String? printLog;
  String? trnStatus;
  String? accept;
  String? acceptUser;
  String? acceptDate;
  String? creditBlockReason;
  String? creditBlockInfo;
  String? creditReqApprv;
  String? creditApprvUser;
  String? creditApprvDate;
  String? creditApprvAmt;
  String? creditApprvLog;
  String? pending;
  String? cancel;
  String? cancelDate;
  String? posted;
  String? complete;
  String? clear;
  String? fullyBilled;
  String? tlBilledAmt;
  String? tlPaidAmt;
  String? readOnly;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? deleted;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? validateRemark;
  String? lastValidate;
  String? transtamp;
  String? packageCode;
  String? packageDesc;
  String? orderStatus;

  AcceptOrderSlsTrn(
      {this.iD,
      this.merchantNo,
      this.docDoc,
      this.docRef,
      this.slsDoc,
      this.slsRef,
      this.revNo,
      this.ordDate,
      this.ordTime,
      this.wfStatus,
      this.refNo,
      this.subject,
      this.validity,
      this.leadTime,
      this.dbcode,
      this.icNo,
      this.name,
      this.branch,
      this.locCode,
      this.areaCode,
      this.currency,
      this.rate,
      this.terms,
      this.salesPer,
      this.projCode,
      this.orderBy,
      this.custPoNo,
      this.custPoDate,
      this.shipmentTerm,
      this.shipmentTermDetl,
      this.shipMode,
      this.shipCode,
      this.shipTo,
      this.shipName,
      this.shipAdd,
      this.shipAdd1,
      this.shipAdd2,
      this.shipAdd3,
      this.shipAdd4,
      this.shipArea,
      this.shipPhone,
      this.shipFax,
      this.shipPtc,
      this.shipRemark,
      this.misc1,
      this.misc2,
      this.misc3,
      this.misc4,
      this.misc5,
      this.misc6,
      this.misc13,
      this.misc14,
      this.misc15,
      this.misc16,
      this.misc17,
      this.misc18,
      this.tlOrdQty,
      this.tlOrdAmt,
      this.tlNettDetlAmt,
      this.tlLocDetlAmt,
      this.tlNettOrdAmt,
      this.tlLocOrdAmt,
      this.tlDiscAmt,
      this.tlLocDiscAmt,
      this.tlSlsTax,
      this.tlLocSlsTax,
      this.tlSerTax,
      this.tlLocSerTax,
      this.bdiscRate,
      this.bdiscAmt,
      this.transChrg,
      this.transRate,
      this.mfgCurrency,
      this.mfgRate,
      this.mfgTlNettOrdAmt,
      this.mfgTlLocOrdAmt,
      this.hold,
      this.cj5No,
      this.dbAcct,
      this.dbDept,
      this.tlDlvQty,
      this.doDoc,
      this.doRef,
      this.invDoc,
      this.invRef,
      this.title1,
      this.title2,
      this.title3,
      this.remark,
      this.remark1,
      this.remark2,
      this.prnCount,
      this.printLog,
      this.trnStatus,
      this.accept,
      this.acceptUser,
      this.acceptDate,
      this.creditBlockReason,
      this.creditBlockInfo,
      this.creditReqApprv,
      this.creditApprvUser,
      this.creditApprvDate,
      this.creditApprvAmt,
      this.creditApprvLog,
      this.pending,
      this.cancel,
      this.cancelDate,
      this.posted,
      this.complete,
      this.clear,
      this.fullyBilled,
      this.tlBilledAmt,
      this.tlPaidAmt,
      this.readOnly,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.deleted,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.validateRemark,
      this.lastValidate,
      this.transtamp,
      this.packageCode,
      this.packageDesc,
      this.orderStatus});

  AcceptOrderSlsTrn.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantNo = json['merchant_no'];
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    slsDoc = json['sls_doc'];
    slsRef = json['sls_ref'];
    revNo = json['rev_no'];
    ordDate = json['ord_date'];
    ordTime = json['ord_time'];
    wfStatus = json['wf_status'];
    refNo = json['ref_no'];
    subject = json['subject'];
    validity = json['validity'];
    leadTime = json['lead_time'];
    dbcode = json['dbcode'];
    icNo = json['ic_no'];
    name = json['name'];
    branch = json['branch'];
    locCode = json['loc_code'];
    areaCode = json['area_code'];
    currency = json['currency'];
    rate = json['rate'];
    terms = json['terms'];
    salesPer = json['sales_per'];
    projCode = json['proj_code'];
    orderBy = json['order_by'];
    custPoNo = json['cust_po_no'];
    custPoDate = json['cust_po_date'];
    shipmentTerm = json['shipment_term'];
    shipmentTermDetl = json['shipment_term_detl'];
    shipMode = json['ship_mode'];
    shipCode = json['ship_code'];
    shipTo = json['ship_to'];
    shipName = json['ship_name'];
    shipAdd = json['ship_add'];
    shipAdd1 = json['ship_add1'];
    shipAdd2 = json['ship_add2'];
    shipAdd3 = json['ship_add3'];
    shipAdd4 = json['ship_add4'];
    shipArea = json['ship_area'];
    shipPhone = json['ship_phone'];
    shipFax = json['ship_fax'];
    shipPtc = json['ship_ptc'];
    shipRemark = json['ship_remark'];
    misc1 = json['misc1'];
    misc2 = json['misc2'];
    misc3 = json['misc3'];
    misc4 = json['misc4'];
    misc5 = json['misc5'];
    misc6 = json['misc6'];
    misc13 = json['misc13'];
    misc14 = json['misc14'];
    misc15 = json['misc15'];
    misc16 = json['misc16'];
    misc17 = json['misc17'];
    misc18 = json['misc18'];
    tlOrdQty = json['tl_ord_qty'];
    tlOrdAmt = json['tl_ord_amt'];
    tlNettDetlAmt = json['tl_nett_detl_amt'];
    tlLocDetlAmt = json['tl_loc_detl_amt'];
    tlNettOrdAmt = json['tl_nett_ord_amt'];
    tlLocOrdAmt = json['tl_loc_ord_amt'];
    tlDiscAmt = json['tl_disc_amt'];
    tlLocDiscAmt = json['tl_loc_disc_amt'];
    tlSlsTax = json['tl_sls_tax'];
    tlLocSlsTax = json['tl_loc_sls_tax'];
    tlSerTax = json['tl_ser_tax'];
    tlLocSerTax = json['tl_loc_ser_tax'];
    bdiscRate = json['bdisc_rate'];
    bdiscAmt = json['bdisc_amt'];
    transChrg = json['trans_chrg'];
    transRate = json['trans_rate'];
    mfgCurrency = json['mfg_currency'];
    mfgRate = json['mfg_rate'];
    mfgTlNettOrdAmt = json['mfg_tl_nett_ord_amt'];
    mfgTlLocOrdAmt = json['mfg_tl_loc_ord_amt'];
    hold = json['hold'];
    cj5No = json['cj5_no'];
    dbAcct = json['db_acct'];
    dbDept = json['db_dept'];
    tlDlvQty = json['tl_dlv_qty'];
    doDoc = json['do_doc'];
    doRef = json['do_ref'];
    invDoc = json['inv_doc'];
    invRef = json['inv_ref'];
    title1 = json['title1'];
    title2 = json['title2'];
    title3 = json['title3'];
    remark = json['remark'];
    remark1 = json['remark1'];
    remark2 = json['remark2'];
    prnCount = json['prn_count'];
    printLog = json['print_log'];
    trnStatus = json['trn_status'];
    accept = json['accept'];
    acceptUser = json['accept_user'];
    acceptDate = json['accept_date'];
    creditBlockReason = json['credit_block_reason'];
    creditBlockInfo = json['credit_block_info'];
    creditReqApprv = json['credit_req_apprv'];
    creditApprvUser = json['credit_apprv_user'];
    creditApprvDate = json['credit_apprv_date'];
    creditApprvAmt = json['credit_apprv_amt'];
    creditApprvLog = json['credit_apprv_log'];
    pending = json['pending'];
    cancel = json['cancel'];
    cancelDate = json['cancel_date'];
    posted = json['posted'];
    complete = json['complete'];
    clear = json['clear'];
    fullyBilled = json['fully_billed'];
    tlBilledAmt = json['tl_billed_amt'];
    tlPaidAmt = json['tl_paid_amt'];
    readOnly = json['read_only'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    validateRemark = json['validate_remark'];
    lastValidate = json['last_validate'];
    transtamp = json['transtamp'];
    packageCode = json['package_code'];
    packageDesc = json['package_desc'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['merchant_no'] = merchantNo;
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['sls_doc'] = slsDoc;
    data['sls_ref'] = slsRef;
    data['rev_no'] = revNo;
    data['ord_date'] = ordDate;
    data['ord_time'] = ordTime;
    data['wf_status'] = wfStatus;
    data['ref_no'] = refNo;
    data['subject'] = subject;
    data['validity'] = validity;
    data['lead_time'] = leadTime;
    data['dbcode'] = dbcode;
    data['ic_no'] = icNo;
    data['name'] = name;
    data['branch'] = branch;
    data['loc_code'] = locCode;
    data['area_code'] = areaCode;
    data['currency'] = currency;
    data['rate'] = rate;
    data['terms'] = terms;
    data['sales_per'] = salesPer;
    data['proj_code'] = projCode;
    data['order_by'] = orderBy;
    data['cust_po_no'] = custPoNo;
    data['cust_po_date'] = custPoDate;
    data['shipment_term'] = shipmentTerm;
    data['shipment_term_detl'] = shipmentTermDetl;
    data['ship_mode'] = shipMode;
    data['ship_code'] = shipCode;
    data['ship_to'] = shipTo;
    data['ship_name'] = shipName;
    data['ship_add'] = shipAdd;
    data['ship_add1'] = shipAdd1;
    data['ship_add2'] = shipAdd2;
    data['ship_add3'] = shipAdd3;
    data['ship_add4'] = shipAdd4;
    data['ship_area'] = shipArea;
    data['ship_phone'] = shipPhone;
    data['ship_fax'] = shipFax;
    data['ship_ptc'] = shipPtc;
    data['ship_remark'] = shipRemark;
    data['misc1'] = misc1;
    data['misc2'] = misc2;
    data['misc3'] = misc3;
    data['misc4'] = misc4;
    data['misc5'] = misc5;
    data['misc6'] = misc6;
    data['misc13'] = misc13;
    data['misc14'] = misc14;
    data['misc15'] = misc15;
    data['misc16'] = misc16;
    data['misc17'] = misc17;
    data['misc18'] = misc18;
    data['tl_ord_qty'] = tlOrdQty;
    data['tl_ord_amt'] = tlOrdAmt;
    data['tl_nett_detl_amt'] = tlNettDetlAmt;
    data['tl_loc_detl_amt'] = tlLocDetlAmt;
    data['tl_nett_ord_amt'] = tlNettOrdAmt;
    data['tl_loc_ord_amt'] = tlLocOrdAmt;
    data['tl_disc_amt'] = tlDiscAmt;
    data['tl_loc_disc_amt'] = tlLocDiscAmt;
    data['tl_sls_tax'] = tlSlsTax;
    data['tl_loc_sls_tax'] = tlLocSlsTax;
    data['tl_ser_tax'] = tlSerTax;
    data['tl_loc_ser_tax'] = tlLocSerTax;
    data['bdisc_rate'] = bdiscRate;
    data['bdisc_amt'] = bdiscAmt;
    data['trans_chrg'] = transChrg;
    data['trans_rate'] = transRate;
    data['mfg_currency'] = mfgCurrency;
    data['mfg_rate'] = mfgRate;
    data['mfg_tl_nett_ord_amt'] = mfgTlNettOrdAmt;
    data['mfg_tl_loc_ord_amt'] = mfgTlLocOrdAmt;
    data['hold'] = hold;
    data['cj5_no'] = cj5No;
    data['db_acct'] = dbAcct;
    data['db_dept'] = dbDept;
    data['tl_dlv_qty'] = tlDlvQty;
    data['do_doc'] = doDoc;
    data['do_ref'] = doRef;
    data['inv_doc'] = invDoc;
    data['inv_ref'] = invRef;
    data['title1'] = title1;
    data['title2'] = title2;
    data['title3'] = title3;
    data['remark'] = remark;
    data['remark1'] = remark1;
    data['remark2'] = remark2;
    data['prn_count'] = prnCount;
    data['print_log'] = printLog;
    data['trn_status'] = trnStatus;
    data['accept'] = accept;
    data['accept_user'] = acceptUser;
    data['accept_date'] = acceptDate;
    data['credit_block_reason'] = creditBlockReason;
    data['credit_block_info'] = creditBlockInfo;
    data['credit_req_apprv'] = creditReqApprv;
    data['credit_apprv_user'] = creditApprvUser;
    data['credit_apprv_date'] = creditApprvDate;
    data['credit_apprv_amt'] = creditApprvAmt;
    data['credit_apprv_log'] = creditApprvLog;
    data['pending'] = pending;
    data['cancel'] = cancel;
    data['cancel_date'] = cancelDate;
    data['posted'] = posted;
    data['complete'] = complete;
    data['clear'] = clear;
    data['fully_billed'] = fullyBilled;
    data['tl_billed_amt'] = tlBilledAmt;
    data['tl_paid_amt'] = tlPaidAmt;
    data['read_only'] = readOnly;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['deleted'] = deleted;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['validate_remark'] = validateRemark;
    data['last_validate'] = lastValidate;
    data['transtamp'] = transtamp;
    data['package_code'] = packageCode;
    data['package_desc'] = packageDesc;
    data['order_status'] = orderStatus;
    return data;
  }
}

class ValidateAppVersionResponse {
  List<AppMinVersion>? appMinVersion;

  ValidateAppVersionResponse({this.appMinVersion});

  ValidateAppVersionResponse.fromJson(Map<String, dynamic> json) {
    if (json['AppMinVersion'] != null) {
      appMinVersion = List<AppMinVersion>.empty(growable: true);
      json['AppMinVersion'].forEach((v) {
        appMinVersion!.add(AppMinVersion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (appMinVersion != null) {
      data['AppMinVersion'] =
          appMinVersion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppMinVersion {
  String? iD;
  String? appId;
  String? appMinVersion;
  String? appLatestVersion;
  String? newVerApplestoreUrl;
  String? newVerGooglestoreUrl;
  String? newVerAppgalleryUrl;
  String? newVerUrl;
  String? deleted;
  String? appCode;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? compCode;
  String? branchCode;
  String? transtamp;
  String? statusCode;
  String? statusMessage;

  AppMinVersion(
      {this.iD,
      this.appId,
      this.appMinVersion,
      this.appLatestVersion,
      this.newVerApplestoreUrl,
      this.newVerGooglestoreUrl,
      this.newVerAppgalleryUrl,
      this.newVerUrl,
      this.deleted,
      this.appCode,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.compCode,
      this.branchCode,
      this.transtamp,
      this.statusCode,
      this.statusMessage});

  AppMinVersion.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    appId = json['app_id'];
    appMinVersion = json['app_min_version'];
    appLatestVersion = json['app_latest_version'];
    newVerApplestoreUrl = json['new_ver_applestore_url'];
    newVerGooglestoreUrl = json['new_ver_googlestore_url'];
    newVerAppgalleryUrl = json['new_ver_appgallery_url'];
    newVerUrl = json['new_ver_url'];
    deleted = json['deleted'];
    appCode = json['app_code'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    transtamp = json['transtamp'];
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['app_id'] = appId;
    data['app_min_version'] = appMinVersion;
    data['app_latest_version'] = appLatestVersion;
    data['new_ver_applestore_url'] = newVerApplestoreUrl;
    data['new_ver_googlestore_url'] = newVerGooglestoreUrl;
    data['new_ver_appgallery_url'] = newVerAppgalleryUrl;
    data['new_ver_url'] = newVerUrl;
    data['deleted'] = deleted;
    data['app_code'] = appCode;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['transtamp'] = transtamp;
    data['status_code'] = statusCode;
    data['status_message'] = statusMessage;
    return data;
  }
}
