class GetPickUpByIcNoResponse {
  List<Pickup> pickup;

  GetPickUpByIcNoResponse({this.pickup});

  GetPickUpByIcNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['Pickup'] != null) {
      pickup = new List<Pickup>.empty(growable: true);
      json['Pickup'].forEach((v) {
        pickup.add(new Pickup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pickup != null) {
      data['Pickup'] = this.pickup.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pickup {
  String pickupDate;
  String pickupTime;
  String destination;
  String status;

  Pickup({this.pickupDate, this.pickupTime, this.destination, this.status});

  Pickup.fromJson(Map<String, dynamic> json) {
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    destination = json['destination'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pickup_date'] = this.pickupDate;
    data['pickup_time'] = this.pickupTime;
    data['destination'] = this.destination;
    data['status'] = this.status;
    return data;
  }
}

// SavePickUp
class SavePickupRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String diCode;
  String pickupDate;
  String pickupTime;
  String destination;
  String icNo;
  String userId;

  SavePickupRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.diCode,
      this.pickupDate,
      this.pickupTime,
      this.destination,
      this.icNo,
      this.userId});

  SavePickupRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    pickupDate = json['pickupDate'];
    pickupTime = json['pickupTime'];
    destination = json['destination'];
    icNo = json['icNo'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['pickupDate'] = this.pickupDate;
    data['pickupTime'] = this.pickupTime;
    data['destination'] = this.destination;
    data['icNo'] = this.icNo;
    data['userId'] = this.userId;
    return data;
  }
}
