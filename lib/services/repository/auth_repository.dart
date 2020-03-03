import 'dart:async';
import 'dart:convert';

import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/model/auth_model.dart';
import 'package:hive/hive.dart';
import 'package:xml2json/xml2json.dart';

import '../../app_localizations.dart';

class AuthRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final xml2json = Xml2Json();
  final networking = Networking();

  Future<Response> getWsUrl({
    context,
    acctUid,
    acctPwd,
    loginType,
    callback,
    altWsUrl,
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

    var response = await Networking(customUrl: '$wsUrl').getData(path: params);

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
      String wsVer = '1_3';
      final wsUrlBox = Hive.box('ws_url');

      if (getWsUrlResponse.loginAcctInfo != null) {
        await wsUrlBox.put(
            'wsUrl',
            getWsUrlResponse.loginAcctInfo.loginAcct.wsUrl
                .replaceAll('1_2', wsVer));

        localStorage.saveCaUid(acctUid);
        localStorage.saveCaPwd(acctPwd);
        localStorage.saveCaPwdEncode(Uri.encodeQueryComponent(acctPwd));

        return Response(true,
            data: getWsUrlResponse.loginAcctInfo.loginAcct.wsUrl
                .replaceAll('1_2', wsVer),
            message: '');
      }
    } else if (response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message.contains('socket')) {
      // Changes the web service URL based on exception and current altWsUrl.
      if (altWsUrl == null)
        altWsUrl = wsUrl1;
      else if (altWsUrl == wsUrl1)
        altWsUrl = wsUrl2;
      else if (altWsUrl == wsUrl2)
        altWsUrl = wsUrl3;
      else
        return Response(false,
            message:
                AppLocalizations.of(context).translate('socket_exception'));

      // Call this function again with the altWsUrl.
      getWsUrl(
        context: context,
        acctUid: acctUid,
        acctPwd: acctPwd,
        loginType: appConfig.wsCodeCrypt,
        altWsUrl: altWsUrl,
      );
    } else if (response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('no_url_found'));
  }

  Future<Response> login({context, String phone, String password}) async {
    final String caUid = await localStorage.getCaUid();
    // final String caPwd = await localStorage.getCaPwd();
    final String caPwdUrlEncode = await localStorage.getCaPwdEncode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwdUrlEncode&diCode=${appConfig.diCode}&userPhone=$phone&userPwd=$password&ipAddress=0.0.0.0';

    var response = await networking.getData(
      path: 'GetUserByUserPhonePwd?$path',
    );

    if (response.isSuccess && response.data != null) {
      LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      var responseData = loginResponse.table1[0];

      if (responseData.userId != null && responseData.msg == null) {
        print(responseData.userId);
        print(responseData.sessionId);

        localStorage.saveUserId(responseData.userId);
        localStorage.saveSessionId(responseData.sessionId);

        var result = await getUserRegisteredDI(context: context);

        return result;
      } else if (responseData.msg == 'Reset Password Success') {
        return Response(true, message: responseData.msg);
      }
      return Response(false, message: responseData.msg);
    } else if (response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('invalid_login'));
  }

  Future<Response> getUserRegisteredDI({context}) async {
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

      localStorage.saveUsername(responseData[0].name);
      localStorage.saveUserPhone(
          responseData[0].phoneCountryCode + responseData[0].phone);
      localStorage.saveEmail(responseData[0].eMail);
      localStorage.saveNationality(responseData[0].nationality);
      localStorage.saveGender(responseData[0].gender);
      localStorage.saveStudentIc(responseData[0].icNo);

      // Temporary workaround
      if (responseData[0].add is String)
        localStorage.saveAddress(responseData[0].add);

      localStorage.saveCountry(responseData[0].country);
      localStorage.saveState(responseData[0].state);
      localStorage.savePostCode(responseData[0].postcode);

      return Response(true, data: responseData);
    } else if (response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    localStorage.saveDiCode('TBS');
    return Response(true, data: 'empty');
  }

  //logout
  Future<void> logout({context}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String userId = await localStorage.getUserId();
    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String sessionId = await localStorage.getSessionId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&userId=$userId&sessionId=$sessionId&isLogout=true';

    await networking.getData(
      path: 'IsSessionActive?$path',
    );

    await localStorage.reset();
    // Hive.box('ws_url').clear();
    Hive.box('telcoList').clear();
    Hive.box('serviceList').clear();
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
    String type,
    String countryCode,
    String phone,
    String userId,
    String diCode,
    String name,
    String add1,
    String add2,
    String add3,
    String postcode,
    String city,
    String state,
    String country,
    String email,
    String icNo,
    String registerAs,
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
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&userPhone=$userPhone';

    var response = await networking.getData(
      path: 'GetUserByUserPhone?$path',
    );

    if (response.isSuccess && response.data != null) {
      return Response(false,
          message: AppLocalizations.of(context).translate('registered_lbl'));
    } else if (response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }
    // Number not registered
    var result = await register(
      context,
      type,
      countryCode,
      defPhone,
      userId,
      diCode,
      name,
      add1,
      add2,
      add3,
      postcode,
      city,
      state,
      country,
      email,
      icNo,
      registerAs,
    );

    return result;
  }

  Future<Response> register(
    context,
    String type,
    String countryCode,
    String phone,
    String userId,
    String diCode,
    String name,
    String add1,
    String add2,
    String add3,
    String postCode,
    String city,
    String state,
    String country,
    String email,
    String icNo,
    String registerAs,
  ) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String trimIc = icNo?.replaceAll('-', '');

    RegisterRequest params = RegisterRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      appCode: '',
      diCode: diCode ?? appConfig.diCode,
      userId: userId,
      name: name,
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
    String api = 'CreateAppAccount';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    var message = '';

    // Success
    if (response.isSuccess && response.data != null) {
      if (type == 'INVITE')
        message = AppLocalizations.of(context).translate('invite_sent');
      else
        message = AppLocalizations.of(context).translate('register_success');

      return Response(true, message: message);
    } else if (response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    // Fail
    if (type == 'INVITE')
      message = AppLocalizations.of(context).translate('invite_fail');
    else
      message = AppLocalizations.of(context).translate('register_error');

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
    } else if (response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false, message: response.message);
  }

  // was called updatePassword
  Future<Response> saveUserPassword({context, userId, password}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    SaveUserPasswordRequest saveUserPasswordRequest = SaveUserPasswordRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
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
    } else if (response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message.contains('format')) {
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
    }

    return Response(false, message: 'No records found.');
  }

  Future<Response> saveEnrollmentWithParticular({
    context,
    diCode,
    icNo,
    groupId,
    name,
    nationality,
    dateOfBirthString,
    gender,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    String userId = await localStorage.getUserId();

    SaveEnrollmentRequest saveEnrollmentRequest = SaveEnrollmentRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      groupId: groupId,
      icNo: icNo,
      name: name,
      nationality: nationality,
      dateOfBirthString: dateOfBirthString,
      gender: gender,
      userId: userId,
      race: '',
      add1: '',
      add2: '',
      add3: '',
      postcode: '',
      city: '',
      state: '',
      country: '',
      email: '',
    );

    String body = jsonEncode(saveEnrollmentRequest);
    String api = 'SaveEnrollmentWithParticular';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.data == 'True') {
      localStorage.saveDiCode(diCode);

      return Response(true,
          message: AppLocalizations.of(context).translate('enroll_success'));
    }

    return Response(false,
        message: response.message
            .toString()
            .replaceAll('[BLException]', '')
            .replaceAll(r'\u000d\u000a', '')
            .replaceAll(r'"', ''));
  }
}
