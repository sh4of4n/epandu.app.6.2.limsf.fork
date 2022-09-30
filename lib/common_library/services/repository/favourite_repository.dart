import 'dart:convert';

import 'package:epandu/common_library/services/model/favourite_model.dart';
import 'package:epandu/common_library/services/networking.dart';
import 'package:epandu/common_library/services/response.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/utils/app_config.dart';

class FavouriteRepo {
  final localStorage = LocalStorage();
  final appConfig = AppConfig();
  final networking = Networking();

  Future<Response> getFavPlace({
    required String placeId,
    required String type,
    required String name,
    required String description,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwdEncode();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&merchantNo=$merchantNo&loginId=$phone&placeId=$placeId&type=$type&name=$name&description=$description';

    var response = await networking.getData(
      path: 'GetFavPlace?$path',
    );

    if (response.isSuccess && response.data != null) {
      FavPlaceResponse getPackageListByPackageCodeListResponse =
          FavPlaceResponse.fromJson(response.data);
      var responseData = getPackageListByPackageCodeListResponse.favPlace;

      return Response(true, data: responseData);
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> getFavPlacePicture({
    required String placeId,
    required int bgnLimit,
    required int endLimit,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwdEncode();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&merchantNo=$merchantNo&loginId=$phone&placeId=$placeId&bgnLimit=$bgnLimit&endLimit=$endLimit';

    var response = await networking.getData(
      path: 'GetFavPlacePicture?$path',
    );

    if (response.isSuccess && response.data != null) {
      FavPlaceFileAttachResponse getPackageListByPackageCodeListResponse =
          FavPlaceFileAttachResponse.fromJson(response.data);
      var responseData =
          getPackageListByPackageCodeListResponse.favPlaceFileAttach;

      return Response(true, data: responseData);
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> saveFavPlace({
    required String type,
    required String name,
    required String description,
    required double lat,
    required double lng,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    FavPlaceRequest params = FavPlaceRequest(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: caUid,
        caPwd: caPwd,
        merchantNo: merchantNo,
        loginId: phone,
        type: type,
        name: name,
        description: description,
        lat: lat,
        lng: lng);

    String body = jsonEncode(params);
    String api = 'SaveFavPlace';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      FavPlaceResponse acceptOrderResponse =
          FavPlaceResponse.fromJson(response.data);
      var responseData = acceptOrderResponse.favPlace;

      return Response(true, data: responseData);
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> updateFavPlace({
    required String type,
    required String name,
    required String description,
    required double lat,
    required double lng,
    required String placeId,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    FavPlaceRequest params = FavPlaceRequest(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: caUid,
        caPwd: caPwd,
        merchantNo: merchantNo,
        loginId: phone,
        type: type,
        name: name,
        description: description,
        lat: lat,
        lng: lng,
        placeId: placeId);

    String body = jsonEncode(params);
    String api = 'UpdateFavPlace';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      FavPlaceResponse acceptOrderResponse =
          FavPlaceResponse.fromJson(response.data);
      var responseData = acceptOrderResponse.favPlace;

      return Response(true, data: responseData);
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> saveFavPlacePicture({
    required String placeId,
    required String base64Code,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    FavPlaceRequest params = FavPlaceRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      merchantNo: merchantNo,
      loginId: phone,
      placeId: placeId,
      base64Code: base64Code,
    );

    String body = jsonEncode(params);
    String api = 'SaveFavPlacePicture';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      // FavPlaceResponse acceptOrderResponse =
      //     FavPlaceResponse.fromJson(response.data);
      // var responseData = acceptOrderResponse.favPlace;

      return Response(true, data: response.data);
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> deleteFavPlace({
    required String placeId,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    FavPlaceRequest params = FavPlaceRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      merchantNo: merchantNo,
      loginId: phone,
      placeId: placeId,
    );

    String body = jsonEncode(params);
    String api = 'DeleteFavPlace';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      // FavPlaceResponse acceptOrderResponse =
      //     FavPlaceResponse.fromJson(response.data);
      // var responseData = acceptOrderResponse.favPlace;

      return Response(true, data: response.data);
    }

    return Response(false, message: response.message, data: []);
  }

  Future<Response> removeFavPlacePicture({
    required String placeId,
    required String fileKey,
  }) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? phone = await localStorage.getUserPhone();
    String? merchantNo = await localStorage.getMerchantDbCode();

    FavPlaceRequest params = FavPlaceRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      merchantNo: merchantNo,
      loginId: phone,
      placeId: placeId,
      fileKey: fileKey,
    );

    String body = jsonEncode(params);
    String api = 'RemoveFavPlacePicture';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data != null) {
      // FavPlaceResponse acceptOrderResponse =
      //     FavPlaceResponse.fromJson(response.data);
      // var responseData = acceptOrderResponse.favPlace;

      return Response(true, data: response.data);
    }

    return Response(false, message: response.message, data: []);
  }
}
