import 'dart:async';
import 'dart:convert';

import 'package:epandu/services/api/model/fpx_model.dart';
import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';

import '../../app_localizations.dart';

class FpxRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final xml2json = Xml2Json();
  final networking = Networking();

  Future<Response> createOrder({
    @required context,
    @required diCode,
    @required icNo,
    @required packageCode,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getMerchantDbCode();

    CreateOrderRequest createOrderRequest = CreateOrderRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      userId: userId,
      icNo: icNo,
      packageCode: packageCode,
    );

    String body = jsonEncode(createOrderRequest);
    String api = 'CreateOrder';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess &&
        response.data != null &&
        response.data != 'null') {
      CreateOrderResponse createOrderResponse =
          CreateOrderResponse.fromJson(response.data);
      var responseData = createOrderResponse.slsTrn;

      return Response(true, data: responseData);
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('create_order_fail'));
  }

  Future<Response> getOrderListByIcNo({
    @required context,
    @required icNo,
    @required startIndex,
    @required noOfRecords,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getMerchantDbCode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&userId=$userId&icNo=$icNo&startIndex=$startIndex&noOfRecords=$noOfRecords';

    var response = await networking.getData(
      path: 'GetOrderListByIcNo?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetOrderListByIcNoResponse getOrderListByIcNoResponse =
          GetOrderListByIcNoResponse.fromJson(response.data);
      var responseData = getOrderListByIcNoResponse.slsTrn;

      return Response(true, data: responseData);
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('create_order_fail'));
  }

  Future<Response> fpxSendB2CBankEnquiry({
    @required context,
    callbackUrl,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd';

    var response = await networking.getData(
      path: 'FPX_SendB2CBankEnquiry?$path',
    );

    if (response.isSuccess && response.data != null) {
      FpxSendB2CBankEnquiryResponse fpxSendB2CBankEnquiryResponse =
          FpxSendB2CBankEnquiryResponse.fromJson(response.data);
      var responseData = fpxSendB2CBankEnquiryResponse.response;

      return Response(true, data: responseData);
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('get_package_fail'));
  }

  Future<Response> fpxSendB2CAuthRequest({
    @required context,
    @required docDoc,
    @required docRef,
    @required bankId,
    @required icNo,
    callbackUrl,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getMerchantDbCode();

    String path = 'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd' +
        '&diCode=$diCode&userId=$userId&icNo=$icNo&docDoc=$docDoc&docRef=$docRef&bankId=$bankId&callbackUrl=${callbackUrl ?? ''}';

    var response = await networking.getData(
      path: 'FPX_SendB2CAuthRequest?$path',
    );

    if (response.isSuccess && response.data != null) {
      FpxSendB2CAuthResponse fpxSendB2CAuthResponse =
          FpxSendB2CAuthResponse.fromJson(response.data);
      var responseData = fpxSendB2CAuthResponse.response;

      return Response(true, data: responseData);
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('get_package_fail'));
  }

  Future<Response> getOnlinePaymentListByIcNo({
    @required context,
    @required icNo,
    @required startIndex,
    @required noOfRecords,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String userId = await localStorage.getUserId();

    String path = 'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd' +
        '&userId=$userId&icNo=$icNo&startIndex=$startIndex&noOfRecords=$noOfRecords';

    var response = await networking.getData(
      path: 'GetOnlinePaymentListByIcNo?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetOnlinePaymentListByIcNoResponse getOnlinePaymentListByIcNoResponse =
          GetOnlinePaymentListByIcNoResponse.fromJson(response.data);
      var responseData = getOnlinePaymentListByIcNoResponse.onlinePayment;

      return Response(true, data: responseData);
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('get_package_fail'));
  }
}

// CreateOrder -> GetOrderListByIcNo -> FPX_SendB2CBankEnquiry -> FPX_SendB2CAuthRequest -> GetOnlinePaymentListByIcNo for transaction status
