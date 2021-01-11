import 'dart:convert';
import '../model/sales_order_model.dart';
import '../../../utils/app_config.dart';
import 'package:flutter/material.dart';
import '../../utils/local_storage.dart';
import 'package:intl/intl.dart';

import '../response.dart';
import '../networking.dart';

class SalesOrderRepo {
  final networking = Networking();
  final localStorage = LocalStorage();
  final appConfig = AppConfig();
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  Future<Response> getActiveSlsTrnByDb({context, dbcode, isCart}) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwdEncode = '123456';

    String path =
        'wsCodeCrypt=TBSERPWS&caUid=$caUid&caPwd=$caPwdEncode&dbcode=$dbcode&isCart=$isCart';

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .getData(
      path: 'GetActiveSlsTrnByDb?$path',
    );

    if (response.isSuccess &&
        response.data != null &&
        response.data != 'null') {
      GetActiveSlsTrnByDbResponse getActiveSlsTrnByDbResponse =
          GetActiveSlsTrnByDbResponse.fromJson(response.data);
      return Response(true, data: getActiveSlsTrnByDbResponse.salesOrderHeader);
    }
    return Response(false,
        message: response.message == null || response.message.isEmpty
            ? 'Your cart is empty.'
            : response.message);
  }

  Future<Response> getBackOrderList({context, dbcode}) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwdEncode = '123456';
    final String userId = 'supervisor';

    String path =
        'wsCodeCrypt=TBSERPWS&caUid=$caUid&caPwd=$caPwdEncode&userId=$userId&dbcode=$dbcode';

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .getData(
      path: 'GetBackOrderList?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetBackOrderListResponse getBackOrderListResponse =
          GetBackOrderListResponse.fromJson(response.data);

      return Response(true, data: getBackOrderListResponse.salesOrderDetail);
    }
    return Response(false,
        message:
            response.message.isEmpty ? 'No records found.' : response.message);
  }

  Future<Response> getSlsTrnByDateAndDb({
    @required context,
    @required dbcode,
    @required bgnSODateString,
    @required endSODateString,
    @required startIndex,
    @required noOfRecords,
    @required isAscending,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwdEncode = '123456';
    final String userId = 'supervisor';

    String path =
        'wsCodeCrypt=TBSERPWS&caUid=$caUid&caPwd=$caPwdEncode&userId=$userId&bgnSODateString=$bgnSODateString&endSODateString=$endSODateString&dbcode=$dbcode&startIndex=$startIndex&noOfRecords=$noOfRecords&isAscending=$isAscending';

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .getData(
      path: 'GetSlsTrnByDateAndDbByPaging?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetSlsTrnByDateAndDbResponse getSlsTrnByDateAndDbResponse =
          GetSlsTrnByDateAndDbResponse.fromJson(response.data);

      return Response(true,
          data: getSlsTrnByDateAndDbResponse.salesOrderHeader);
    }
    return Response(false,
        message:
            response.message.isEmpty ? 'No records found.' : response.message);
  }

  Future<Response> getSlsDetailByDocNo({context, docDoc, docRef}) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwdEncode = '123456';

    String path =
        'wsCodeCrypt=TBSERPWS&caUid=$caUid&caPwd=$caPwdEncode&docDoc=$docDoc&docRef=$docRef';

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .getData(
      path: 'GetSlsDetailByDocNo?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetSlsDetailByDocNoResponse getSlsDetailByDocNoResponse =
          GetSlsDetailByDocNoResponse.fromJson(response.data);

      return Response(true, data: getSlsDetailByDocNoResponse.salesOrderDetail);
    }
    return Response(false,
        message:
            response.message.isEmpty ? 'No records found.' : response.message);
  }

  Future<Response> saveActiveSlsDtlByDb({
    context,
    dbcode,
    stkCode,
    stkDesc1,
    stkDesc2,
    batchNo,
    itemQty,
    itemUom,
    itemPrice,
    discAmt,
    discRate,
    isOfferItem,
    @required String scheduleDeliveryDateString,
    key,
    isCart,
    signatureImage,
    signatureImageBase64String,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwd = '123456';

    SaveActiveSlsDtlByDbRequest params = SaveActiveSlsDtlByDbRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      userId: 'SUPERVISOR',
      dbcode: dbcode,
      locCode: '',
      stkCode: stkCode,
      stkDesc1: stkDesc1,
      stkDesc2: stkDesc2,
      batchNo: batchNo,
      itemQty: itemQty,
      itemUom: itemUom,
      itemPrice: itemPrice,
      discAmt: discAmt,
      discRate: discRate,
      isOfferItem: isOfferItem,
      scheduleDeliveryDateString: scheduleDeliveryDateString,
      key: key,
      isCart: isCart,
      signatureImage: signatureImage,
      signatureImageBase64String: signatureImageBase64String ?? '',
    );

    String body = jsonEncode(params);
    String api = 'SaveActiveSlsDtlByDbWithSignature';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .postData(api: api, body: body, headers: headers);

    if (response.isSuccess &&
        response.data != null &&
        response.data['SaveActiveSlsDtlByDbWithSignatureResult'] == true) {
      return Response(true);
    }
    return Response(false,
        message: response.message.isEmpty
            ? 'Failed to save active sales detail. Please try again later.'
            : response.message);
  }

  Future<Response> updateSalesOrderScheduleDeliveryDate({
    context,
    docDoc,
    docRef,
    key,
    scheduleDeliveryDateString,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwd = '123456';
    final String userId = 'supervisor';

    UpdateSalesOrderScheduleDeliveryDateRequest params =
        UpdateSalesOrderScheduleDeliveryDateRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      userId: userId,
      docDoc: docDoc,
      docRef: docRef,
      key: key,
      scheduleDeliveryDateString: scheduleDeliveryDateString,
    );

    String body = jsonEncode(params);
    String api = 'UpdateSalesOrderScheduleDeliveryDate';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .postData(api: api, body: body, headers: headers);

    if (response.isSuccess &&
        response.data != null &&
        response.data['UpdateSalesOrderScheduleDeliveryDateResult'] == true) {
      return Response(true);
    }
    return Response(false,
        message: response.message.isEmpty
            ? 'Failed to set schedule. Please try again later.'
            : response.message);
  }

  Future<Response> deleteSlsDtlByDocRefKey({
    context,
    docDoc,
    docRef,
    key,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwd = '123456';
    final String userId = 'supervisor';

    DeleteSlsDtlByDocRefKeyRequest params = DeleteSlsDtlByDocRefKeyRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      userId: userId,
      docDoc: docDoc,
      docRef: docRef,
      key: key,
    );

    String body = jsonEncode(params);
    String api = 'DeleteSlsDtlByDocRefKey';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .postData(api: api, body: body, headers: headers);

    if (response.isSuccess &&
        response.data != null &&
        response.data['DeleteSlsDtlByDocRefKeyResult'] == true) {
      return Response(true);
    }
    return Response(false,
        message: response.message.isEmpty
            ? 'Failed to delete sales detail. Please try again.'
            : response.message);
  }

  Future<Response> saveCartToSalesOrder({
    context,
    docDoc,
    docRef,
    signatureImage,
    signatureImageBase64String,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwd = '123456';

    SaveCartToSalesOrderRequest params = SaveCartToSalesOrderRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      userId: 'SUPERVISOR',
      docDoc: docDoc,
      docRef: docRef,
      signatureImage: signatureImage,
      signatureImageBase64String: signatureImageBase64String,
    );

    String body = jsonEncode(params);
    String api = 'SaveCartToSalesOrderWithSignature';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .postData(api: api, body: body, headers: headers);

    /* if (response.isSuccess &&
        response.data != null &&
        response.data['SaveCartToSalesOrderWithSignatureResult'] == true) {
      return Response(true);
    } */
    if (response.isSuccess) {
      SaveCartToSalesOrderResponse saveCartToSalesOrderResponse =
          SaveCartToSalesOrderResponse.fromJson(jsonDecode(
              response.data['SaveCartToSalesOrderWithSignatureResult']));

      return Response(true, data: saveCartToSalesOrderResponse.salesOrderTrn);
    }
    return Response(false,
        message: response.message.isEmpty
            ? 'Checkout failed. Please try again.'
            : response.message);
  }

  Future<Response> getSalesOrderPdf({
    context,
    docDoc,
    docRef,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwd = '123456';
    final String userId = 'supervisor';

    String path =
        'wsCodeCrypt=TBSERPWS&caUid=$caUid&caPwd=$caPwd&userId=$userId&docDoc=$docDoc&docRef=$docRef';

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .getData(
      path: 'GetSalesOrderPDF?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetSalesOrderPDFResponse getSalesOrderPDFResponse =
          GetSalesOrderPDFResponse.fromJson(response.data);

      return Response(true, data: getSalesOrderPDFResponse.pDF[0].fileName);
    }
    return Response(false,
        message: response.message.isEmpty
            ? 'Failed to load pdf. Please try again later.'
            : response.message);
  }

  Future<Response> getCustomerCreditLimit({
    @required context,
    @required dbcode,
    @required currency,
    @required tlNettOrdAmt,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwdEncode = '123456';

    String path =
        'wsCodeCrypt=TBSERPWS&caUid=$caUid&caPwd=$caPwdEncode&dbcode=$dbcode&currency=$currency&tlNettOrdAmt=$tlNettOrdAmt';

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .getData(
      path: 'GetCustomerCreditLimit?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetCustomerCreditLimitResponse getCustomerCreditLimitResponse =
          GetCustomerCreditLimitResponse.fromJson(response.data);

      return Response(true, data: getCustomerCreditLimitResponse.arCtrl);
    }
    return Response(false,
        message:
            response.message.isEmpty ? 'No records found.' : response.message);
  }

  Future<Response> getPurchaseHistoryForStock({
    @required context,
    @required dbcode,
    @required stkCode,
    @required startIndex,
    @required noOfRecords,
  }) async {
    String caUid = 'tbs_tbserp_devp_1';
    String caPwdEncode = '123456';

    String path =
        'wsCodeCrypt=TBSERPWS&caUid=$caUid&caPwd=$caPwdEncode&dbcode=$dbcode&stkCode=${Uri.encodeComponent(stkCode)}&startIndex=$startIndex&noOfRecords=$noOfRecords';

    var response = await Networking(
            customUrl:
                'https://tbsweb.tbsdns.com/TbsErp.MainService/DEVP/3_8/MainService.svc/webapi')
        .getData(
      path: 'GetPurchaseHistoryForStock?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetPurchaseHistoryForStockResponse getPurchaseHistoryForStockResponse =
          GetPurchaseHistoryForStockResponse.fromJson(response.data);

      return Response(true,
          data: getPurchaseHistoryForStockResponse.salesInvoiceDetail);
    }
    return Response(false,
        message: response.message.isEmpty
            ? 'You have no purchase history.'
            : response.message);
  }

  Future<String> formatInputValue({@required controller}) async {
    final formatter = NumberFormat('#,##0.00');
    List<String> amountList = [];
    String dot = '.';
    String amount = '';

    amountList = List<String>.from(controller.text.split(''));

    amountList.removeWhere((item) => item == dot);

    if (amountList.length > 2) {
      amountList.insert(controller.text.length - 3, dot);
    }
    if (amountList.length == 2) {
      amountList.insert(0, '0');

      amountList.insert(controller.text.length - 2, dot);
    } else if (amountList[0] == '0' && amountList.length > 2) {
      amountList.remove('0');
    }

    amount = amountList.join();
    controller.text =
        formatter.format(double.tryParse(amount.replaceAll(',', '')));

    return controller.text;
  }

  Future<String> formatQty({@required controller}) async {
    List<String> amountList = [];
    String amount = '';

    amountList = List<String>.from(controller.text.split(''));

    if (amountList.length < 1) {
      amountList.insert(0, '0');
    } else if (amountList[0] == '0' && amountList.length > 1) {
      amountList.remove('0');
    }

    amount = amountList.join();
    controller.text = amount;

    return controller.text;
  }
}
