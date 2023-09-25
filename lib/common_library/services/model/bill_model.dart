import 'package:hive/hive.dart';

part 'bill_model.g.dart';

class GetTelcoResponse {
  List<TelcoComm>? telcoComm;

  GetTelcoResponse({this.telcoComm});

  GetTelcoResponse.fromJson(Map<String, dynamic> json) {
    if (json['TelcoComm'] != null) {
      telcoComm = List<TelcoComm>.empty(growable: true);
      json['TelcoComm'].forEach((v) {
        telcoComm!.add(TelcoComm.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (telcoComm != null) {
      data['TelcoComm'] = telcoComm!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 2, adapterName: 'TelcoAdapter')
class TelcoComm {
  @HiveField(0)
  String? iD;
  @HiveField(1)
  String? telcoName;
  @HiveField(2)
  String? telcoImageUri;
  @HiveField(3)
  String? acctNo;
  @HiveField(4)
  String? prepaidAccessMenu;
  @HiveField(5)
  String? sponsorMarkupRate1;
  @HiveField(6)
  String? sponsorMarkupRateUom1;
  @HiveField(7)
  String? sponsorMarkupRate2;
  @HiveField(8)
  String? sponsorMarkupRateUom2;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['telco_name'] = telcoName;
    data['telco_image_uri'] = telcoImageUri;
    data['acct_no'] = acctNo;
    data['prepaid_access_menu'] = prepaidAccessMenu;
    data['sponsor_markup_rate1'] = sponsorMarkupRate1;
    data['sponsor_markup_rate_uom1'] = sponsorMarkupRateUom1;
    data['sponsor_markup_rate2'] = sponsorMarkupRate2;
    data['sponsor_markup_rate_uom2'] = sponsorMarkupRateUom2;
    return data;
  }
}

class GetServiceResponse {
  List<ServiceComm>? serviceComm;

  GetServiceResponse({this.serviceComm});

  GetServiceResponse.fromJson(Map<String, dynamic> json) {
    if (json['ServiceComm'] != null) {
      serviceComm = List<ServiceComm>.empty(growable: true);
      json['ServiceComm'].forEach((v) {
        serviceComm!.add(ServiceComm.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (serviceComm != null) {
      data['ServiceComm'] = serviceComm!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 3, adapterName: 'BillAdapter')
class ServiceComm {
  @HiveField(0)
  String? iD;
  @HiveField(1)
  String? telcoName;
  @HiveField(2)
  String? telcoImageUri;
  @HiveField(3)
  String? acctNo;
  @HiveField(4)
  String? prepaidAccessMenu;
  @HiveField(5)
  String? markupRate;
  @HiveField(6)
  String? markupRateUom;
  @HiveField(7)
  String? sponsorMarkupRate1;
  @HiveField(8)
  String? sponsorMarkupRateUom1;
  @HiveField(9)
  String? sponsorMarkupRate2;
  @HiveField(10)
  String? sponsorMarkupRateUom2;
  @HiveField(11)
  String? memberDiscRate;
  @HiveField(12)
  String? memberDiscRateUom;
  @HiveField(13)
  String? incentiveRate;
  @HiveField(14)
  String? incentiveRateUom;
  @HiveField(15)
  String? servChrg;
  @HiveField(16)
  String? servChrgUom;
  @HiveField(17)
  String? servChrgEntitle;
  @HiveField(18)
  String? servChrgEntitleUom;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['telco_name'] = telcoName;
    data['telco_image_uri'] = telcoImageUri;
    data['acct_no'] = acctNo;
    data['prepaid_access_menu'] = prepaidAccessMenu;
    data['markup_rate'] = markupRate;
    data['markup_rate_uom'] = markupRateUom;
    data['sponsor_markup_rate1'] = sponsorMarkupRate1;
    data['sponsor_markup_rate_uom1'] = sponsorMarkupRateUom1;
    data['sponsor_markup_rate2'] = sponsorMarkupRate2;
    data['sponsor_markup_rate_uom2'] = sponsorMarkupRateUom2;
    data['member_disc_rate'] = memberDiscRate;
    data['member_disc_rate_uom'] = memberDiscRateUom;
    data['incentive_rate'] = incentiveRate;
    data['incentive_rate_uom'] = incentiveRateUom;
    data['serv_chrg'] = servChrg;
    data['serv_chrg_uom'] = servChrgUom;
    data['serv_chrg_entitle'] = servChrgEntitle;
    data['serv_chrg_entitle_uom'] = servChrgEntitleUom;
    return data;
  }
}

class BillArgs {
  String? account;
  String? amount;
  TelcoComm? telcoComm;
  ServiceComm? serviceComm;

  BillArgs({this.account, this.amount, this.telcoComm, this.serviceComm});
}
