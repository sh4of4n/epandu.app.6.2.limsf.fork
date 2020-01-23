import 'package:hive/hive.dart';

part 'bill_model.g.dart';

class GetTelcoResponse {
  List<TelcoComm> telcoComm;

  GetTelcoResponse({this.telcoComm});

  GetTelcoResponse.fromJson(Map<String, dynamic> json) {
    if (json['TelcoComm'] != null) {
      telcoComm = new List<TelcoComm>();
      json['TelcoComm'].forEach((v) {
        telcoComm.add(new TelcoComm.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.telcoComm != null) {
      data['TelcoComm'] = this.telcoComm.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 2, adapterName: 'TelcoAdapter')
class TelcoComm {
  @HiveField(0)
  String iD;
  @HiveField(1)
  String telcoName;
  @HiveField(2)
  String telcoImageUri;
  @HiveField(3)
  String acctNo;
  @HiveField(4)
  String prepaidAccessMenu;
  @HiveField(5)
  String sponsorMarkupRate1;
  @HiveField(6)
  String sponsorMarkupRateUom1;
  @HiveField(7)
  String sponsorMarkupRate2;
  @HiveField(8)
  String sponsorMarkupRateUom2;

  TelcoComm(
      {this.iD,
      this.telcoName,
      this.telcoImageUri,
      this.acctNo,
      this.prepaidAccessMenu,
      this.sponsorMarkupRate1,
      this.sponsorMarkupRateUom1,
      this.sponsorMarkupRate2,
      this.sponsorMarkupRateUom2});

  TelcoComm.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    telcoName = json['telco_name'];
    telcoImageUri = json['telco_image_uri'];
    acctNo = json['acct_no'];
    prepaidAccessMenu = json['prepaid_access_menu'];
    sponsorMarkupRate1 = json['sponsor_markup_rate1'];
    sponsorMarkupRateUom1 = json['sponsor_markup_rate_uom1'];
    sponsorMarkupRate2 = json['sponsor_markup_rate2'];
    sponsorMarkupRateUom2 = json['sponsor_markup_rate_uom2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['telco_name'] = this.telcoName;
    data['telco_image_uri'] = this.telcoImageUri;
    data['acct_no'] = this.acctNo;
    data['prepaid_access_menu'] = this.prepaidAccessMenu;
    data['sponsor_markup_rate1'] = this.sponsorMarkupRate1;
    data['sponsor_markup_rate_uom1'] = this.sponsorMarkupRateUom1;
    data['sponsor_markup_rate2'] = this.sponsorMarkupRate2;
    data['sponsor_markup_rate_uom2'] = this.sponsorMarkupRateUom2;
    return data;
  }
}

class GetServiceResponse {
  List<ServiceComm> serviceComm;

  GetServiceResponse({this.serviceComm});

  GetServiceResponse.fromJson(Map<String, dynamic> json) {
    if (json['ServiceComm'] != null) {
      serviceComm = new List<ServiceComm>();
      json['ServiceComm'].forEach((v) {
        serviceComm.add(new ServiceComm.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceComm != null) {
      data['ServiceComm'] = this.serviceComm.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 3, adapterName: 'BillAdapter')
class ServiceComm {
  @HiveField(0)
  String iD;
  @HiveField(1)
  String telcoName;
  @HiveField(2)
  String telcoImageUri;
  @HiveField(3)
  String acctNo;
  @HiveField(4)
  String prepaidAccessMenu;
  @HiveField(5)
  String markupRate;
  @HiveField(6)
  String markupRateUom;
  @HiveField(7)
  String sponsorMarkupRate1;
  @HiveField(8)
  String sponsorMarkupRateUom1;
  @HiveField(9)
  String sponsorMarkupRate2;
  @HiveField(10)
  String sponsorMarkupRateUom2;
  @HiveField(11)
  String memberDiscRate;
  @HiveField(12)
  String memberDiscRateUom;
  @HiveField(13)
  String incentiveRate;
  @HiveField(14)
  String incentiveRateUom;
  @HiveField(15)
  String servChrg;
  @HiveField(16)
  String servChrgUom;
  @HiveField(17)
  String servChrgEntitle;
  @HiveField(18)
  String servChrgEntitleUom;

  ServiceComm(
      {this.iD,
      this.telcoName,
      this.telcoImageUri,
      this.acctNo,
      this.prepaidAccessMenu,
      this.markupRate,
      this.markupRateUom,
      this.sponsorMarkupRate1,
      this.sponsorMarkupRateUom1,
      this.sponsorMarkupRate2,
      this.sponsorMarkupRateUom2,
      this.memberDiscRate,
      this.memberDiscRateUom,
      this.incentiveRate,
      this.incentiveRateUom,
      this.servChrg,
      this.servChrgUom,
      this.servChrgEntitle,
      this.servChrgEntitleUom});

  ServiceComm.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    telcoName = json['telco_name'];
    telcoImageUri = json['telco_image_uri'];
    acctNo = json['acct_no'];
    prepaidAccessMenu = json['prepaid_access_menu'];
    markupRate = json['markup_rate'];
    markupRateUom = json['markup_rate_uom'];
    sponsorMarkupRate1 = json['sponsor_markup_rate1'];
    sponsorMarkupRateUom1 = json['sponsor_markup_rate_uom1'];
    sponsorMarkupRate2 = json['sponsor_markup_rate2'];
    sponsorMarkupRateUom2 = json['sponsor_markup_rate_uom2'];
    memberDiscRate = json['member_disc_rate'];
    memberDiscRateUom = json['member_disc_rate_uom'];
    incentiveRate = json['incentive_rate'];
    incentiveRateUom = json['incentive_rate_uom'];
    servChrg = json['serv_chrg'];
    servChrgUom = json['serv_chrg_uom'];
    servChrgEntitle = json['serv_chrg_entitle'];
    servChrgEntitleUom = json['serv_chrg_entitle_uom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['telco_name'] = this.telcoName;
    data['telco_image_uri'] = this.telcoImageUri;
    data['acct_no'] = this.acctNo;
    data['prepaid_access_menu'] = this.prepaidAccessMenu;
    data['markup_rate'] = this.markupRate;
    data['markup_rate_uom'] = this.markupRateUom;
    data['sponsor_markup_rate1'] = this.sponsorMarkupRate1;
    data['sponsor_markup_rate_uom1'] = this.sponsorMarkupRateUom1;
    data['sponsor_markup_rate2'] = this.sponsorMarkupRate2;
    data['sponsor_markup_rate_uom2'] = this.sponsorMarkupRateUom2;
    data['member_disc_rate'] = this.memberDiscRate;
    data['member_disc_rate_uom'] = this.memberDiscRateUom;
    data['incentive_rate'] = this.incentiveRate;
    data['incentive_rate_uom'] = this.incentiveRateUom;
    data['serv_chrg'] = this.servChrg;
    data['serv_chrg_uom'] = this.servChrgUom;
    data['serv_chrg_entitle'] = this.servChrgEntitle;
    data['serv_chrg_entitle_uom'] = this.servChrgEntitleUom;
    return data;
  }
}

class BillArgs {
  String phone;
  String amount;
  TelcoComm telcoComm;
  ServiceComm serviceComm;

  BillArgs({this.phone, this.amount, this.telcoComm, this.serviceComm});
}
