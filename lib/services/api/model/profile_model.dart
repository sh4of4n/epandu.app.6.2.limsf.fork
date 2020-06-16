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
  String race;
  String address;
  String postcode;
  String state;
  String country;
  String email;
  List<int> userProfileImage;
  String userProfileImageBase64String;
  bool removeUserProfileImage;

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
      this.race,
      this.address,
      this.postcode,
      this.state,
      this.country,
      this.email,
      this.userProfileImage,
      this.userProfileImageBase64String,
      this.removeUserProfileImage});

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
    race = json['race'];
    address = json['address'];
    postcode = json['postcode'];
    state = json['state'];
    country = json['country'];
    email = json['email'];
    userProfileImage = json['userProfileImage'];
    userProfileImageBase64String = json['userProfileImageBase64String'];
    removeUserProfileImage = json['removeUserProfileImage'];
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
    data['race'] = this.race;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['state'] = this.state;
    data['country'] = this.country;
    data['email'] = this.email;
    data['userProfileImage'] = this.userProfileImage;
    data['userProfileImageBase64String'] = this.userProfileImageBase64String;
    data['removeUserProfileImage'] = this.removeUserProfileImage;
    return data;
  }
}
