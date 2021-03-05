class GetMerchantTypeResponse {
  List<MerchantType> merchantType;

  GetMerchantTypeResponse({this.merchantType});

  GetMerchantTypeResponse.fromJson(Map<String, dynamic> json) {
    if (json['MerchantType'] != null) {
      merchantType = new List<MerchantType>.empty(growable: true);
      json['MerchantType'].forEach((v) {
        merchantType.add(new MerchantType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.merchantType != null) {
      data['MerchantType'] = this.merchantType.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MerchantType {
  String iD;
  String merchantType;
  String merchantTypeDesc;
  String merchantTypeIconFilename;
  String merchantTypeBannerFilename;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String deleted;
  String rowKey;
  String transtamp;

  MerchantType(
      {this.iD,
      this.merchantType,
      this.merchantTypeDesc,
      this.merchantTypeIconFilename,
      this.merchantTypeBannerFilename,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.deleted,
      this.rowKey,
      this.transtamp});

  MerchantType.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantType = json['merchant_type'];
    merchantTypeDesc = json['merchant_type_desc'];
    merchantTypeIconFilename = json['merchant_type_icon_filename'];
    merchantTypeBannerFilename = json['merchant_type_banner_filename'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['merchant_type'] = this.merchantType;
    data['merchant_type_desc'] = this.merchantTypeDesc;
    data['merchant_type_icon_filename'] = this.merchantTypeIconFilename;
    data['merchant_type_banner_filename'] = this.merchantTypeBannerFilename;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['deleted'] = this.deleted;
    data['row_key'] = this.rowKey;
    data['transtamp'] = this.transtamp;
    return data;
  }
}

// GetMerchantResponse
class GetMerchantResponse {
  List<Merchant> merchant;

  GetMerchantResponse({this.merchant});

  GetMerchantResponse.fromJson(Map<String, dynamic> json) {
    if (json['Merchant'] != null) {
      merchant = new List<Merchant>.empty(growable: true);
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
  String merchantIcon;
  String merchantIconFilename;
  String merchantProfilePhoto;
  String merchantProfilePhotoFilename;
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
  String remark;
  String status;
  String indCode;
  String merchantApplicationStatus;
  String merchantStatus;
  String joinDate;
  String expiryDate;
  String dbcode;
  String coIntro;
  String businessHour;
  String businessDay;
  String agentCode;
  String homeBanner;
  String coOverview;
  String businessInfo;
  String offerGive;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String deleted;
  String rowKey;
  String transtamp;
  String cityName;
  String lastEditedBy;
  String createdBy;
  String distance;
  String isEmpty;

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
      this.merchantIcon,
      this.merchantIconFilename,
      this.merchantProfilePhoto,
      this.merchantProfilePhotoFilename,
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
      this.remark,
      this.status,
      this.indCode,
      this.merchantApplicationStatus,
      this.merchantStatus,
      this.joinDate,
      this.expiryDate,
      this.dbcode,
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
      this.cityName,
      this.lastEditedBy,
      this.createdBy,
      this.distance,
      this.isEmpty});

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
    merchantIcon = json['merchant_icon'];
    merchantIconFilename = json['merchant_icon_filename'];
    merchantProfilePhoto = json['merchant_profile_photo'];
    merchantProfilePhotoFilename = json['merchant_profile_photo_filename'];
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
    remark = json['remark'];
    status = json['status'];
    indCode = json['ind_code'];
    merchantApplicationStatus = json['merchant_application_status'];
    merchantStatus = json['merchant_status'];
    joinDate = json['join_date'];
    expiryDate = json['expiry_date'];
    dbcode = json['dbcode'];
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
    cityName = json['city_name'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
    distance = json['distance'];
    isEmpty = json['isEmpty'];
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
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['ind_code'] = this.indCode;
    data['merchant_application_status'] = this.merchantApplicationStatus;
    data['merchant_status'] = this.merchantStatus;
    data['join_date'] = this.joinDate;
    data['expiry_date'] = this.expiryDate;
    data['dbcode'] = this.dbcode;
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
    data['city_name'] = this.cityName;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    data['distance'] = this.distance;
    data['isEmpty'] = this.isEmpty;
    return data;
  }
}
