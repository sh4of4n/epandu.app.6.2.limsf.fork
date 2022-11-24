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
    iD = json['ID'];
    merchantNo = json['merchant_no'];
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
    enqLdlGroup = json['enq_ldl_group'];
    cdlGroup = json['cdl_group'];
    userPhoto = json['user_photo'];
    userPhotoFilename = json['user_photo_filename'];
    editDate = json['edit_date'];
    picturePath = json['picture_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['merchant_no'] = this.merchantNo;
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
    data['enq_ldl_group'] = this.enqLdlGroup;
    data['cdl_group'] = this.cdlGroup;
    data['user_photo'] = this.userPhoto;
    data['user_photo_filename'] = this.userPhotoFilename;
    data['edit_date'] = this.editDate;
    data['picture_path'] = this.picturePath;
    return data;
  }
}

class GetMemberByPhoneResponse {
  List<MemberByPhoneResponse>? userProfile;

  GetMemberByPhoneResponse({this.userProfile});

  GetMemberByPhoneResponse.fromJson(Map<String, dynamic> json) {
    if (json['UserProfile'] != null) {
      userProfile = new List<MemberByPhoneResponse>.empty(growable: true);
      json['UserProfile'].forEach((v) {
        userProfile!.add(new MemberByPhoneResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userProfile != null) {
      data['UserProfile'] = this.userProfile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
