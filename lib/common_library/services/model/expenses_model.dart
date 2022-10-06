class ExpFuelRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? merchantNo;
  String? loginId;
  String? fuelDatetimeString;
  String? mileage;
  String? fuelType;
  String? priceLiter;
  String? totalAmount;
  String? liter;
  double? lat;
  double? lng;
  String? fuelId;

  ExpFuelRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.merchantNo,
      this.loginId,
      this.fuelDatetimeString,
      this.mileage,
      this.fuelType,
      this.priceLiter,
      this.totalAmount,
      this.liter,
      this.lat,
      this.lng,
      this.fuelId});

  ExpFuelRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    merchantNo = json['merchantNo'];
    loginId = json['loginId'];
    fuelDatetimeString = json['fuelDatetimeString'];
    mileage = json['mileage'];
    fuelType = json['fuelType'];
    priceLiter = json['priceLiter'];
    totalAmount = json['totalAmount'];
    liter = json['liter'];
    lat = json['lat'];
    lng = json['lng'];
    fuelId = json['fuelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['merchantNo'] = this.merchantNo;
    data['loginId'] = this.loginId;
    data['fuelDatetimeString'] = this.fuelDatetimeString;
    data['mileage'] = this.mileage;
    data['fuelType'] = this.fuelType;
    data['priceLiter'] = this.priceLiter;
    data['totalAmount'] = this.totalAmount;
    data['liter'] = this.liter;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['fuelId'] = this.fuelId;
    return data;
  }
}

class ExpFuelResponse {
  List<ExpFuel>? expFuel;

  ExpFuelResponse({this.expFuel});

  ExpFuelResponse.fromJson(Map<String, dynamic> json) {
    if (json['ExpFuel'] != null) {
      expFuel = <ExpFuel>[];
      json['ExpFuel'].forEach((v) {
        expFuel!.add(new ExpFuel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.expFuel != null) {
      data['ExpFuel'] = this.expFuel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpFuel {
  String? loginId;
  String? merchantNo;
  String? iD;
  String? fuelDatetime;
  String? mileage;
  String? fuelType;
  String? priceLiter;
  String? totalAmount;
  String? liter;
  String? lng;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? transtamp;
  String? deleted;
  String? lat;
  String? fuelId;

  ExpFuel(
      {this.loginId,
      this.merchantNo,
      this.iD,
      this.fuelDatetime,
      this.mileage,
      this.fuelType,
      this.priceLiter,
      this.totalAmount,
      this.liter,
      this.lng,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.transtamp,
      this.deleted,
      this.lat,
      this.fuelId});

  ExpFuel.fromJson(Map<String, dynamic> json) {
    loginId = json['login_id'];
    merchantNo = json['merchant_no'];
    iD = json['ID'];
    fuelDatetime = json['fuel_datetime'];
    mileage = json['mileage'];
    fuelType = json['fuel_type'];
    priceLiter = json['price_liter'];
    totalAmount = json['total_amount'];
    liter = json['liter'];
    lng = json['lng'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    transtamp = json['transtamp'];
    deleted = json['deleted'];
    lat = json['lat'];
    fuelId = json['fuel_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_id'] = this.loginId;
    data['merchant_no'] = this.merchantNo;
    data['ID'] = this.iD;
    data['fuel_datetime'] = this.fuelDatetime;
    data['mileage'] = this.mileage;
    data['fuel_type'] = this.fuelType;
    data['price_liter'] = this.priceLiter;
    data['total_amount'] = this.totalAmount;
    data['liter'] = this.liter;
    data['lng'] = this.lng;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['transtamp'] = this.transtamp;
    data['deleted'] = this.deleted;
    data['lat'] = this.lat;
    data['fuel_id'] = this.fuelId;
    return data;
  }
}
