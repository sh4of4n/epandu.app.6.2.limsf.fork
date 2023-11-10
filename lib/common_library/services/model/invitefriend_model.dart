class MemberByPhoneResponse {
  String? iD;
  String? merchantNo;
  String? userId;
  String? phone;
  String? name;
  String? nickName;
  String? eMail;
  String? add;
  String? add1;
  String? add2;
  String? add3;
  String? postcode;
  String? cityName;
  String? stateName;
  String? countryName;
  String? icNo;
  String? birthDate;
  String? nationality;
  String? race;
  String? gender;
  String? enqLdlGroup;
  String? cdlGroup;
  String? userPhoto;
  String? userPhotoFilename;
  String? editDate;
  String? picturePath;

  MemberByPhoneResponse(
      {this.iD,
      this.merchantNo,
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
      this.enqLdlGroup,
      this.cdlGroup,
      this.userPhoto,
      this.userPhotoFilename,
      this.editDate,
      this.picturePath});

  MemberByPhoneResponse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] ?? '';
    merchantNo = json['merchant_no'] ?? '';
    userId = json['user_id'] ?? '';
    phone = json['phone'] ?? '';
    name = json['name'] ?? '';
    nickName = json['nick_name'] ?? '';
    eMail = json['e_mail'] ?? '';
    add = json['add'] ?? '';
    add1 = json['add1'] ?? '';
    add2 = json['add2'] ?? '';
    add3 = json['add3'] ?? '';
    postcode = json['postcode'] ?? '';
    cityName = json['city_name'] ?? '';
    stateName = json['state_name'] ?? '';
    countryName = json['country_name'] ?? '';
    icNo = json['ic_no'] ?? '';
    birthDate = json['birth_date'] ?? '';
    nationality = json['nationality'] ?? '';
    race = json['race'] ?? '';
    gender = json['gender'] ?? '';
    enqLdlGroup = json['enq_ldl_group'] ?? '';
    cdlGroup = json['cdl_group'] ?? '';
    userPhoto = json['user_photo'] ?? '';
    userPhotoFilename = json['user_photo_filename'] ?? '';
    editDate = json['edit_date'] ?? '';
    picturePath = json['picture_path'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['merchant_no'] = merchantNo;
    data['user_id'] = userId;
    data['phone'] = phone;
    data['name'] = name;
    data['nick_name'] = nickName;
    data['e_mail'] = eMail;
    data['add'] = add;
    data['add1'] = add1;
    data['add2'] = add2;
    data['add3'] = add3;
    data['postcode'] = postcode;
    data['city_name'] = cityName;
    data['state_name'] = stateName;
    data['country_name'] = countryName;
    data['ic_no'] = icNo;
    data['birth_date'] = birthDate;
    data['nationality'] = nationality;
    data['race'] = race;
    data['gender'] = gender;
    data['enq_ldl_group'] = enqLdlGroup;
    data['cdl_group'] = cdlGroup;
    data['user_photo'] = userPhoto;
    data['user_photo_filename'] = userPhotoFilename;
    data['edit_date'] = editDate;
    data['picture_path'] = picturePath;
    return data;
  }
}

class GetMemberByPhoneResponse {
  List<MemberByPhoneResponse>? userProfile;

  GetMemberByPhoneResponse({this.userProfile});

  GetMemberByPhoneResponse.fromJson(Map<String, dynamic> json) {
    if (json['UserProfile'] != null) {
      userProfile = List<MemberByPhoneResponse>.empty(growable: true);
      json['UserProfile'].forEach((v) {
        userProfile!.add(MemberByPhoneResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userProfile != null) {
      data['UserProfile'] = userProfile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
