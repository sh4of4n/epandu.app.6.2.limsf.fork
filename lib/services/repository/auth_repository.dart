import 'dart:async';
import 'dart:convert';

import 'package:epandu/services/api/model/kpp_model.dart';
import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/repository/profile_repository.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:xml2json/xml2json.dart';

import '../../app_localizations.dart';

class AuthRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final xml2json = Xml2Json();
  final networking = Networking();
  final profileRepo = ProfileRepo();

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  Future<Response> getWsUrl({
    context,
    acctUid,
    acctPwd,
    loginType,
    callback,
    altWsUrl,
    int milliseconds,
  }) async {
    final String wsVer = '1.1';
    final String wsUrl0 =
        'https://tbs.tbsdns.com/ClientAcct.MainService/_wsver_/MainService.asmx';
    final String wsUrl1 =
        'https://tbscaws.tbsdns.com:9001/ClientAcct.MainService/_wsver_/MainService.asmx';
    final String wsUrl2 =
        'http://tbscaws2.tbsdns.com/ClientAcct.MainService/_wsver_/MainService.asmx';
    final String wsUrl3 =
        'http://tbscaws3.tbsdns.com/ClientAcct.MainService/_wsver_/MainService.asmx';

    String wsUrl = wsUrl0;
    String wsCodeCrypt = 'TBSCLIENTACCTWS';

    if (altWsUrl != null) wsUrl = altWsUrl;

    wsUrl = wsUrl.replaceAll("_wsver_", wsVer.replaceAll(".", "_"));

    String params =
        'LoginPub?wsCodeCrypt=$wsCodeCrypt&acctUid=$acctUid&acctPwd=${Uri.encodeQueryComponent(acctPwd)}&loginType=$loginType&misc=';

    var response = await Networking(
            customUrl: '$wsUrl', milliseconds: milliseconds ?? 2000)
        .getData(path: params);

    if (response.isSuccess && response.data != null) {
      RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
      var trimTags = response.data.replaceAll(exp, '');

      var convertResponse = trimTags
          .replaceAll('&lt;', '<')
          .replaceAll('&gt;', '>')
          .replaceAll('&#xD;', '')
          .replaceAll(r"\'", "'");

      xml2json.parse(convertResponse);
      var jsonData = xml2json.toParker();
      var data = jsonDecode(jsonData);

      GetWsUrlResponse getWsUrlResponse = GetWsUrlResponse.fromJson(data);
      String wsVer = '5_2';
      final wsUrlBox = Hive.box('ws_url');

      if (getWsUrlResponse.loginAcctInfo != null) {
        await wsUrlBox.put(
          'wsUrl',
          getWsUrlResponse.loginAcctInfo.loginAcct.wsUrl
              .replaceAll('1_2', wsVer)
              .replaceAll('_wsver_', wsVer),
        );

        localStorage.saveCaUid(acctUid);
        localStorage.saveCaPwd(acctPwd);
        localStorage.saveCaPwdEncode(Uri.encodeQueryComponent(acctPwd));

        return Response(true,
            data: getWsUrlResponse.loginAcctInfo.loginAcct.wsUrl
                .replaceAll('1_2', wsVer),
            message: '');
      }
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      var callbackResult = await wsUrlCallback(
        context: context,
        acctUid: acctUid,
        acctPwd: acctPwd,
        altWsUrl: altWsUrl,
        wsUrl1: wsUrl1,
        wsUrl2: wsUrl2,
        wsUrl3: wsUrl3,
        message: AppLocalizations.of(context).translate('timeout_exception'),
      );

      if (callbackResult.isSuccess) {
        return Response(true, data: callbackResult.data, message: '');
      }
      // return Response(false,
      //     message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      var callbackResult = await wsUrlCallback(
        context: context,
        acctUid: acctUid,
        acctPwd: acctPwd,
        altWsUrl: altWsUrl,
        wsUrl1: wsUrl1,
        wsUrl2: wsUrl2,
        wsUrl3: wsUrl3,
        message: AppLocalizations.of(context).translate('socket_exception'),
      );

      if (callbackResult.isSuccess) {
        return Response(true, data: callbackResult.data, message: '');
      }
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('no_url_found'));
  }

  wsUrlCallback({
    context,
    acctUid,
    acctPwd,
    altWsUrl,
    wsUrl1,
    wsUrl2,
    wsUrl3,
    message,
  }) async {
    // Changes the web service URL based on exception and current altWsUrl.
    if (altWsUrl == null) {
      altWsUrl = wsUrl1;
    } else if (altWsUrl == wsUrl1) {
      altWsUrl = wsUrl2;
    } else if (altWsUrl == wsUrl2) {
      altWsUrl = wsUrl3;
    } else
      return Response(false, message: message);

    // Call this function again with the altWsUrl.
    var callbackResult = await getWsUrl(
      context: context,
      acctUid: acctUid,
      acctPwd: acctPwd,
      loginType: appConfig.wsCodeCrypt,
      altWsUrl: altWsUrl,
      milliseconds: 10000,
    );

    if (callbackResult.isSuccess) {
      return Response(true, data: callbackResult.data, message: '');
    }
  }

  Future<Response> login({
    context,
    String phone,
    String password,
    String latitude,
    String longitude,
    String deviceBrand,
    String deviceModel,
    String deviceRemark,
    String phDeviceId,
  }) async {
    final String caUid = await localStorage.getCaUid();
    // final String caPwd = await localStorage.getCaPwd();
    final String caPwdUrlEncode = await localStorage.getCaPwdEncode();
    String pushToken = await Hive.box('ws_url').get('push_token');
    String appVersion = await localStorage.getAppVersion();
    // String appCode = appConfig.appCode;
    // String appId = appConfig.appId;

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwdUrlEncode&diCode=${appConfig.diCode}&userPhone=$phone&userPwd=$password&ipAddress=0.0.0.0&latitude=$latitude&longitude=$longitude&appCode=${appConfig.appCode}&appId=${appConfig.appId}&deviceId=&appVersion=$appVersion&deviceRemark=${deviceRemark.isNotEmpty ? Uri.encodeComponent(deviceRemark) : ''}&phDeviceId=$phDeviceId&phLine1Number=&phNetOpName=&phPhoneType=&phSimSerialNo=&bdBoard=&bdBrand=$deviceBrand&bdDevice=&bdDisplay=&bdManufacturer=&bdModel=$deviceModel&bdProduct=&pfDeviceId=&regId=${pushToken ?? ''}';

    var response = await networking.getData(
      path: 'GetUserByUserPhonePwdWithDeviceId?$path',
    );

    if (response.isSuccess && response.data != null) {
      LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      var responseData = loginResponse.table1[0];

      if (responseData.userId != null && responseData.msg == null) {
        print(responseData.userId);
        print(responseData.sessionId);

        localStorage.saveUserId(responseData.userId);
        localStorage.saveSessionId(responseData.sessionId);
        localStorage.saveLoginDeviceId(responseData.deviceId);

        var result = await getUserRegisteredDI(context: context, type: 'LOGIN');

        return result;
      } else if (responseData.msg == 'Reset Password Success') {
        return Response(true, message: responseData.msg);
      } else if (responseData.msg ==
          'No user registered under this phone number.') {
        return Response(false,
            message: AppLocalizations.of(context).translate('invalid_phone'));
      }
      return Response(false, message: responseData.msg);
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
        message: AppLocalizations.of(context).translate('invalid_login'));
  }

  Future<Response> getUserRegisteredDI({context, @required type}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&userId=$userId';

    var response = await networking.getData(
      path: 'GetUserRegisteredDI?$path',
    );

    if (response.isSuccess && response.data != null) {
      UserRegisteredDiResponse userRegisteredDiResponse =
          UserRegisteredDiResponse.fromJson(response.data);
      var responseData = userRegisteredDiResponse.armaster;

      var profileResult = await profileRepo.getUserProfile(context: context);

      if (profileResult.isSuccess) {
        localStorage.saveName(profileResult.data[0].name);
        localStorage.saveNickName(profileResult.data[0].nickName);
        localStorage.saveEmail(profileResult.data[0].eMail);
        localStorage.saveUserPhone(profileResult.data[0].phone);
        localStorage.saveCountry(profileResult.data[0].countryName);
        localStorage.saveState(profileResult.data[0].stateName);
        localStorage.saveStudentIc(profileResult.data[0].icNo);
        localStorage.saveBirthDate(profileResult.data[0].birthDate);
        localStorage.saveRace(profileResult.data[0].race);
        localStorage.saveNationality(profileResult.data[0].nationality);
        localStorage.saveGender(profileResult.data[0].gender);
        if (profileResult.data[0].picturePath != null)
          localStorage.saveProfilePic(profileResult.data[0].picturePath
              .replaceAll(removeBracket, '')
              .split('\r\n')[0]);
      }

      // save empty on DiCode for user to choose
      if (type == 'LOGIN') localStorage.saveDiCode('');

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

    localStorage.saveDiCode('TBS');
    return Response(true, data: 'empty');
  }

  Future<Response> getDiProfile({context}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String diCode = await localStorage.getDiCode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode';

    var response = await networking.getData(
      path: 'GetDiProfile?$path',
    );

    if (response.isSuccess && response.data != null) {
      InstituteLogoResponse instituteLogoResponse;

      instituteLogoResponse = InstituteLogoResponse.fromJson(response.data);

      // save merchantDbCode
      localStorage.saveMerchantDbCode(instituteLogoResponse.armaster[0].dbcode);

      localStorage.saveInstituteLogo(instituteLogoResponse
          .armaster[0].appBackgroundPhotoPath
          .replaceAll(removeBracket, '')
          .split('\r\n')[0]);

      return Response(true,
          data: instituteLogoResponse.armaster[0].appBackgroundPhotoPath
              .replaceAll(removeBracket, '')
              .split('\r\n')[0]);
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

    return Response(false);
  }

  //logout
  Future<void> logout({context, type}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String userId = await localStorage.getUserId();
    //  Temporarily use TBS as diCode
    String diCode = appConfig.diCode;
    // String diCode = await localStorage.getDiCode();
    String sessionId = await localStorage.getSessionId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&userId=$userId&sessionId=$sessionId&isLogout=true';

    await networking.getData(
      path: 'IsSessionActive?$path',
    );

    await localStorage.reset();
    // Hive.box('ws_url').clear();
    if (type == 'CLEAR') {
      Hive.box('telcoList').clear();
      Hive.box('serviceList').clear();
    }
    // Hive.box('emergencyContact').clear();

    /* await getWsUrl(
      context: context,
      acctUid: caUid,
      acctPwd: caPwd,
      loginType: appConfig.wsCodeCrypt,
    ); */
  }

  // Register
  // Also used for invite friends
  // method was called checkExistingUser
  Future<Response> getUserByUserPhone({
    context,
    String countryCode,
    String phone,
    String userId,
    String diCode,
    String name,
    String nickName,
    String add1,
    String add2,
    String add3,
    String postcode,
    String city,
    String state,
    String country,
    String email,
    String icNo,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String userPhone;
    String defPhone = phone;

    if (countryCode.contains('60')) {
      if (phone.startsWith('0')) {
        userPhone = countryCode + phone.substring(1);
        defPhone = phone.substring(1);
      } else {
        userPhone = countryCode + phone;
        // defPhone = phone;
      }
    }

    if (userId.isEmpty) userId = 'TBS';

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&userPhone=${Uri.encodeComponent(userPhone)}&appCode=${appConfig.appCode}&appId=${appConfig.appId}';

    var response = await networking.getData(
      path: 'GetUserByUserPhoneAppId?$path',
    );

    if (response.isSuccess && response.data != null) {
      return Response(false,
          message: AppLocalizations.of(context).translate('registered_lbl'));
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
    // Number not registered
    var result = await createAppAccount(
      context,
      countryCode,
      defPhone,
      userId,
      diCode,
      name,
      nickName,
      add1,
      add2,
      add3,
      postcode,
      city,
      state,
      country,
      email,
      icNo,
    );

    return result;
  }

  Future<Response> createAppAccount(
    context,
    String countryCode,
    String phone,
    String userId,
    String diCode,
    String name,
    String nickName,
    String add1,
    String add2,
    String add3,
    String postCode,
    String city,
    String state,
    String country,
    String email,
    String icNo,
  ) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String trimIc = icNo?.replaceAll('-', '');
    String appVersion = await localStorage.getAppVersion();

    CreateAppAccountWithAppIdRequest params = CreateAppAccountWithAppIdRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      appCode: appConfig.appCode,
      appId: appConfig.appId,
      appVersion: appVersion,
      diCode: diCode ?? appConfig.diCode,
      userId: userId,
      name: name,
      nickName: nickName ?? '',
      icNo: trimIc ?? '',
      passportNo: '',
      phoneCountryCode: countryCode,
      phone: phone,
      nationality: '',
      dateOfBirthString: '',
      gender: '',
      race: '',
      add1: add1 ?? '',
      add2: add2 ?? '',
      add3: add3 ?? '',
      postcode: postCode ?? '',
      city: city ?? '',
      state: state ?? '',
      country: country ?? '',
      email: email ?? '',
    );

    String body = jsonEncode(params);
    String api = 'CreateAppAccountWithAppId';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    var message = '';

    // Success
    if (response.isSuccess &&
        response.data != null &&
        response.data.isNotEmpty) {
      message = AppLocalizations.of(context).translate('invite_sent');
      return Response(true, message: message);
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

    // Fail
    /*  if (response.message.isEmpty) {
      message = AppLocalizations.of(context).translate('invite_fail');
    } */
    message = AppLocalizations.of(context).translate('invite_fail');

    return Response(false, message: message);
  }

  Future<Response> verifyOldPassword(
      {context, currentPassword, newPassword}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String userId = await localStorage.getUserId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&userId=$userId&userPwd=$currentPassword';

    var response = await networking.getData(
      path: 'GetUserByUserIdPwd?$path',
    );

    if (response.isSuccess && response.data.contains('Valid user.')) {
      var result = await saveUserPassword(
          context: context, userId: userId, password: newPassword);

      return result;
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

    return Response(false, message: response.message);
  }

  // was called updatePassword
  Future<Response> saveUserPassword({context, userId, password}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String appCode = appConfig.appCode;
    String appId = appConfig.appId;

    SaveUserPasswordRequest saveUserPasswordRequest = SaveUserPasswordRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      appCode: appCode,
      appId: appId,
      userId: userId,
      password: password,
    );

    String body = jsonEncode(saveUserPasswordRequest);
    String api = 'SaveUserPassword';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data == 'True') {
      return Response(true, message: 'password_updated');
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

    return Response(false, message: 'password_change_fail');
  }

  // Enrollment
  Future<Response> getDiList({context}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd';

    var response = await networking.getData(
      path: 'GetDiList?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetDiListResponse getDiListResponse =
          GetDiListResponse.fromJson(response.data);
      var responseData = getDiListResponse.armasterProfile;

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

    return Response(false, message: 'No records found.');
  }

  Future<Response> getDiNearMe({
    context,
    @required merchantNo,
    @required startIndex,
    @required noOfRecords,
    @required latitude,
    @required longitude,
    @required maxRadius,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String userId = await localStorage.getUserId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd' +
            '&appCode=${appConfig.appCode}&appId=${appConfig.appId}' +
            '&merchantNo=$merchantNo&userId=$userId' +
            '&startIndex=$startIndex&noOfRecords=$noOfRecords' +
            '&latitude=$latitude&longitude=$longitude&maxRadius=$maxRadius';

    var response = await networking.getData(
      path: 'GetDINearMe?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetDiNearMeResponse getDiNearMeResponse =
          GetDiNearMeResponse.fromJson(response.data);
      var responseData = getDiNearMeResponse.merchant;

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

    return Response(false, message: 'No records found.');
  }

  Future<Response> getGroupIdByDiCodeForOnline({context, diCode}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode';

    var response = await networking.getData(
      path: 'GetGroupIdByDiCodeForOnline?$path',
    );

    print(response.data);

    if (response.isSuccess && response.data != null) {
      GetGroupIdByDiCodeForOnlineResponse getGroupIdByDiCodeForOnlineResponse =
          GetGroupIdByDiCodeForOnlineResponse.fromJson(response.data);
      var responseData = getGroupIdByDiCodeForOnlineResponse.dgroup;

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

    return Response(false, message: 'No records found.');
  }

  Future<Response> getEnrollHistory({context, groupId}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String diCode = await localStorage.getDiCode();
    String icNo = await localStorage.getStudentIc();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&icNo=$icNo&groupId=${groupId ?? ''}';

    var response = await networking.getData(
      path: 'GetEnrollHistoryV2?$path',
    );

    print(response.data);

    if (response.isSuccess && response.data != null) {
      GetEnrollHistoryResponse getEnrollHistoryResponse =
          GetEnrollHistoryResponse.fromJson(response.data);
      var responseData = getEnrollHistoryResponse.enroll;

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

    return Response(false, message: 'No records found.');
  }

  Future<Response> saveEnrollmentWithParticular({
    context,
    String phoneCountryCode,
    String phone,
    String diCode,
    String icNo,
    String groupId,
    String name,
    String email,
    String nationality,
    String dateOfBirthString,
    String gender,
    String race,
    List<int> userProfileImage,
    String userProfileImageBase64String,
    bool removeUserProfileImage,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    String userId = await localStorage.getUserId();
    String phoneCountryCode = await localStorage.getCountryCode();
    String phone = await localStorage.getUserPhone();

    SaveEnrollmentRequest saveEnrollmentRequest = SaveEnrollmentRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      appCode: appConfig.appCode,
      appId: appConfig.appId,
      diCode: diCode,
      groupId: groupId,
      icNo: icNo,
      name: name,
      nationality: nationality,
      phoneCountryCode: phoneCountryCode,
      phone: phone,
      dateOfBirthString: dateOfBirthString,
      gender: gender,
      race: race,
      add1: '',
      add2: '',
      add3: '',
      postcode: '',
      city: '',
      state: '',
      country: '',
      email: email,
      userId: userId,
      userProfileImage: userProfileImage,
      userProfileImageBase64String: userProfileImageBase64String ?? '',
      removeUserProfileImage: removeUserProfileImage ?? false,
    );

    String body = jsonEncode(saveEnrollmentRequest);
    String api = 'SaveEnrollmentWithParticular';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.data == 'True') {
      localStorage.saveDiCode(diCode);
      localStorage.saveStudentIc(icNo);

      return Response(true,
          message: AppLocalizations.of(context).translate('enroll_success'));
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
        message: response.message
            .toString()
            .replaceAll('[BLException]', '')
            .replaceAll(r'\u000d\u000a', '')
            .replaceAll(r'"', ''));
  }

  Future<Response> getActiveFeed({
    context,
    @required feedType,
    @required startIndex,
    @required noOfRecords,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&feedType=${feedType ?? ''}&startIndex=$startIndex&noOfRecords=$noOfRecords';

    var response = await networking.getData(
      path: 'GetActiveFeedByType?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetActiveFeedResponse getActiveFeedResponse =
          GetActiveFeedResponse.fromJson(response.data);
      var responseData = getActiveFeedResponse.feed;

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
        message: AppLocalizations.of(context).translate('get_promotion_fail'));
  }

  Future<Response> deleteAppMemberAccount({context}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    String userId = await localStorage.getUserId();

    DeleteAppMemberAccountRequest deleteAppMemberAccountRequest =
        DeleteAppMemberAccountRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      userId: userId,
    );

    String body = jsonEncode(deleteAppMemberAccountRequest);
    String api = 'DeleteAppMemberAccount';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.data == 'True') {
      await localStorage.reset();
      // Hive.box('ws_url').clear();
      Hive.box('telcoList').clear();
      Hive.box('serviceList').clear();

      return Response(true,
          message: AppLocalizations.of(context).translate('account_deleted'));
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
        message: AppLocalizations.of(context).translate('account_delete_fail'));
  }

  Future<Response> requestVerificationCode(
      {context, phoneCountryCode, phone}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String appCode = appConfig.appCode;
    String appId = appConfig.appId;

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&appCode=$appCode&appId=$appId&phoneCountryCode=${Uri.encodeQueryComponent(phoneCountryCode)}&phone=$phone';

    var response = await networking.getData(
      path: 'RequestVerificationCode?$path',
    );

    if (response.isSuccess && response.data != null) {
      return Response(true,
          message: AppLocalizations.of(context).translate('verification_sent'),
          data: response.data);
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

    if (response.message
        .toString()
        .contains('Phone number already registered')) {
      return Response(false,
          message: AppLocalizations.of(context)
              .translate('phone_number_registered'));
    }
    return Response(false,
        message:
            AppLocalizations.of(context).translate('verification_send_fail'));
  }

  Future<Response> register({
    context,
    String countryCode,
    String phone,
    String name,
    String nickName,
    String email,
    String signUpPwd,
    String latitude,
    String longitude,
    String deviceId,
    String deviceBrand,
    String deviceModel,
    String deviceVersion,
    List<int> userProfileImage,
    String userProfileImageBase64String,
    bool removeUserProfileImage,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String appVersion = await localStorage.getAppVersion();
    String pushToken = await Hive.box('ws_url').get('push_token');

    RegisterRequest params = RegisterRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: appConfig.diCode,
      userId: 'TBS',
      name: name,
      nickName: nickName,
      icNo: '',
      passportNo: '',
      phoneCountryCode: countryCode,
      phone: phone,
      nationality: '',
      dateOfBirthString: '',
      gender: '',
      race: '',
      add1: '',
      add2: '',
      add3: '',
      postcode: '',
      city: '',
      state: '',
      country: '',
      email: email ?? '',
      signUpPwd: signUpPwd,
      userProfileImage: userProfileImage,
      userProfileImageBase64String: userProfileImageBase64String ?? '',
      removeUserProfileImage: removeUserProfileImage ?? false,
      latitude: latitude,
      longitude: longitude,
      appCode: appConfig.appCode,
      appId: appConfig.appId,
      deviceId: '',
      appVersion: appVersion,
      deviceRemark: deviceVersion,
      phDeviceId: deviceId,
      phLine1Number: '',
      phNetOpName: '',
      phPhoneType: '',
      phSimSerialNo: '',
      bdBoard: '',
      bdBrand: deviceBrand,
      bdDevice: '',
      bdDisplay: '',
      bdManufacturer: '',
      bdModel: deviceModel,
      bdProduct: '',
      pfDeviceId: '',
      regId: pushToken,
    );

    String body = jsonEncode(params);
    String api = 'CreateAppAccountWithPwd';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    var message = '';

    // Success
    if (response.isSuccess && response.data != null) {
      message = AppLocalizations.of(context).translate('register_success');

      return Response(true, message: message);
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

    // Fail
    message = AppLocalizations.of(context).translate('register_error');

    return Response(false, message: message);
  }

  // scan QR
  /* Future<Response> registerUserToDI({
    context,
    String diCode,
    String icNo,
    // String name,
    String nationality,
    // String phoneCountryCode,
    // String phone,
    String dateOfBirthString,
    String gender,
    String race,
    String add1,
    String add2,
    String add3,
    String postcode,
    String city,
    String state,
    String country,
    String email,
    // String userId,
    @required String bodyTemperature,
    @required String scanCode,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String userId = await localStorage.getUserId();
    String name = await localStorage.getName();
    String phoneCountryCode = await localStorage.getCountryCode();
    String phone = await localStorage.getUserPhone();
    // String diCode = await localStorage.getDiCode();

    RegisterUserToDIRequest params = RegisterUserToDIRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      appCode: appConfig.appCode,
      appId: appConfig.appId,
      diCode: diCode,
      icNo: icNo ?? '',
      name: name,
      nationality: nationality ?? 'WARGANEGARA',
      phoneCountryCode: phoneCountryCode,
      phone: phone,
      dateOfBirthString: dateOfBirthString ?? '',
      gender: gender ?? '',
      race: race ?? '',
      add1: add1 ?? '',
      add2: add2 ?? '',
      add3: add3 ?? '',
      postcode: postcode ?? '',
      city: city ?? '',
      state: state ?? '',
      country: country ?? '',
      email: email ?? '',
      userId: userId ?? '',
      bodyTemperature: bodyTemperature ?? '0',
      scanCode: scanCode,
    );

    String body = jsonEncode(params);
    String api = 'RegisterUserToDI';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    var message = '';

    // Success
    if (response.isSuccess && response.data != null) {
      message = AppLocalizations.of(context).translate('success');

      return Response(true, message: message);
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

    // Fail
    message = AppLocalizations.of(context).translate('register_error');

    return Response(false, message: message);
  } */

  Future<Response> registerUserToDI({
    context,
    String appVersion,
    // String loginId,
    @required String bodyTemperature,
    String scannedAppId,
    String scannedAppVer,
    String scannedLoginId,
    String scannedUserId,
    @required String scanCode,
    String deviceRemark,
    String phDeviceId,
    String phLine1Number,
    String phNetOpName,
    String phPhoneType,
    String phSimSerialNo,
    String bdBoard,
    String bdBrand,
    String bdDevice,
    String bdDisplay,
    String bdManufacturer,
    String bdModel,
    String bdProduct,
    String pfDeviceId,
    String regId,
    String latitude,
    String longitude,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String userId = await localStorage.getUserId();
    // String diCode = await localStorage.getDiCode();

    String countryCode = await localStorage.getCountryCode();
    String phone = await localStorage.getUserPhone();
    String loginId = (countryCode + phone).replaceAll('+6', '');
    String merchantNo = await localStorage.getMerchantDbCode();

    RegisterUserToDIRequest params = RegisterUserToDIRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      appCode: appConfig.appCode ?? '',
      appId: appConfig.appId ?? '',
      appVersion: appVersion ?? '',
      merchantNo: merchantNo ?? '',
      loginId: loginId ?? '',
      userId: userId ?? '',
      bodyTemperature: bodyTemperature ?? '',
      scannedAppId: scannedAppId ?? '',
      scannedAppVer: scannedAppVer ?? '',
      scannedLoginId: scannedLoginId ?? '',
      scannedUserId: scannedUserId ?? '',
      scanCode: scanCode,
      deviceRemark: deviceRemark ?? '',
      phDeviceId: phDeviceId,
      phLine1Number: phLine1Number ?? '',
      phNetOpName: phNetOpName ?? '',
      phPhoneType: phPhoneType ?? '',
      phSimSerialNo: phSimSerialNo ?? '',
      bdBoard: bdBoard ?? '',
      bdBrand: bdBrand ?? '',
      bdDevice: bdDevice ?? '',
      bdDisplay: bdDisplay ?? '',
      bdManufacturer: bdManufacturer ?? '',
      bdModel: bdModel ?? '',
      bdProduct: bdProduct ?? '',
      pfDeviceId: pfDeviceId ?? '',
      regId: regId ?? '',
      latitude: latitude,
      longitude: longitude,
    );

    String body = jsonEncode(params);
    String api = 'RegisterUserToDIV2';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    var message = '';

    // Success
    if (response.isSuccess && response.data != null) {
      message = AppLocalizations.of(context).translate('success');

      return Response(true, message: message);
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

    // Fail
    message = AppLocalizations.of(context).translate('register_error');

    return Response(false, message: message);
  }

  // DI enrollment
  Future<Response> getPackageListByPackageCodeList({
    @required context,
    @required diCode,
    @required packageCodeJson,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&packageCodeJson=$packageCodeJson';

    var response = await networking.getData(
      path: 'GetPackageListByPackageCodeList?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetPackageListByPackageCodeListResponse
          getPackageListByPackageCodeListResponse =
          GetPackageListByPackageCodeListResponse.fromJson(response.data);
      var responseData = getPackageListByPackageCodeListResponse.package;

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
