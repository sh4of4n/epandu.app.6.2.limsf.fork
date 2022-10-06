import 'dart:convert';

import 'package:epandu/common_library/services/model/expenses_model.dart';
import 'package:epandu/common_library/services/networking.dart';
import 'package:epandu/common_library/services/response.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/utils/app_config.dart';

class ExpensesRepo {
  final localStorage = LocalStorage();
  final appConfig = AppConfig();
  final networking = Networking();

  Future<Response> saveExpFuel({
    required String fuelDatetime,
    required String mileage,
    required String fuelType,
    required String priceLiter,
    required String totalAmount,
    required String liter,
    required double lat,
    required double lng,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    ExpFuelRequest params = ExpFuelRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      merchantNo: merchantNo,
      loginId: phone,
      fuelDatetimeString: fuelDatetime,
      fuelType: fuelType,
      mileage: mileage,
      priceLiter: priceLiter,
      totalAmount: totalAmount,
      liter: liter,
      lat: lat,
      lng: lng,
    );

    String body = jsonEncode(params);
    String api = 'SaveExpFuel';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      ExpFuelResponse acceptOrderResponse =
          ExpFuelResponse.fromJson(response.data);
      var responseData = acceptOrderResponse.expFuel;

      return Response(true, data: responseData);
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> getExpFuel(
      {required String fuelId,
      required String type,
      required String fuelStartDateString,
      required String fuelEndDateString,
      required int startIndex,
      required int noOfRecords}) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwdEncode();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&merchantNo=$merchantNo&loginId=$phone&fuelId=$fuelId&type=$type&fuelStartDateString=$fuelStartDateString&fuelEndDateString=$fuelEndDateString&startIndex=$startIndex&noOfRecords=$noOfRecords';

    var response = await networking.getData(
      path: 'GetExpFuel?$path',
    );

    if (response.isSuccess) {
      if (response.data != null) {
        ExpFuelResponse getPackageListByPackageCodeListResponse =
            ExpFuelResponse.fromJson(response.data);
        var responseData = getPackageListByPackageCodeListResponse.expFuel;

        return Response(true, data: responseData);
      } else {
        return Response(true, data: []);
      }
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> deleteExpFuel({
    required String fuelId,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    ExpFuelRequest params = ExpFuelRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      merchantNo: merchantNo,
      loginId: phone,
      fuelId: fuelId,
    );

    String body = jsonEncode(params);
    String api = 'DeleteExpFuel';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      return Response(true, data: response.data);
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> updateExpFuel({
    required String fuelId,
    required String fuelDatetime,
    required String mileage,
    required String fuelType,
    required String priceLiter,
    required String totalAmount,
    required String liter,
    required double lat,
    required double lng,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    ExpFuelRequest params = ExpFuelRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      merchantNo: merchantNo,
      loginId: phone,
      fuelDatetimeString: fuelDatetime,
      fuelId: fuelId,
      fuelType: fuelType,
      lat: lat,
      liter: liter,
      lng: lng,
      mileage: mileage,
      priceLiter: priceLiter,
      totalAmount: totalAmount,
    );

    String body = jsonEncode(params);
    String api = 'UpdateExpFuel';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      ExpFuelResponse acceptOrderResponse =
          ExpFuelResponse.fromJson(response.data);
      var responseData = acceptOrderResponse.expFuel;

      return Response(true, data: responseData);
    }

    return Response(false, message: response.message, data: []);
  }
}
