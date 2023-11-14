class GetPickUpByIcNoResponse {
  List<Pickup>? pickup;

  GetPickUpByIcNoResponse({this.pickup});

  GetPickUpByIcNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['Pickup'] != null) {
      pickup = List<Pickup>.empty(growable: true);
      json['Pickup'].forEach((v) {
        pickup!.add(Pickup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pickup != null) {
      data['Pickup'] = pickup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pickup {
  String? pickupDate;
  String? pickupTime;
  String? destination;
  String? status;

  Pickup({this.pickupDate, this.pickupTime, this.destination, this.status});

  Pickup.fromJson(Map<String, dynamic> json) {
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    destination = json['destination'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pickup_date'] = pickupDate;
    data['pickup_time'] = pickupTime;
    data['destination'] = destination;
    data['status'] = status;
    return data;
  }
}

// SavePickUp
class SavePickupRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? diCode;
  String? pickupDate;
  String? pickupTime;
  String? destination;
  String? icNo;
  String? userId;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['diCode'] = diCode;
    data['pickupDate'] = pickupDate;
    data['pickupTime'] = pickupTime;
    data['destination'] = destination;
    data['icNo'] = icNo;
    data['userId'] = userId;
    return data;
  }
}
