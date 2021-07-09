import 'package:hive/hive.dart';

part 'kpp_model.g.dart';

class InstituteLogoResponse {
  List<Armaster>? armaster;

  InstituteLogoResponse({this.armaster});

  InstituteLogoResponse.fromJson(Map<String, dynamic> json) {
    if (json['Armaster'] != null) {
      armaster = new List<Armaster>.empty(growable: true);
      json['Armaster'].forEach((v) {
        armaster!.add(new Armaster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.armaster != null) {
      data['Armaster'] = this.armaster!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Armaster {
  String? iD;
  String? merchantNo;
  String? company;
  String? brno;
  String? merchantDesc;
  String? merchantType;
  String? name;
  String? shortName;
  String? category;
  String? merchantIcon;
  String? merchantIconFilename;
  String? merchantProfilePhoto;
  String? merchantProfilePhotoFilename;
  String? merchantBanner;
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
  String? bgDate;
  String? durationDay;
  String? active;
  String? feedNavigate;
  String? udfReturnParameter;
  String? remark;
  String? status;
  String? indCode;
  String? merchantApplicationStatus;
  String? merchantStatus;
  String? acctUid;
  String? acctPwd;
  String? dbServer;
  String? dbName;
  String? dbUserId;
  String? dbUserPwd;
  String? dbPort;
  String? playStorePath;
  String? url;
  String? inviteSms;
  String? joinDate;
  String? expiryDate;
  String? dbcode;
  String? crcode;
  String? coIntro;
  String? businessHour;
  String? businessDay;
  String? agentCode;
  String? homeBanner;
  String? coOverview;
  String? businessInfo;
  String? offerGive;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? deleted;
  String? rowKey;
  String? transtamp;
  String? tmpCity;

  Armaster(
      {this.iD,
      this.merchantNo,
      this.company,
      this.brno,
      this.merchantDesc,
      this.merchantType,
      this.name,
      this.shortName,
      this.category,
      this.merchantIcon,
      this.merchantIconFilename,
      this.merchantProfilePhoto,
      this.merchantProfilePhotoFilename,
      this.merchantBanner,
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
      this.bgDate,
      this.durationDay,
      this.active,
      this.feedNavigate,
      this.udfReturnParameter,
      this.remark,
      this.status,
      this.indCode,
      this.merchantApplicationStatus,
      this.merchantStatus,
      this.acctUid,
      this.acctPwd,
      this.dbServer,
      this.dbName,
      this.dbUserId,
      this.dbUserPwd,
      this.dbPort,
      this.playStorePath,
      this.url,
      this.inviteSms,
      this.joinDate,
      this.expiryDate,
      this.dbcode,
      this.crcode,
      this.coIntro,
      this.businessHour,
      this.businessDay,
      this.agentCode,
      this.homeBanner,
      this.coOverview,
      this.businessInfo,
      this.offerGive,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.deleted,
      this.rowKey,
      this.transtamp,
      this.tmpCity});

  Armaster.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantNo = json['merchant_no'];
    company = json['company'];
    brno = json['brno'];
    merchantDesc = json['merchant_desc'];
    merchantType = json['merchant_type'];
    name = json['name'];
    shortName = json['short_name'];
    category = json['category'];
    merchantIcon = json['merchant_icon'];
    merchantIconFilename = json['merchant_icon_filename'];
    merchantProfilePhoto = json['merchant_profile_photo'];
    merchantProfilePhotoFilename = json['merchant_profile_photo_filename'];
    merchantBanner = json['merchant_banner'];
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
    bgDate = json['bg_date'];
    durationDay = json['duration_day'];
    active = json['active'];
    feedNavigate = json['feed_navigate'];
    udfReturnParameter = json['udf_return_parameter'];
    remark = json['remark'];
    status = json['status'];
    indCode = json['ind_code'];
    merchantApplicationStatus = json['merchant_application_status'];
    merchantStatus = json['merchant_status'];
    acctUid = json['acct_uid'];
    acctPwd = json['acct_pwd'];
    dbServer = json['db_server'];
    dbName = json['db_name'];
    dbUserId = json['db_user_id'];
    dbUserPwd = json['db_user_pwd'];
    dbPort = json['db_port'];
    playStorePath = json['play_store_path'];
    url = json['url'];
    inviteSms = json['invite_sms'];
    joinDate = json['join_date'];
    expiryDate = json['expiry_date'];
    dbcode = json['dbcode'];
    crcode = json['crcode'];
    coIntro = json['co_intro'];
    businessHour = json['business_hour'];
    businessDay = json['business_day'];
    agentCode = json['agent_code'];
    homeBanner = json['home_banner'];
    coOverview = json['co_overview'];
    businessInfo = json['business_Info'];
    offerGive = json['offer_give'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
    tmpCity = json['tmp_city'];
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
    data['merchant_icon'] = this.merchantIcon;
    data['merchant_icon_filename'] = this.merchantIconFilename;
    data['merchant_profile_photo'] = this.merchantProfilePhoto;
    data['merchant_profile_photo_filename'] = this.merchantProfilePhotoFilename;
    data['merchant_banner'] = this.merchantBanner;
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
    data['bg_date'] = this.bgDate;
    data['duration_day'] = this.durationDay;
    data['active'] = this.active;
    data['feed_navigate'] = this.feedNavigate;
    data['udf_return_parameter'] = this.udfReturnParameter;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['ind_code'] = this.indCode;
    data['merchant_application_status'] = this.merchantApplicationStatus;
    data['merchant_status'] = this.merchantStatus;
    data['acct_uid'] = this.acctUid;
    data['acct_pwd'] = this.acctPwd;
    data['db_server'] = this.dbServer;
    data['db_name'] = this.dbName;
    data['db_user_id'] = this.dbUserId;
    data['db_user_pwd'] = this.dbUserPwd;
    data['db_port'] = this.dbPort;
    data['play_store_path'] = this.playStorePath;
    data['url'] = this.url;
    data['invite_sms'] = this.inviteSms;
    data['join_date'] = this.joinDate;
    data['expiry_date'] = this.expiryDate;
    data['dbcode'] = this.dbcode;
    data['crcode'] = this.crcode;
    data['co_intro'] = this.coIntro;
    data['business_hour'] = this.businessHour;
    data['business_day'] = this.businessDay;
    data['agent_code'] = this.agentCode;
    data['home_banner'] = this.homeBanner;
    data['co_overview'] = this.coOverview;
    data['business_Info'] = this.businessInfo;
    data['offer_give'] = this.offerGive;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['deleted'] = this.deleted;
    data['row_key'] = this.rowKey;
    data['transtamp'] = this.transtamp;
    data['tmp_city'] = this.tmpCity;
    return data;
  }
}

class GetPaperNoResponse {
  List<PaperNo>? paperNo;

  GetPaperNoResponse({this.paperNo});

  GetPaperNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['PaperNo'] != null) {
      paperNo = new List<PaperNo>.empty(growable: true);
      json['PaperNo'].forEach((v) {
        paperNo!.add(new PaperNo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paperNo != null) {
      data['PaperNo'] = this.paperNo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaperNo {
  String? paperNo;

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
  List<TheoryQuestion>? theoryQuestion;

  GetTheoryQuestionByPaperResponse({this.theoryQuestion});

  GetTheoryQuestionByPaperResponse.fromJson(Map<String, dynamic> json) {
    if (json['TheoryQuestion'] != null) {
      theoryQuestion = new List<TheoryQuestion>.empty(growable: true);
      json['TheoryQuestion'].forEach((v) {
        theoryQuestion!.add(new TheoryQuestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.theoryQuestion != null) {
      data['TheoryQuestion'] =
          this.theoryQuestion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TheoryQuestion {
  String? iD;
  String? groupId;
  String? courseCode;
  String? langCode;
  String? paperNo;
  String? key;
  String? section;
  String? questionNo;
  String? question;
  String? questionPhotoFilename;
  String? questionVoiceFilename;
  String? questionOption1;
  String? questionOption1Photo;
  String? questionOption1PhotoFilename;
  String? questionOption1VoiceFilename;
  String? questionOption2;
  String? questionOption2Photo;
  String? questionOption2PhotoFilename;
  String? questionOption2VoiceFilename;
  String? questionOption3;
  String? questionOption3Photo;
  String? questionOption3PhotoFilename;
  String? questionOption3VoiceFilename;
  String? questionOption4;
  String? questionOption4Photo;
  String? questionOption4PhotoFilename;
  String? questionOption4VoiceFilename;
  String? questionOption5;
  String? questionOption5Photo;
  String? questionOption5PhotoFilename;
  String? questionOption5VoiceFilename;
  String? optionA;
  String? optionAPhotoFilename;
  String? optionAVoiceFilename;
  String? optionB;
  String? optionBPhotoFilename;
  String? optionBVoiceFilename;
  String? optionC;
  String? optionCPhotoFilename;
  String? optionCVoiceFilename;
  String? optionD;
  String? optionDPhotoFilename;
  String? optionDVoiceFilename;
  String? optionE;
  String? optionEPhotoFilename;
  String? optionEVoiceFilename;
  String? answer;
  String? explanationUrl;
  String? knowledgeUrl;
  String? createUser;
  String? editUser;
  String? deleted;
  String? compCode;
  String? branchCode;
  String? lastupload;
  String? transtamp;
  String? optionAPhoto;
  String? optionBPhoto;
  String? optionCPhoto;
  String? optionDPhoto;
  String? optionEPhoto;
  String? questionPhoto;

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

class KppArguments {
  final groupId;
  final paperNo;

  KppArguments({
    this.groupId,
    this.paperNo,
  });
}

class PinRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? pinNumber;
  String? diCode;
  String? phone;
  String? userId;
  String? groupId;
  String? courseCode;

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
  final String? selectedAnswer;

  @HiveField(1)
  final int? answerIndex;

  @HiveField(2)
  final int? examQuestionNo; // The index

  @HiveField(3)
  final int? correct;

  @HiveField(4)
  final int? incorrect;

  @HiveField(5)
  final int? totalQuestions;

  @HiveField(6)
  final String? second;

  @HiveField(7)
  final String? minute;

  @HiveField(8)
  final String? groupId;

  @HiveField(9)
  final String? paperNo;

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
