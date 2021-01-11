import 'dart:convert';

import '../model/products_model.dart';
import '../../../utils/app_config.dart';
import 'package:flutter/material.dart';
import '../../utils/local_storage.dart';

import '../response.dart';
import '../networking.dart';

class ProductsRepo {
  final networking = Networking();
  // final credentials = Hive.box('credentials');
  final localStorage = LocalStorage();
  final appConfig = AppConfig();
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  Future<Response> getCategory({context, stkCat}) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwdEncode = '123456';

    String path =
        'wsCodeCrypt=TBSERPWS&caUid=$caUid&caPwd=$caPwdEncode&stkCat=${stkCat ?? ''}';

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .getData(
      path: 'GetCategory?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetCategoryResponse getCategoryResponse =
          GetCategoryResponse.fromJson(response.data);

      return Response(true, data: getCategoryResponse.stkCat);
    }

    return Response(false,
        message:
            response.message.isEmpty ? 'No records found.' : response.message);
  }

  Future<Response> getStock({
    context,
    String stkCat,
    String keywordSearch,
    int bgnLimit,
    int endLimit,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwdEncode = '123456';
    // final String username = await credentials.get('username');

    String path =
        'wsCodeCrypt=TBSERPWS&caUid=$caUid&caPwd=$caPwdEncode&userId=SUPERVISOR&dbcode=&stkCode=&uom=&stkCat=${stkCat ?? ''}&stkGrp=&nonActive=false&publish=true&specType=0&spcDateTimeString=&keywordSearch=${keywordSearch ?? ''}&prevStkCode=&bgnLimit=$bgnLimit&endLimit=$endLimit&includeDeleted=false&lastDownloadDateTimeString=';

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi',
            milliseconds: 50000)
        .getData(
      path: 'GetStock?$path',
    );

    if (response.isSuccess &&
        response.data != null &&
        response.data != 'null') {
      GetStockResponse getStockResponse =
          GetStockResponse.fromJson(jsonDecode(response.data));

      return Response(true, data: getStockResponse.stkmst);
    }
    return Response(false,
        message: response.message == null || response.message.isEmpty
            ? 'No records found.'
            : response.message);
  }

  Future<Response> getUomByPaging({
    context,
    uom,
    publish,
    isVerify,
    startIndex,
    noOfRecords,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwdEncode = '123456';

    String path = 'wsCodeCrypt=TBSERPWS' +
        '&caUid=$caUid' +
        '&caPwd=$caPwdEncode' +
        '&uom=${uom ?? ''}' +
        '&publish=$publish' +
        '&isVerify=$isVerify' +
        '&startIndex=$startIndex' +
        '&noOfRecords=$noOfRecords';

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .getData(
      path: 'GetUOMByPaging?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetUOMByPagingResponse getUOMByPagingResponse =
          GetUOMByPagingResponse.fromJson(response.data);

      return Response(true, data: getUOMByPagingResponse.uOM);
    }
    return Response(false,
        message:
            response.message.isEmpty ? 'No records found.' : response.message);
  }

  Future<Response> getCategoryByPaging({
    context,
    stkCat,
    publish,
    isVerify,
    startIndex,
    noOfRecords,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwdEncode = '123456';

    String path = 'wsCodeCrypt=TBSERPWS' +
        '&caUid=$caUid' +
        '&caPwd=$caPwdEncode' +
        '&stkCat=${stkCat ?? ''}' +
        '&publish=$publish' +
        '&isVerify=$isVerify' +
        '&startIndex=$startIndex' +
        '&noOfRecords=$noOfRecords';

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .getData(
      path: 'GetCategoryByPaging?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetCategoryByPagingResponse getCategoryByPagingResponse =
          GetCategoryByPagingResponse.fromJson(response.data);

      return Response(true, data: getCategoryByPagingResponse.stkCat);
    }
    return Response(false,
        message:
            response.message.isEmpty ? 'No records found.' : response.message);
  }

  Future<Response> getGroupByPaging({
    context,
    stkGrp,
    publish,
    isVerify,
    startIndex,
    noOfRecords,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwdEncode = '123456';

    String path = 'wsCodeCrypt=TBSERPWS' +
        '&caUid=$caUid' +
        '&caPwd=$caPwdEncode' +
        '&stkCat=${stkGrp ?? ''}' +
        '&publish=$publish' +
        '&isVerify=$isVerify' +
        '&startIndex=$startIndex' +
        '&noOfRecords=$noOfRecords';

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .getData(
      path: 'GetGroupByPaging?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetGroupByPagingResponse getGroupByPagingResponse =
          GetGroupByPagingResponse.fromJson(response.data);

      return Response(true, data: getGroupByPagingResponse.stkGrp);
    }
    return Response(false,
        message:
            response.message.isEmpty ? 'No records found.' : response.message);
  }

  Future<Response> saveStock({
    @required context,
    @required stkCode,
    @required stkDesc1,
    @required uom,
    @required stkCat,
    @required stkGrp,
    @required publish,
    @required useBatch,
    @required snControl,
    @required stkPicture,
    @required stkPictureBase64String,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwd = '123456';
    final String userId = 'supervisor';

    SaveStockRequest params = SaveStockRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      userId: userId,
      stkCode: stkCode,
      stkDesc1: stkDesc1,
      uom: uom,
      stkCat: stkCat,
      stkGrp: stkGrp,
      publish: publish,
      useBatch: useBatch,
      snControl: snControl,
      stkPicture: stkPicture,
      stkPictureBase64String: stkPictureBase64String ?? '',
    );

    String body = jsonEncode(params);
    String api = 'SaveStock';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess &&
        response.data != null &&
        response.data['SaveStockResult'] == true) {
      return Response(true);
    }
    return Response(false,
        message: response.message.isEmpty
            ? 'Failed to save stock. Please try again later.'
            : response.message);
  }

  Future<Response> updateStock({
    @required context,
    @required stkCode,
    @required stkDesc1,
    @required uom,
    @required stkCat,
    @required stkGrp,
    @required publish,
    @required useBatch,
    @required snControl,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwd = '123456';
    final String userId = 'supervisor';

    UpdateStockRequest params = UpdateStockRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      userId: userId,
      stkCode: stkCode,
      stkDesc1: stkDesc1,
      uom: uom,
      stkCat: stkCat,
      stkGrp: stkGrp,
      publish: publish,
      useBatch: useBatch,
      snControl: snControl,
    );

    String body = jsonEncode(params);
    String api = 'UpdateStock';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess &&
        response.data != null &&
        response.data['UpdateStockResult'] == true) {
      return Response(true);
    }
    return Response(false,
        message: response.message.isEmpty
            ? 'Failed to edit stock. Please try again later.'
            : response.message);
  }

  Future<Response> getStockPictureList({
    @required context,
    @required stkCode,
    @required startIndex,
    @required noOfRecords,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwdEncode = '123456';

    String path = 'wsCodeCrypt=TBSERPWS' +
        '&caUid=$caUid' +
        '&caPwd=$caPwdEncode' +
        '&stkCode=${Uri.encodeComponent(stkCode) ?? ''}' +
        '&startIndex=$startIndex' +
        '&noOfRecords=$noOfRecords';

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .getData(
      path: 'GetStockPictureList?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetStockPictureListResponse getStockPictureListResponse =
          GetStockPictureListResponse.fromJson(response.data);

      return Response(true, data: getStockPictureListResponse.stkmstFileAttach);
    }
    return Response(false,
        message: response.message.isEmpty
            ? 'There are no images.'
            : response.message);
  }
}
