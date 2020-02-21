import 'package:hive/hive.dart';

part 'kpp_model.g.dart';

class InstituteLogoResponse {
  List<Armaster> armaster;

  InstituteLogoResponse({this.armaster});

  InstituteLogoResponse.fromJson(Map<String, dynamic> json) {
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
  String mobileTopupPin;
  String remittanceTopupPin;
  String securityQuestion;
  String securityAnswer;
  String securityAnswerAttempt;
  String authorizationName;
  String authorizationPhoneCountryCode;
  String authorizationEmail;
  String commRateUom;
  String compBrn;
  String organisationType;
  String fax;
  String bankName;
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
  String createUser;
  String editUser;
  String transtamp;
  String deleted;
  String lastEditedBy;
  dynamic createdBy;

  Armaster(
      {this.iD,
      this.diCode,
      this.distributor,
      this.masterAgent,
      this.sponsor,
      this.dbcode,
      this.userType,
      this.level,
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
      this.nationality,
      this.gender,
      this.phone,
      this.phoneCountryCode,
      this.mobilePlan,
      this.telco,
      this.eMail,
      this.mobileTopupPin,
      this.remittanceTopupPin,
      this.securityQuestion,
      this.securityAnswer,
      this.securityAnswerAttempt,
      this.authorizationName,
      this.authorizationPhoneCountryCode,
      this.authorizationEmail,
      this.commRateUom,
      this.compBrn,
      this.organisationType,
      this.fax,
      this.bankName,
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
      this.createUser,
      this.editUser,
      this.transtamp,
      this.deleted,
      this.lastEditedBy,
      this.createdBy});

  Armaster.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    diCode = json['di_code'];
    distributor = json['distributor'];
    masterAgent = json['master_agent'];
    sponsor = json['sponsor'];
    dbcode = json['dbcode'];
    userType = json['user_type'];
    level = json['level'];
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
    nationality = json['nationality'];
    gender = json['gender'];
    phone = json['phone'];
    phoneCountryCode = json['phone_country_code'];
    mobilePlan = json['mobile_plan'];
    telco = json['telco'];
    eMail = json['e_mail'];
    mobileTopupPin = json['mobile_topup_pin'];
    remittanceTopupPin = json['remittance_topup_pin'];
    securityQuestion = json['security_question'];
    securityAnswer = json['security_answer'];
    securityAnswerAttempt = json['security_answer_attempt'];
    authorizationName = json['authorization_name'];
    authorizationPhoneCountryCode = json['authorization_phone_country_code'];
    authorizationEmail = json['authorization_email'];
    commRateUom = json['comm_rate_uom'];
    compBrn = json['comp_brn'];
    organisationType = json['organisation_type'];
    fax = json['fax'];
    bankName = json['bank_name'];
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
    createUser = json['create_user'];
    editUser = json['edit_user'];
    transtamp = json['transtamp'];
    deleted = json['deleted'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
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
    data['nationality'] = this.nationality;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['phone_country_code'] = this.phoneCountryCode;
    data['mobile_plan'] = this.mobilePlan;
    data['telco'] = this.telco;
    data['e_mail'] = this.eMail;
    data['mobile_topup_pin'] = this.mobileTopupPin;
    data['remittance_topup_pin'] = this.remittanceTopupPin;
    data['security_question'] = this.securityQuestion;
    data['security_answer'] = this.securityAnswer;
    data['security_answer_attempt'] = this.securityAnswerAttempt;
    data['authorization_name'] = this.authorizationName;
    data['authorization_phone_country_code'] =
        this.authorizationPhoneCountryCode;
    data['authorization_email'] = this.authorizationEmail;
    data['comm_rate_uom'] = this.commRateUom;
    data['comp_brn'] = this.compBrn;
    data['organisation_type'] = this.organisationType;
    data['fax'] = this.fax;
    data['bank_name'] = this.bankName;
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
    data['create_user'] = this.createUser;
    data['edit_user'] = this.editUser;
    data['transtamp'] = this.transtamp;
    data['deleted'] = this.deleted;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}

class GetPaperNoResponse {
  List<PaperNo> paperNo;

  GetPaperNoResponse({this.paperNo});

  GetPaperNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['PaperNo'] != null) {
      paperNo = new List<PaperNo>();
      json['PaperNo'].forEach((v) {
        paperNo.add(new PaperNo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paperNo != null) {
      data['PaperNo'] = this.paperNo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaperNo {
  String paperNo;

  PaperNo({this.paperNo});

  PaperNo.fromJson(Map<String, dynamic> json) {
    paperNo = json['paper_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paper_no'] = this.paperNo;
    return data;
  }
}

class GetTheoryQuestionByPaperResponse {
  List<TheoryQuestion> theoryQuestion;

  GetTheoryQuestionByPaperResponse({this.theoryQuestion});

  GetTheoryQuestionByPaperResponse.fromJson(Map<String, dynamic> json) {
    if (json['TheoryQuestion'] != null) {
      theoryQuestion = new List<TheoryQuestion>();
      json['TheoryQuestion'].forEach((v) {
        theoryQuestion.add(new TheoryQuestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.theoryQuestion != null) {
      data['TheoryQuestion'] =
          this.theoryQuestion.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TheoryQuestion {
  String iD;
  String groupId;
  String courseCode;
  String langCode;
  String paperNo;
  String key;
  String section;
  String questionNo;
  String question;
  String questionPhotoFilename;
  String questionVoiceFilename;
  String questionOption1;
  String questionOption1Photo;
  String questionOption1PhotoFilename;
  String questionOption1VoiceFilename;
  String questionOption2;
  String questionOption2Photo;
  String questionOption2PhotoFilename;
  String questionOption2VoiceFilename;
  String questionOption3;
  String questionOption3Photo;
  String questionOption3PhotoFilename;
  String questionOption3VoiceFilename;
  String questionOption4;
  String questionOption4Photo;
  String questionOption4PhotoFilename;
  String questionOption4VoiceFilename;
  String questionOption5;
  String questionOption5Photo;
  String questionOption5PhotoFilename;
  String questionOption5VoiceFilename;
  String optionA;
  String optionAPhotoFilename;
  String optionAVoiceFilename;
  String optionB;
  String optionBPhotoFilename;
  String optionBVoiceFilename;
  String optionC;
  String optionCPhotoFilename;
  String optionCVoiceFilename;
  String optionD;
  String optionDPhotoFilename;
  String optionDVoiceFilename;
  String optionE;
  String optionEPhotoFilename;
  String optionEVoiceFilename;
  String answer;
  String explanationUrl;
  String knowledgeUrl;
  String createUser;
  String editUser;
  String deleted;
  String compCode;
  String branchCode;
  String lastupload;
  String transtamp;
  String optionAPhoto;
  String optionBPhoto;
  String optionCPhoto;
  String optionDPhoto;
  String optionEPhoto;
  String questionPhoto;

  TheoryQuestion(
      {this.iD,
      this.groupId,
      this.courseCode,
      this.langCode,
      this.paperNo,
      this.key,
      this.section,
      this.questionNo,
      this.question,
      this.questionPhotoFilename,
      this.questionVoiceFilename,
      this.questionOption1,
      this.questionOption1Photo,
      this.questionOption1PhotoFilename,
      this.questionOption1VoiceFilename,
      this.questionOption2,
      this.questionOption2Photo,
      this.questionOption2PhotoFilename,
      this.questionOption2VoiceFilename,
      this.questionOption3,
      this.questionOption3Photo,
      this.questionOption3PhotoFilename,
      this.questionOption3VoiceFilename,
      this.questionOption4,
      this.questionOption4Photo,
      this.questionOption4PhotoFilename,
      this.questionOption4VoiceFilename,
      this.questionOption5,
      this.questionOption5Photo,
      this.questionOption5PhotoFilename,
      this.questionOption5VoiceFilename,
      this.optionA,
      this.optionAPhotoFilename,
      this.optionAVoiceFilename,
      this.optionB,
      this.optionBPhotoFilename,
      this.optionBVoiceFilename,
      this.optionC,
      this.optionCPhotoFilename,
      this.optionCVoiceFilename,
      this.optionD,
      this.optionDPhotoFilename,
      this.optionDVoiceFilename,
      this.optionE,
      this.optionEPhotoFilename,
      this.optionEVoiceFilename,
      this.answer,
      this.explanationUrl,
      this.knowledgeUrl,
      this.createUser,
      this.editUser,
      this.deleted,
      this.compCode,
      this.branchCode,
      this.lastupload,
      this.transtamp,
      this.optionAPhoto,
      this.optionBPhoto,
      this.optionCPhoto,
      this.optionDPhoto,
      this.optionEPhoto,
      this.questionPhoto});

  TheoryQuestion.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    groupId = json['group_id'];
    courseCode = json['course_code'];
    langCode = json['lang_code'];
    paperNo = json['paper_no'];
    key = json['key'];
    section = json['section'];
    questionNo = json['question_no'];
    question = json['question'];
    questionPhotoFilename = json['question_photo_filename'];
    questionVoiceFilename = json['question_voice_filename'];
    questionOption1 = json['question_option_1'];
    questionOption1Photo = json['question_option_1_photo'];
    questionOption1PhotoFilename = json['question_option_1_photo_filename'];
    questionOption1VoiceFilename = json['question_option_1_voice_filename'];
    questionOption2 = json['question_option_2'];
    questionOption2Photo = json['question_option_2_photo'];
    questionOption2PhotoFilename = json['question_option_2_photo_filename'];
    questionOption2VoiceFilename = json['question_option_2_voice_filename'];
    questionOption3 = json['question_option_3'];
    questionOption3Photo = json['question_option_3_photo'];
    questionOption3PhotoFilename = json['question_option_3_photo_filename'];
    questionOption3VoiceFilename = json['question_option_3_voice_filename'];
    questionOption4 = json['question_option_4'];
    questionOption4Photo = json['question_option_4_photo'];
    questionOption4PhotoFilename = json['question_option_4_photo_filename'];
    questionOption4VoiceFilename = json['question_option_4_voice_filename'];
    questionOption5 = json['question_option_5'];
    questionOption5Photo = json['question_option_5_photo'];
    questionOption5PhotoFilename = json['question_option_5_photo_filename'];
    questionOption5VoiceFilename = json['question_option_5_voice_filename'];
    optionA = json['option_a'];
    optionAPhotoFilename = json['option_a_photo_filename'];
    optionAVoiceFilename = json['option_a_voice_filename'];
    optionB = json['option_b'];
    optionBPhotoFilename = json['option_b_photo_filename'];
    optionBVoiceFilename = json['option_b_voice_filename'];
    optionC = json['option_c'];
    optionCPhotoFilename = json['option_c_photo_filename'];
    optionCVoiceFilename = json['option_c_voice_filename'];
    optionD = json['option_d'];
    optionDPhotoFilename = json['option_d_photo_filename'];
    optionDVoiceFilename = json['option_d_voice_filename'];
    optionE = json['option_e'];
    optionEPhotoFilename = json['option_e_photo_filename'];
    optionEVoiceFilename = json['option_e_voice_filename'];
    answer = json['answer'];
    explanationUrl = json['explanation_url'];
    knowledgeUrl = json['knowledge_url'];
    createUser = json['create_user'];
    editUser = json['edit_user'];
    deleted = json['deleted'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    lastupload = json['lastupload'];
    transtamp = json['transtamp'];
    optionAPhoto = json['option_a_photo'];
    optionBPhoto = json['option_b_photo'];
    optionCPhoto = json['option_c_photo'];
    optionDPhoto = json['option_d_photo'];
    optionEPhoto = json['option_e_photo'];
    questionPhoto = json['question_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['group_id'] = this.groupId;
    data['course_code'] = this.courseCode;
    data['lang_code'] = this.langCode;
    data['paper_no'] = this.paperNo;
    data['key'] = this.key;
    data['section'] = this.section;
    data['question_no'] = this.questionNo;
    data['question'] = this.question;
    data['question_photo_filename'] = this.questionPhotoFilename;
    data['question_voice_filename'] = this.questionVoiceFilename;
    data['question_option_1'] = this.questionOption1;
    data['question_option_1_photo'] = this.questionOption1Photo;
    data['question_option_1_photo_filename'] =
        this.questionOption1PhotoFilename;
    data['question_option_1_voice_filename'] =
        this.questionOption1VoiceFilename;
    data['question_option_2'] = this.questionOption2;
    data['question_option_2_photo'] = this.questionOption2Photo;
    data['question_option_2_photo_filename'] =
        this.questionOption2PhotoFilename;
    data['question_option_2_voice_filename'] =
        this.questionOption2VoiceFilename;
    data['question_option_3'] = this.questionOption3;
    data['question_option_3_photo'] = this.questionOption3Photo;
    data['question_option_3_photo_filename'] =
        this.questionOption3PhotoFilename;
    data['question_option_3_voice_filename'] =
        this.questionOption3VoiceFilename;
    data['question_option_4'] = this.questionOption4;
    data['question_option_4_photo'] = this.questionOption4Photo;
    data['question_option_4_photo_filename'] =
        this.questionOption4PhotoFilename;
    data['question_option_4_voice_filename'] =
        this.questionOption4VoiceFilename;
    data['question_option_5'] = this.questionOption5;
    data['question_option_5_photo'] = this.questionOption5Photo;
    data['question_option_5_photo_filename'] =
        this.questionOption5PhotoFilename;
    data['question_option_5_voice_filename'] =
        this.questionOption5VoiceFilename;
    data['option_a'] = this.optionA;
    data['option_a_photo_filename'] = this.optionAPhotoFilename;
    data['option_a_voice_filename'] = this.optionAVoiceFilename;
    data['option_b'] = this.optionB;
    data['option_b_photo_filename'] = this.optionBPhotoFilename;
    data['option_b_voice_filename'] = this.optionBVoiceFilename;
    data['option_c'] = this.optionC;
    data['option_c_photo_filename'] = this.optionCPhotoFilename;
    data['option_c_voice_filename'] = this.optionCVoiceFilename;
    data['option_d'] = this.optionD;
    data['option_d_photo_filename'] = this.optionDPhotoFilename;
    data['option_d_voice_filename'] = this.optionDVoiceFilename;
    data['option_e'] = this.optionE;
    data['option_e_photo_filename'] = this.optionEPhotoFilename;
    data['option_e_voice_filename'] = this.optionEVoiceFilename;
    data['answer'] = this.answer;
    data['explanation_url'] = this.explanationUrl;
    data['knowledge_url'] = this.knowledgeUrl;
    data['create_user'] = this.createUser;
    data['edit_user'] = this.editUser;
    data['deleted'] = this.deleted;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['lastupload'] = this.lastupload;
    data['transtamp'] = this.transtamp;
    data['option_a_photo'] = this.optionAPhoto;
    data['option_b_photo'] = this.optionBPhoto;
    data['option_c_photo'] = this.optionCPhoto;
    data['option_d_photo'] = this.optionDPhoto;
    data['option_e_photo'] = this.optionEPhoto;
    data['question_photo'] = this.questionPhoto;
    return data;
  }
}

class KppModuleArguments {
  final groupId;
  final paperNo;

  KppModuleArguments({
    this.groupId,
    this.paperNo,
  });
}

class PinRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String pinNumber;
  String diCode;
  String phone;
  String userId;
  String groupId;
  String courseCode;

  PinRequest({
    this.wsCodeCrypt,
    this.caUid,
    this.caPwd,
    this.pinNumber,
    this.diCode,
    this.phone,
    this.userId,
    this.groupId,
    this.courseCode,
  });

  PinRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    pinNumber = json['pinNumber'];
    diCode = json['diCode'];
    phone = json['phone'];
    userId = json['userId'];
    groupId = json['groupId'];
    courseCode = json['courseCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['pinNumber'] = this.pinNumber;
    data['diCode'] = this.diCode;
    data['phone'] = this.phone;
    data['userId'] = this.userId;
    data['groupId'] = this.groupId;
    data['courseCode'] = this.courseCode;
    return data;
  }
}

@HiveType(typeId: 0)
class KppExamData {
  @HiveField(0)
  final String selectedAnswer;

  @HiveField(1)
  final int answerIndex;

  @HiveField(2)
  final int examQuestionNo; // The index

  @HiveField(3)
  final int correct;

  @HiveField(4)
  final int incorrect;

  @HiveField(5)
  final int totalQuestions;

  @HiveField(6)
  final String second;

  @HiveField(7)
  final String minute;

  @HiveField(8)
  final String groupId;

  @HiveField(9)
  final String paperNo;

  KppExamData({
    this.selectedAnswer,
    this.answerIndex,
    this.examQuestionNo,
    this.correct,
    this.incorrect,
    this.totalQuestions,
    this.second,
    this.minute,
    this.groupId,
    this.paperNo,
  });
}
