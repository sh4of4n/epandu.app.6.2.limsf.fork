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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['merchantNo'] = merchantNo;
    data['loginId'] = loginId;
    data['expDatetimeString'] = expDatetimeString;
    data['mileage'] = mileage;
    data['type'] = type;
    data['description'] = description;
    data['amount'] = amount;
    data['lat'] = lat;
    data['lng'] = lng;
    data['expId'] = expId;
    data['base64Code'] = base64Code;
    data['fileKey'] = fileKey;
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
        exp!.add(Exp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (exp != null) {
      data['Exp'] = exp!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['exp_id'] = expId;
    data['merchant_no'] = merchantNo;
    data['login_id'] = loginId;
    data['exp_datetime'] = expDatetime;
    data['mileage'] = mileage;
    data['type'] = type;
    data['description'] = description;
    data['amount'] = amount;
    data['lat'] = lat;
    data['lng'] = lng;
    data['create_user'] = createUser;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['deleted'] = deleted;
    data['row_key'] = rowKey;
    data['create_date'] = createDate;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login_id'] = loginId;
    data['merchant_no'] = merchantNo;
    data['ID'] = iD;
    data['fuel_datetime'] = fuelDatetime;
    data['mileage'] = mileage;
    data['fuel_type'] = fuelType;
    data['price_liter'] = priceLiter;
    data['total_amount'] = totalAmount;
    data['liter'] = liter;
    data['lng'] = lng;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['transtamp'] = transtamp;
    data['deleted'] = deleted;
    data['lat'] = lat;
    data['fuel_id'] = fuelId;
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
        expFileAttach!.add(ExpFileAttach.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (expFileAttach != null) {
      data['ExpFileAttach'] = expFileAttach!.map((v) => v.toJson()).toList();
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
  String? cancelDate;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['exp_id'] = expId;
    data['key'] = key;
    data['item_no'] = itemNo;
    data['file_name'] = fileName;
    data['cancel'] = cancel;
    data['cancel_date'] = cancelDate;
    data['deleted'] = deleted;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['row_key'] = rowKey;
    data['transtamp'] = transtamp;
    data['attach_type'] = attachType;
    data['attached_size'] = attachedSize;
    data['picture_path'] = picturePath;
    return data;
  }
}
