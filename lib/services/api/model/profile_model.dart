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
  String address;
  String postcode;
  String state;
  String country;
  String email;

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
      this.email});

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
    return data;
  }
}
