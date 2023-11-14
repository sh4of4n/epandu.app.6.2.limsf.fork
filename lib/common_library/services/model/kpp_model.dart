import 'package:hive/hive.dart';

part 'kpp_model.g.dart';

class InstituteLogoResponse {
  List<Armaster>? armaster;

  InstituteLogoResponse({this.armaster});

  InstituteLogoResponse.fromJson(Map<String, dynamic> json) {
    if (json['Armaster'] != null) {
      armaster = List<Armaster>.empty(growable: true);
      json['Armaster'].forEach((v) {
        armaster!.add(Armaster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (armaster != null) {
      data['Armaster'] = armaster!.map((v) => v.toJson()).toList();
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
    data['merchant_icon'] = merchantIcon;
    data['merchant_icon_filename'] = merchantIconFilename;
    data['merchant_profile_photo'] = merchantProfilePhoto;
    data['merchant_profile_photo_filename'] = merchantProfilePhotoFilename;
    data['merchant_banner'] = merchantBanner;
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
    data['bg_date'] = bgDate;
    data['duration_day'] = durationDay;
    data['active'] = active;
    data['feed_navigate'] = feedNavigate;
    data['udf_return_parameter'] = udfReturnParameter;
    data['remark'] = remark;
    data['status'] = status;
    data['ind_code'] = indCode;
    data['merchant_application_status'] = merchantApplicationStatus;
    data['merchant_status'] = merchantStatus;
    data['acct_uid'] = acctUid;
    data['acct_pwd'] = acctPwd;
    data['db_server'] = dbServer;
    data['db_name'] = dbName;
    data['db_user_id'] = dbUserId;
    data['db_user_pwd'] = dbUserPwd;
    data['db_port'] = dbPort;
    data['play_store_path'] = playStorePath;
    data['url'] = url;
    data['invite_sms'] = inviteSms;
    data['join_date'] = joinDate;
    data['expiry_date'] = expiryDate;
    data['dbcode'] = dbcode;
    data['crcode'] = crcode;
    data['co_intro'] = coIntro;
    data['business_hour'] = businessHour;
    data['business_day'] = businessDay;
    data['agent_code'] = agentCode;
    data['home_banner'] = homeBanner;
    data['co_overview'] = coOverview;
    data['business_Info'] = businessInfo;
    data['offer_give'] = offerGive;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['deleted'] = deleted;
    data['row_key'] = rowKey;
    data['transtamp'] = transtamp;
    data['tmp_city'] = tmpCity;
    return data;
  }
}

class GetPaperNoResponse {
  List<PaperNo>? paperNo;

  GetPaperNoResponse({this.paperNo});

  GetPaperNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['PaperNo'] != null) {
      paperNo = List<PaperNo>.empty(growable: true);
      json['PaperNo'].forEach((v) {
        paperNo!.add(PaperNo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paperNo != null) {
      data['PaperNo'] = paperNo!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paper_no'] = paperNo;
    return data;
  }
}

class GetTheoryQuestionByPaperResponse {
  List<TheoryQuestion>? theoryQuestion;

  GetTheoryQuestionByPaperResponse({this.theoryQuestion});

  GetTheoryQuestionByPaperResponse.fromJson(Map<String, dynamic> json) {
    if (json['TheoryQuestion'] != null) {
      theoryQuestion = List<TheoryQuestion>.empty(growable: true);
      json['TheoryQuestion'].forEach((v) {
        theoryQuestion!.add(TheoryQuestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (theoryQuestion != null) {
      data['TheoryQuestion'] =
          theoryQuestion!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['group_id'] = groupId;
    data['course_code'] = courseCode;
    data['lang_code'] = langCode;
    data['paper_no'] = paperNo;
    data['key'] = key;
    data['section'] = section;
    data['question_no'] = questionNo;
    data['question'] = question;
    data['question_photo_filename'] = questionPhotoFilename;
    data['question_voice_filename'] = questionVoiceFilename;
    data['question_option_1'] = questionOption1;
    data['question_option_1_photo'] = questionOption1Photo;
    data['question_option_1_photo_filename'] =
        questionOption1PhotoFilename;
    data['question_option_1_voice_filename'] =
        questionOption1VoiceFilename;
    data['question_option_2'] = questionOption2;
    data['question_option_2_photo'] = questionOption2Photo;
    data['question_option_2_photo_filename'] =
        questionOption2PhotoFilename;
    data['question_option_2_voice_filename'] =
        questionOption2VoiceFilename;
    data['question_option_3'] = questionOption3;
    data['question_option_3_photo'] = questionOption3Photo;
    data['question_option_3_photo_filename'] =
        questionOption3PhotoFilename;
    data['question_option_3_voice_filename'] =
        questionOption3VoiceFilename;
    data['question_option_4'] = questionOption4;
    data['question_option_4_photo'] = questionOption4Photo;
    data['question_option_4_photo_filename'] =
        questionOption4PhotoFilename;
    data['question_option_4_voice_filename'] =
        questionOption4VoiceFilename;
    data['question_option_5'] = questionOption5;
    data['question_option_5_photo'] = questionOption5Photo;
    data['question_option_5_photo_filename'] =
        questionOption5PhotoFilename;
    data['question_option_5_voice_filename'] =
        questionOption5VoiceFilename;
    data['option_a'] = optionA;
    data['option_a_photo_filename'] = optionAPhotoFilename;
    data['option_a_voice_filename'] = optionAVoiceFilename;
    data['option_b'] = optionB;
    data['option_b_photo_filename'] = optionBPhotoFilename;
    data['option_b_voice_filename'] = optionBVoiceFilename;
    data['option_c'] = optionC;
    data['option_c_photo_filename'] = optionCPhotoFilename;
    data['option_c_voice_filename'] = optionCVoiceFilename;
    data['option_d'] = optionD;
    data['option_d_photo_filename'] = optionDPhotoFilename;
    data['option_d_voice_filename'] = optionDVoiceFilename;
    data['option_e'] = optionE;
    data['option_e_photo_filename'] = optionEPhotoFilename;
    data['option_e_voice_filename'] = optionEVoiceFilename;
    data['answer'] = answer;
    data['explanation_url'] = explanationUrl;
    data['knowledge_url'] = knowledgeUrl;
    data['create_user'] = createUser;
    data['edit_user'] = editUser;
    data['deleted'] = deleted;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['lastupload'] = lastupload;
    data['transtamp'] = transtamp;
    data['option_a_photo'] = optionAPhoto;
    data['option_b_photo'] = optionBPhoto;
    data['option_c_photo'] = optionCPhoto;
    data['option_d_photo'] = optionDPhoto;
    data['option_e_photo'] = optionEPhoto;
    data['question_photo'] = questionPhoto;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['pinNumber'] = pinNumber;
    data['diCode'] = diCode;
    data['phone'] = phone;
    data['userId'] = userId;
    data['groupId'] = groupId;
    data['courseCode'] = courseCode;
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
