class ExpRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? merchantNo;
  String? loginId;
  String? expDatetimeString;
  String? mileage;
  String? type;
  String? description;
  String? amount;
  double? lat;
  double? lng;
  String? expId;
  String? base64Code;
  String? fileKey;

  ExpRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.merchantNo,
      this.loginId,
      this.expDatetimeString,
      this.mileage,
      this.type,
      this.description,
      this.amount,
      this.lat,
      this.lng,
      this.expId,
      this.base64Code,
      this.fileKey});

  ExpRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    merchantNo = json['merchantNo'];
    loginId = json['loginId'];
    expDatetimeString = json['expDatetimeString'];
    mileage = json['mileage'];
    type = json['type'];
    description = json['description'];
    amount = json['amount'];
    lat = json['lat'];
    lng = json['lng'];
    expId = json['expId'];
    base64Code = json['base64Code'];
    fileKey = json['fileKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['merchantNo'] = this.merchantNo;
    data['loginId'] = this.loginId;
    data['expDatetimeString'] = this.expDatetimeString;
    data['mileage'] = this.mileage;
    data['type'] = this.type;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['expId'] = this.expId;
    data['base64Code'] = this.base64Code;
    data['fileKey'] = this.fileKey;
    return data;
  }
}

class ExpResponse {
  List<Exp>? exp;

  ExpResponse({this.exp});

  ExpResponse.fromJson(Map<String, dynamic> json) {
    if (json['Exp'] != null) {
      exp = <Exp>[];
      json['Exp'].forEach((v) {
        exp!.add(new Exp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exp != null) {
      data['Exp'] = this.exp!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exp {
  String? iD;
  String? expId;
  String? merchantNo;
  String? loginId;
  String? expDatetime;
  String? mileage;
  String? type;
  String? description;
  String? amount;
  String? lat;
  String? lng;
  String? createUser;
  String? editUser;
  String? editDate;
  String? deleted;
  String? rowKey;
  String? createDate;

  Exp(
      {this.iD,
      this.expId,
      this.merchantNo,
      this.loginId,
      this.expDatetime,
      this.mileage,
      this.type,
      this.description,
      this.amount,
      this.lat,
      this.lng,
      this.createUser,
      this.editUser,
      this.editDate,
      this.deleted,
      this.rowKey,
      this.createDate});

  Exp.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    expId = json['exp_id'];
    merchantNo = json['merchant_no'];
    loginId = json['login_id'];
    expDatetime = json['exp_datetime'];
    mileage = json['mileage'];
    type = json['type'];
    description = json['description'];
    amount = json['amount'];
    lat = json['lat'];
    lng = json['lng'];
    createUser = json['create_user'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    rowKey = json['row_key'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['exp_id'] = this.expId;
    data['merchant_no'] = this.merchantNo;
    data['login_id'] = this.loginId;
    data['exp_datetime'] = this.expDatetime;
    data['mileage'] = this.mileage;
    data['type'] = this.type;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['create_user'] = this.createUser;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['deleted'] = this.deleted;
    data['row_key'] = this.rowKey;
    data['create_date'] = this.createDate;
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

class ExpFileAttachResponse {
  List<ExpFileAttach>? expFileAttach;

  ExpFileAttachResponse({this.expFileAttach});

  ExpFileAttachResponse.fromJson(Map<String, dynamic> json) {
    if (json['ExpFileAttach'] != null) {
      expFileAttach = <ExpFileAttach>[];
      json['ExpFileAttach'].forEach((v) {
        expFileAttach!.add(new ExpFileAttach.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.expFileAttach != null) {
      data['ExpFileAttach'] =
          this.expFileAttach!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpFileAttach {
  String? iD;
  String? expId;
  String? key;
  String? itemNo;
  String? fileName;
  String? cancel;
  Null? cancelDate;
  String? deleted;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? rowKey;
  String? transtamp;
  String? attachType;
  String? attachedSize;
  String? picturePath;

  ExpFileAttach(
      {this.iD,
      this.expId,
      this.key,
      this.itemNo,
      this.fileName,
      this.cancel,
      this.cancelDate,
      this.deleted,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.rowKey,
      this.transtamp,
      this.attachType,
      this.attachedSize,
      this.picturePath});

  ExpFileAttach.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    expId = json['exp_id'];
    key = json['key'];
    itemNo = json['item_no'];
    fileName = json['file_name'];
    cancel = json['cancel'];
    cancelDate = json['cancel_date'];
    deleted = json['deleted'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
    attachType = json['attach_type'];
    attachedSize = json['attached_size'];
    picturePath = json['picture_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['exp_id'] = this.expId;
    data['key'] = this.key;
    data['item_no'] = this.itemNo;
    data['file_name'] = this.fileName;
    data['cancel'] = this.cancel;
    data['cancel_date'] = this.cancelDate;
    data['deleted'] = this.deleted;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['row_key'] = this.rowKey;
    data['transtamp'] = this.transtamp;
    data['attach_type'] = this.attachType;
    data['attached_size'] = this.attachedSize;
    data['picture_path'] = this.picturePath;
    return data;
  }
}
