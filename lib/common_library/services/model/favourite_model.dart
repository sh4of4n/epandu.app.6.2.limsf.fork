class FavPlaceResponse {
  List<FavPlace>? favPlace;

  FavPlaceResponse({this.favPlace});

  FavPlaceResponse.fromJson(Map<String, dynamic> json) {
    if (json['FavPlace'] != null) {
      favPlace = <FavPlace>[];
      json['FavPlace'].forEach((v) {
        favPlace!.add(FavPlace.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (favPlace != null) {
      data['FavPlace'] = favPlace!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavPlace {
  String? iD;
  String? merchantNo;
  String? placeId;
  String? loginId;
  String? type;
  String? name;
  String? description;
  String? lat;
  String? lng;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? transtamp;
  String? deleted;

  FavPlace(
      {this.iD,
      this.merchantNo,
      this.placeId,
      this.loginId,
      this.type,
      this.name,
      this.description,
      this.lat,
      this.lng,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.transtamp,
      this.deleted});

  FavPlace.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantNo = json['merchant_no'];
    placeId = json['place_id'];
    loginId = json['login_id'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    lat = json['lat'];
    lng = json['lng'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    transtamp = json['transtamp'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['merchant_no'] = merchantNo;
    data['place_id'] = placeId;
    data['login_id'] = loginId;
    data['type'] = type;
    data['name'] = name;
    data['description'] = description;
    data['lat'] = lat;
    data['lng'] = lng;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['transtamp'] = transtamp;
    data['deleted'] = deleted;
    return data;
  }
}

class FavPlaceRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? merchantNo;
  String? loginId;
  String? type;
  String? name;
  String? description;
  double? lat;
  double? lng;
  String? placeId;
  String? base64Code;
  String? fileKey;

  FavPlaceRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.merchantNo,
      this.loginId,
      this.type,
      this.name,
      this.description,
      this.lat,
      this.lng,
      this.placeId,
      this.base64Code,
      this.fileKey});

  FavPlaceRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    merchantNo = json['merchantNo'];
    loginId = json['loginId'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    lat = json['lat'];
    lng = json['lng'];
    base64Code = json['base64Code'];
    placeId = json['placeId'];
    fileKey = json['fileKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['merchantNo'] = merchantNo;
    data['loginId'] = loginId;
    data['type'] = type;
    data['name'] = name;
    data['description'] = description;
    data['lat'] = lat;
    data['lng'] = lng;
    data['base64Code'] = base64Code;
    data['placeId'] = placeId;
    data['fileKey'] = fileKey;
    return data;
  }
}

class FavPlaceFileAttachResponse {
  List<FavPlaceFileAttach>? favPlaceFileAttach;

  FavPlaceFileAttachResponse({this.favPlaceFileAttach});

  FavPlaceFileAttachResponse.fromJson(Map<String, dynamic> json) {
    if (json['FavPlaceFileAttach'] != null) {
      favPlaceFileAttach = <FavPlaceFileAttach>[];
      json['FavPlaceFileAttach'].forEach((v) {
        favPlaceFileAttach!.add(FavPlaceFileAttach.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (favPlaceFileAttach != null) {
      data['FavPlaceFileAttach'] =
          favPlaceFileAttach!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavPlaceFileAttach {
  String? iD;
  String? placeId;
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

  FavPlaceFileAttach(
      {this.iD,
      this.placeId,
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

  FavPlaceFileAttach.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    placeId = json['place_id'];
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
    data['place_id'] = placeId;
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
