/* class GetEnrollmentRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String diCode;
  String icNo;
  String groupId;

  GetEnrollmentRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.diCode,
      this.icNo,
      this.groupId});

  GetEnrollmentRequest.fromJson(Map<String, String> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    icNo = json['icNo'];
    groupId = json['groupId'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['icNo'] = this.icNo;
    data['groupId'] = this.groupId;
    return data;
  }
} */

class GetUserProfileResponse {
  List<UserProfile> userProfile;

  GetUserProfileResponse({this.userProfile});

  GetUserProfileResponse.fromJson(Map<String, dynamic> json) {
    if (json['UserProfile'] != null) {
      userProfile = new List<UserProfile>.empty(growable: true);
      json['UserProfile'].forEach((v) {
        userProfile.add(new UserProfile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userProfile != null) {
      data['UserProfile'] = this.userProfile.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserProfile {
  String iD;
  String userId;
  String phone;
  String name;
  String nickName;
  String eMail;
  String add;
  String add1;
  String add2;
  String add3;
  String postcode;
  String cityName;
  String stateName;
  String countryName;
  String icNo;
  String birthDate;
  String nationality;
  String race;
  String gender;
  String userPhoto;
  String userPhotoFilename;
  String editDate;
  String picturePath;

  UserProfile(
      {this.iD,
      this.userId,
      this.phone,
      this.name,
      this.nickName,
      this.eMail,
      this.add,
      this.add1,
      this.add2,
      this.add3,
      this.postcode,
      this.cityName,
      this.stateName,
      this.countryName,
      this.icNo,
      this.birthDate,
      this.nationality,
      this.race,
      this.gender,
      this.userPhoto,
      this.userPhotoFilename,
      this.editDate,
      this.picturePath});

  UserProfile.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userId = json['user_id'];
    phone = json['phone'];
    name = json['name'];
    nickName = json['nick_name'];
    eMail = json['e_mail'];
    add = json['add'];
    add1 = json['add1'];
    add2 = json['add2'];
    add3 = json['add3'];
    postcode = json['postcode'];
    cityName = json['city_name'];
    stateName = json['state_name'];
    countryName = json['country_name'];
    icNo = json['ic_no'];
    birthDate = json['birth_date'];
    nationality = json['nationality'];
    race = json['race'];
    gender = json['gender'];
    userPhoto = json['user_photo'];
    userPhotoFilename = json['user_photo_filename'];
    editDate = json['edit_date'];
    picturePath = json['picture_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['user_id'] = this.userId;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['nick_name'] = this.nickName;
    data['e_mail'] = this.eMail;
    data['add'] = this.add;
    data['add1'] = this.add1;
    data['add2'] = this.add2;
    data['add3'] = this.add3;
    data['postcode'] = this.postcode;
    data['city_name'] = this.cityName;
    data['state_name'] = this.stateName;
    data['country_name'] = this.countryName;
    data['ic_no'] = this.icNo;
    data['birth_date'] = this.birthDate;
    data['nationality'] = this.nationality;
    data['race'] = this.race;
    data['gender'] = this.gender;
    data['user_photo'] = this.userPhoto;
    data['user_photo_filename'] = this.userPhotoFilename;
    data['edit_date'] = this.editDate;
    data['picture_path'] = this.picturePath;
    return data;
  }
}

class SaveProfileRequest {
  String wsCodeCrypt;
  String appCode;
  String appId;
  String caUid;
  String caPwd;
  String diCode;
  String userId;
  String name;
  String nickName;
  String icNo;
  String nationality;
  String dateOfBirthString;
  String gender;
  String race;
  String address;
  String postcode;
  String state;
  String country;
  String email;
  List<int> userProfileImage;
  String userProfileImageBase64String;
  bool removeUserProfileImage;
  String enqLdlGroup;
  String cdlGroup;
  String langCode;
  bool findDrvJobs;

  SaveProfileRequest(
      {this.wsCodeCrypt,
      this.appCode,
      this.appId,
      this.caUid,
      this.caPwd,
      this.diCode,
      this.userId,
      this.name,
      this.nickName,
      this.icNo,
      this.nationality,
      this.dateOfBirthString,
      this.gender,
      this.race,
      this.address,
      this.postcode,
      this.state,
      this.country,
      this.email,
      this.userProfileImage,
      this.userProfileImageBase64String,
      this.removeUserProfileImage,
      this.enqLdlGroup,
      this.cdlGroup,
      this.langCode,
      this.findDrvJobs});

  SaveProfileRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    appCode = json['appCode'];
    appId = json['appId'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    userId = json['userId'];
    name = json['name'];
    nickName = json['nickName'];
    icNo = json['icNo'];
    nationality = json['nationality'];
    dateOfBirthString = json['dateOfBirthString'];
    gender = json['gender'];
    race = json['race'];
    address = json['address'];
    postcode = json['postcode'];
    state = json['state'];
    country = json['country'];
    email = json['email'];
    userProfileImage = json['userProfileImage'].cast<int>();
    userProfileImageBase64String = json['userProfileImageBase64String'];
    removeUserProfileImage = json['removeUserProfileImage'];
    enqLdlGroup = json['enqLdlGroup'];
    cdlGroup = json['cdlGroup'];
    langCode = json['langCode'];
    findDrvJobs = json['findDrvJobs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['appCode'] = this.appCode;
    data['appId'] = this.appId;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['nickName'] = this.nickName;
    data['icNo'] = this.icNo;
    data['nationality'] = this.nationality;
    data['dateOfBirthString'] = this.dateOfBirthString;
    data['gender'] = this.gender;
    data['race'] = this.race;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['state'] = this.state;
    data['country'] = this.country;
    data['email'] = this.email;
    data['userProfileImage'] = this.userProfileImage;
    data['userProfileImageBase64String'] = this.userProfileImageBase64String;
    data['removeUserProfileImage'] = this.removeUserProfileImage;
    data['enqLdlGroup'] = this.enqLdlGroup;
    data['cdlGroup'] = this.cdlGroup;
    data['langCode'] = this.langCode;
    data['findDrvJobs'] = this.findDrvJobs;
    return data;
  }
}

class GetTrainerListResponse {
  List<Trainer> trainer;

  GetTrainerListResponse({this.trainer});

  GetTrainerListResponse.fromJson(Map<String, dynamic> json) {
    if (json['Trainer'] != null) {
      trainer = new List<Trainer>.empty(growable: true);
      json['Trainer'].forEach((v) {
        trainer.add(new Trainer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trainer != null) {
      data['Trainer'] = this.trainer.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Trainer {
  String trnCode;
  String empno;
  String trnName;
  String addr1;
  String addr2;
  String addr3;
  String telHm;
  String telHp;
  String workGrpCode;
  String pagerNo;
  String descriptio;
  String defaAmt;
  String serTax;
  String handChrg;
  String serChrg;
  String deptCode;
  String offCatago;
  String remarks;
  String eduGrade;
  String jpjNote;
  String certNo;
  String certExpDt;
  String kppGroupId;
  String spimGroupId;
  String qtiGroupId;
  String sm2No;
  String sm2ExpDt;
  String calCode;
  String transtamp;
  String nric;
  String oldIc;
  String validGroupId;
  String blacklist;
  String remark;
  String photo;
  String compCode;
  String branchCode;
  String rowKey;
  String lastupload;
  String deleted;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String merchantNo;
  String iD;
  String lastEditedBy;
  String createdBy;

  Trainer(
      {this.trnCode,
      this.empno,
      this.trnName,
      this.addr1,
      this.addr2,
      this.addr3,
      this.telHm,
      this.telHp,
      this.workGrpCode,
      this.pagerNo,
      this.descriptio,
      this.defaAmt,
      this.serTax,
      this.handChrg,
      this.serChrg,
      this.deptCode,
      this.offCatago,
      this.remarks,
      this.eduGrade,
      this.jpjNote,
      this.certNo,
      this.certExpDt,
      this.kppGroupId,
      this.spimGroupId,
      this.qtiGroupId,
      this.sm2No,
      this.sm2ExpDt,
      this.calCode,
      this.transtamp,
      this.nric,
      this.oldIc,
      this.validGroupId,
      this.blacklist,
      this.remark,
      this.photo,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.lastupload,
      this.deleted,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.merchantNo,
      this.iD,
      this.lastEditedBy,
      this.createdBy});

  Trainer.fromJson(Map<String, dynamic> json) {
    trnCode = json['trn_code'];
    empno = json['empno'];
    trnName = json['trn_name'];
    addr1 = json['addr1'];
    addr2 = json['addr2'];
    addr3 = json['addr3'];
    telHm = json['tel_hm'];
    telHp = json['tel_hp'];
    workGrpCode = json['work_grp_code'];
    pagerNo = json['pager_no'];
    descriptio = json['descriptio'];
    defaAmt = json['defa_amt'];
    serTax = json['ser_tax'];
    handChrg = json['hand_chrg'];
    serChrg = json['ser_chrg'];
    deptCode = json['dept_code'];
    offCatago = json['off_catago'];
    remarks = json['remarks'];
    eduGrade = json['edu_grade'];
    jpjNote = json['jpj_note'];
    certNo = json['cert_no'];
    certExpDt = json['cert_exp_dt'];
    kppGroupId = json['kpp_group_id'];
    spimGroupId = json['spim_group_id'];
    qtiGroupId = json['qti_group_id'];
    sm2No = json['sm2_no'];
    sm2ExpDt = json['sm2_exp_dt'];
    calCode = json['cal_code'];
    transtamp = json['transtamp'];
    nric = json['nric'];
    oldIc = json['old_ic'];
    validGroupId = json['valid_group_id'];
    blacklist = json['blacklist'];
    remark = json['remark'];
    photo = json['photo'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    lastupload = json['lastupload'];
    deleted = json['deleted'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    merchantNo = json['merchant_no'];
    iD = json['ID'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trn_code'] = this.trnCode;
    data['empno'] = this.empno;
    data['trn_name'] = this.trnName;
    data['addr1'] = this.addr1;
    data['addr2'] = this.addr2;
    data['addr3'] = this.addr3;
    data['tel_hm'] = this.telHm;
    data['tel_hp'] = this.telHp;
    data['work_grp_code'] = this.workGrpCode;
    data['pager_no'] = this.pagerNo;
    data['descriptio'] = this.descriptio;
    data['defa_amt'] = this.defaAmt;
    data['ser_tax'] = this.serTax;
    data['hand_chrg'] = this.handChrg;
    data['ser_chrg'] = this.serChrg;
    data['dept_code'] = this.deptCode;
    data['off_catago'] = this.offCatago;
    data['remarks'] = this.remarks;
    data['edu_grade'] = this.eduGrade;
    data['jpj_note'] = this.jpjNote;
    data['cert_no'] = this.certNo;
    data['cert_exp_dt'] = this.certExpDt;
    data['kpp_group_id'] = this.kppGroupId;
    data['spim_group_id'] = this.spimGroupId;
    data['qti_group_id'] = this.qtiGroupId;
    data['sm2_no'] = this.sm2No;
    data['sm2_exp_dt'] = this.sm2ExpDt;
    data['cal_code'] = this.calCode;
    data['transtamp'] = this.transtamp;
    data['nric'] = this.nric;
    data['old_ic'] = this.oldIc;
    data['valid_group_id'] = this.validGroupId;
    data['blacklist'] = this.blacklist;
    data['remark'] = this.remark;
    data['photo'] = this.photo;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['lastupload'] = this.lastupload;
    data['deleted'] = this.deleted;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['merchant_no'] = this.merchantNo;
    data['ID'] = this.iD;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}

class GetVehicleListResponse {
  List<GetVehicleListVehicle> vehicle;

  GetVehicleListResponse({this.vehicle});

  GetVehicleListResponse.fromJson(Map<String, dynamic> json) {
    if (json['Vehicle'] != null) {
      vehicle = new List<GetVehicleListVehicle>.empty(growable: true);
      json['Vehicle'].forEach((v) {
        vehicle.add(new GetVehicleListVehicle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vehicle != null) {
      data['Vehicle'] = this.vehicle.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetVehicleListVehicle {
  String vehNo;
  String groupId;
  String trnCode;
  String model;
  String engNo;
  String chasisNo;
  String typeModel;
  String year;
  String make;
  String rdtaxExp;
  String sm3No;
  String sm3Siri;
  String sm3IsuDt;
  String sm3ExpDt;
  String inspDt;
  String nxOilChg;
  String nxFilChg;
  String capacity;
  String kegunaan;
  String tonage;
  String rtExpDt;
  String jpjRec;
  String ispDate;
  String ispRecNo;
  String acctNo;
  String icNo;
  String balance;
  String insCom1;
  String insCom2;
  String expDt;
  String nextInspectDt;
  String transtamp;
  String inUsed;
  String deleted;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String compCode;
  String branchCode;
  String rowKey;
  String lastupload;
  String merchantNo;
  String iD;
  String lastEditedBy;
  String createdBy;

  GetVehicleListVehicle(
      {this.vehNo,
      this.groupId,
      this.trnCode,
      this.model,
      this.engNo,
      this.chasisNo,
      this.typeModel,
      this.year,
      this.make,
      this.rdtaxExp,
      this.sm3No,
      this.sm3Siri,
      this.sm3IsuDt,
      this.sm3ExpDt,
      this.inspDt,
      this.nxOilChg,
      this.nxFilChg,
      this.capacity,
      this.kegunaan,
      this.tonage,
      this.rtExpDt,
      this.jpjRec,
      this.ispDate,
      this.ispRecNo,
      this.acctNo,
      this.icNo,
      this.balance,
      this.insCom1,
      this.insCom2,
      this.expDt,
      this.nextInspectDt,
      this.transtamp,
      this.inUsed,
      this.deleted,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.lastupload,
      this.merchantNo,
      this.iD,
      this.lastEditedBy,
      this.createdBy});

  GetVehicleListVehicle.fromJson(Map<String, dynamic> json) {
    vehNo = json['veh_no'];
    groupId = json['group_id'];
    trnCode = json['trn_code'];
    model = json['model'];
    engNo = json['eng_no'];
    chasisNo = json['chasis_no'];
    typeModel = json['type_model'];
    year = json['year'];
    make = json['make'];
    rdtaxExp = json['rdtax_exp'];
    sm3No = json['sm3_no'];
    sm3Siri = json['sm3_siri'];
    sm3IsuDt = json['sm3_isu_dt'];
    sm3ExpDt = json['sm3_exp_dt'];
    inspDt = json['insp_dt'];
    nxOilChg = json['nx_oil_chg'];
    nxFilChg = json['nx_fil_chg'];
    capacity = json['capacity'];
    kegunaan = json['kegunaan'];
    tonage = json['tonage'];
    rtExpDt = json['rt_exp_dt'];
    jpjRec = json['jpj_rec'];
    ispDate = json['isp_date'];
    ispRecNo = json['isp_rec_no'];
    acctNo = json['acct_no'];
    icNo = json['ic_no'];
    balance = json['balance'];
    insCom1 = json['ins_com1'];
    insCom2 = json['ins_com2'];
    expDt = json['exp_dt'];
    nextInspectDt = json['next_inspect_dt'];
    transtamp = json['transtamp'];
    inUsed = json['in_used'];
    deleted = json['deleted'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    lastupload = json['lastupload'];
    merchantNo = json['merchant_no'];
    iD = json['ID'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['veh_no'] = this.vehNo;
    data['group_id'] = this.groupId;
    data['trn_code'] = this.trnCode;
    data['model'] = this.model;
    data['eng_no'] = this.engNo;
    data['chasis_no'] = this.chasisNo;
    data['type_model'] = this.typeModel;
    data['year'] = this.year;
    data['make'] = this.make;
    data['rdtax_exp'] = this.rdtaxExp;
    data['sm3_no'] = this.sm3No;
    data['sm3_siri'] = this.sm3Siri;
    data['sm3_isu_dt'] = this.sm3IsuDt;
    data['sm3_exp_dt'] = this.sm3ExpDt;
    data['insp_dt'] = this.inspDt;
    data['nx_oil_chg'] = this.nxOilChg;
    data['nx_fil_chg'] = this.nxFilChg;
    data['capacity'] = this.capacity;
    data['kegunaan'] = this.kegunaan;
    data['tonage'] = this.tonage;
    data['rt_exp_dt'] = this.rtExpDt;
    data['jpj_rec'] = this.jpjRec;
    data['isp_date'] = this.ispDate;
    data['isp_rec_no'] = this.ispRecNo;
    data['acct_no'] = this.acctNo;
    data['ic_no'] = this.icNo;
    data['balance'] = this.balance;
    data['ins_com1'] = this.insCom1;
    data['ins_com2'] = this.insCom2;
    data['exp_dt'] = this.expDt;
    data['next_inspect_dt'] = this.nextInspectDt;
    data['transtamp'] = this.transtamp;
    data['in_used'] = this.inUsed;
    data['deleted'] = this.deleted;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['lastupload'] = this.lastupload;
    data['merchant_no'] = this.merchantNo;
    data['ID'] = this.iD;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}
