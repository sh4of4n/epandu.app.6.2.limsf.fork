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
  String caUid;
  String caPwd;
  String diCode;
  String userId;
  String name;
  String icNo;
  String address;
  String postcode;
  String state;
  String country;
  String email;
  String nationality;
  String dateOfBirthString;
  String race;
  String appId;
  String appCode;
  String nickName;

  SaveProfileRequest(
      {this.wsCodeCrypt,
        this.caUid,
        this.caPwd,
        this.diCode,
        this.userId,
        this.name,
        this.address,
        this.postcode,
        this.state,
        this.country,
        this.email,
        this.icNo,
        this.nationality,
        this.dateOfBirthString,
        this.race,
        this.appId,
        this.appCode,
        this.nickName,
      });

  SaveProfileRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    userId = json['userId'];
    name = json['name'];
    address = json['address'];
    postcode = json['postcode'];
    state = json['state'];
    country = json['country'];
    email = json['email'];
    icNo = json['icNo'];
    nationality = json['nationality'];
    dateOfBirthString = json['dateOfBirthString'];
    race = json['race'];
    appId = json['appId'];
    appCode = json['appCode'];
    nickName = json['nickName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['state'] = this.state;
    data['country'] = this.country;
    data['email'] = this.email;
    data['icNo'] = this.icNo;
    data['nationality'] = this.nationality;
    data['dateOfBirthString'] = this.dateOfBirthString;
    data['race'] = this.race;
    data['appCode'] = this.appCode;
    data['appId'] = this.appId;
    data['nickName'] = this.nickName;
    return data;
  }
}
