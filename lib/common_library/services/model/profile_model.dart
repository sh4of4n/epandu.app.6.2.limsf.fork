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
      userProfile = new List<UserProfile>();
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
