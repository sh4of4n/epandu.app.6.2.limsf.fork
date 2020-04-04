class GetMerchantTypeResponse {
  List<MerchantType> merchantType;

  GetMerchantTypeResponse({this.merchantType});

  GetMerchantTypeResponse.fromJson(Map<String, dynamic> json) {
    if (json['MerchantType'] != null) {
      merchantType = new List<MerchantType>();
      json['MerchantType'].forEach((v) {
        merchantType.add(new MerchantType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.merchantType != null) {
      data['MerchantType'] = this.merchantType.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MerchantType {
  String iD;
  String merchantType;
  String merchantTypeDesc;
  String merchantTypeIconFilename;
  String merchantTypeBannerFilename;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String deleted;
  String rowKey;
  String transtamp;

  MerchantType(
      {this.iD,
      this.merchantType,
      this.merchantTypeDesc,
      this.merchantTypeIconFilename,
      this.merchantTypeBannerFilename,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.deleted,
      this.rowKey,
      this.transtamp});

  MerchantType.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantType = json['merchant_type'];
    merchantTypeDesc = json['merchant_type_desc'];
    merchantTypeIconFilename = json['merchant_type_icon_filename'];
    merchantTypeBannerFilename = json['merchant_type_banner_filename'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['merchant_type'] = this.merchantType;
    data['merchant_type_desc'] = this.merchantTypeDesc;
    data['merchant_type_icon_filename'] = this.merchantTypeIconFilename;
    data['merchant_type_banner_filename'] = this.merchantTypeBannerFilename;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['deleted'] = this.deleted;
    data['row_key'] = this.rowKey;
    data['transtamp'] = this.transtamp;
    return data;
  }
}
