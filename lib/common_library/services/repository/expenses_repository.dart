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

  Future<Response> saveExp({
    required String expDatetimeString,
    required String mileage,
    required String type,
    required String description,
    required String amount,
    required double lat,
    required double lng,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    ExpRequest params = ExpRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      merchantNo: merchantNo,
      loginId: phone,
      expDatetimeString: expDatetimeString,
      type: type,
      mileage: mileage,
      description: description,
      amount: amount,
      lat: lat,
      lng: lng,
    );

    String body = jsonEncode(params);
    String api = 'SaveExp';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      ExpResponse acceptOrderResponse = ExpResponse.fromJson(response.data);
      var responseData = acceptOrderResponse.exp;

      return Response(true, data: responseData);
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> getExp({
    required String expId,
    required String type,
    required String expStartDateString,
    required String expEndDateString,
    required int startIndex,
    required int noOfRecords,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwdEncode();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&merchantNo=$merchantNo&loginId=$phone&expId=$expId&type=$type&expStartDateString=$expStartDateString&expEndDateString=$expEndDateString&startIndex=$startIndex&noOfRecords=$noOfRecords';

    var response = await networking.getData(
      path: 'GetExp?$path',
    );

    if (response.isSuccess) {
      if (response.data != null) {
        ExpResponse getPackageListByPackageCodeListResponse =
            ExpResponse.fromJson(response.data);
        var responseData = getPackageListByPackageCodeListResponse.exp;

        return Response(true, data: responseData);
      } else {
        return Response(true, data: []);
      }
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> deleteExp({
    required String expId,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    ExpRequest params = ExpRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      merchantNo: merchantNo,
      loginId: phone,
      expId: expId,
    );

    String body = jsonEncode(params);
    String api = 'DeleteExp';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      return Response(true, data: response.data);
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> updateExp({
    required String expId,
    required String expDatetimeString,
    required String mileage,
    required String type,
    required String description,
    required String amount,
    required double lat,
    required double lng,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    ExpRequest params = ExpRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      merchantNo: merchantNo,
      loginId: phone,
      expDatetimeString: expDatetimeString,
      expId: expId,
      type: type,
      lat: lat,
      description: description,
      lng: lng,
      mileage: mileage,
      amount: amount,
    );

    String body = jsonEncode(params);
    String api = 'UpdateExp';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      ExpResponse acceptOrderResponse = ExpResponse.fromJson(response.data);
      var responseData = acceptOrderResponse.exp;

      return Response(true, data: responseData);
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> saveExpPicture({
    required String expId,
    required String base64Code,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    ExpRequest params = ExpRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      merchantNo: merchantNo,
      loginId: phone,
      expId: expId,
      base64Code: base64Code,
    );

    String body = jsonEncode(params);
    String api = 'SaveExpPicture';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      return Response(true, data: response.data);
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> getExpPicture({
    required String expId,
    required int bgnLimit,
    required int endLimit,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwdEncode();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&merchantNo=$merchantNo&loginId=$phone&expId=$expId&bgnLimit=$bgnLimit&endLimit=$endLimit';

    var response = await networking.getData(
      path: 'GetExpPicture?$path',
    );

    if (response.isSuccess && response.data != null) {
      ExpFileAttachResponse getPackageListByPackageCodeListResponse =
          ExpFileAttachResponse.fromJson(response.data);
      var responseData = getPackageListByPackageCodeListResponse.expFileAttach;

      return Response(true, data: responseData);
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> removeExpPicture({
    required String expId,
    required String fileKey,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    ExpRequest params = ExpRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      merchantNo: merchantNo,
      loginId: phone,
      expId: expId,
      fileKey: fileKey,
    );

    String body = jsonEncode(params);
    String api = 'RemoveExpPicture';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      return Response(true, data: response.data);
    }

    return Response(false, message: response.message, data: []);
  }
}
