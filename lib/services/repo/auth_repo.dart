import 'dart:convert';

import 'package:epandu/services/api/api_service.dart';
import 'package:epandu/services/api/get_base_url.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/model/auth_model.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:xml2json/xml2json.dart';

import '../../app_localizations.dart';

class AuthRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final postApiService = ApiService;
  final xml2json = Xml2Json();

  Future<Response> getWsUrl({
    context,
    acctUid,
    acctPwd,
    loginType,
    callback,
    altWsUrl,
  }) async {
    final String WSVER = '1.1';
    final String WSURL0 =
        'https://tbs.tbsdns.com/ClientAcct.MainService/_wsver_/MainService.asmx';
    final String WSURL1 =
        'https://tbscaws.tbsdns.com:9001/ClientAcct.MainService/_wsver_/MainService.asmx';
    final String WSURL2 =
        'http://tbscaws2.tbsdns.com/ClientAcct.MainService/_wsver_/MainService.asmx';
    final String WSURL3 =
        'http://tbscaws3.tbsdns.com/ClientAcct.MainService/_wsver_/MainService.asmx';

    // bool async = false;

    String wsUrl = WSURL0;
    String wsCodeCrypt = 'TBSCLIENTACCTWS';

    if (altWsUrl != null) wsUrl = altWsUrl;

    wsUrl = wsUrl.replaceAll("_wsver_", WSVER.replaceAll(".", "_"));

    var response = await Provider.of<GetBaseUrl>(context).getWsUrl(
      baseUrl: wsUrl,
      wsCodeCrypt: wsCodeCrypt,
      acctUid: acctUid,
      acctPwd: acctPwd,
      loginType: loginType,
      misc: '',
    );

    if (response.body != 'null' && response.statusCode == 200) {
      RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
      var trimTags = response.body.replaceAll(exp, '');

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

      wsUrlBox.put(
          'wsUrl',
          getWsUrlResponse.loginAcctInfo.loginAcct.wsUrl
              .replaceAll('1_2', wsVer));

      localStorage.saveWsUrl(getWsUrlResponse.loginAcctInfo.loginAcct.wsUrl
          .replaceAll('1_2', wsVer));
      localStorage.saveCaUid(acctUid);
      localStorage.saveCaPwd(acctPwd);
      localStorage.saveCaPwdEncode(Uri.encodeQueryComponent(acctPwd));

      return Response(true,
          data: getWsUrlResponse.loginAcctInfo.loginAcct.wsUrl
              .replaceAll('1_2', wsVer),
          message: '');
    }

    return Response(false, message: 'No URL found with this client account.');
  }

  Future<Response> login({context, String phone, String password}) async {
    final String caUid = await localStorage.getCaUid();
    // final String caPwd = await localStorage.getCaPwd();
    final String caPwdUrlEncode = await localStorage.getCaPwdEncode();

    var response = await Provider.of<ApiService>(context).login(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwdUrlEncode,
      diCode: appConfig.diCode,
      userPhone: phone,
      userPwd: password,
      ipAddress: '0.0.0.0',
    );

    if (response.body != 'null') {
      LoginResponse loginResponse = LoginResponse.fromJson(response.body);
      var responseData = loginResponse.table1[0];

      if (responseData.userId != null && responseData.msg == null) {
        print(responseData.userId);
        print(responseData.sessionId);

        localStorage.saveUserId(responseData.userId);
        localStorage.saveSessionId(responseData.sessionId);

        var result = await checkDiList(context: context);

        return result;
      } else if (responseData.msg == 'Reset Password Success') {
        return Response(true, message: responseData.msg);
      } else if (responseData.msg != null &&
          responseData.msg.contains('TimeoutException')) {
        return Response(false, message: 'timeout');
      } else if (responseData.msg != null &&
          responseData.msg.contains('SocketException')) {
        return Response(false, message: 'socket');
      } else if (responseData.msg != null) {
        return Response(false, message: responseData.msg);
      }
    }
    return Response(false);
  }

  Future<Response> checkDiList({context}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();

    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();

    var response = await Provider.of<ApiService>(context).checkDiList(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      userId: userId,
    );

    if (response.body != 'null') {
      UserRegisteredDiResponse userRegisteredDiResponse =
          UserRegisteredDiResponse.fromJson(response.body);
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

    await Provider.of<ApiService>(context).logout(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      userId: userId,
      sessionId: sessionId,
      isLogout: 'true',
    );

    await localStorage.reset();

    /* await getWsUrl(
      context: context,
      acctUid: caUid,
      acctPwd: caPwd,
      loginType: appConfig.wsCodeCrypt,
    ); */
  }

  // Register
  // Also used for invite friends
  Future<Response> checkExistingUser({
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

    var response = await Provider.of<ApiService>(context).checkExistingUser(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      userPhone: userPhone,
    );

    if (response.body != 'null') {
      return Response(false,
          message: AppLocalizations.of(context).translate('registered_lbl'));
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

    var response = await Provider.of<ApiService>(context).register(params);

    var message = '';

    // Success
    if (response.body != 'null') {
      if (type == 'INVITE')
        message = AppLocalizations.of(context).translate('invite_sent');
      else
        message = AppLocalizations.of(context).translate('register_success');

      return Response(true, message: message);
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

    var response = await Provider.of<ApiService>(context).verifyOldPassword(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      userId: userId,
      userPwd: currentPassword,
    );

    if (response.body.contains('Valid user.')) {
      var result = await updatePassword(
          context: context, userId: userId, password: newPassword);

      return result;
    }

    return Response(false, message: response.error.toString());
  }

  Future<Response> updatePassword({context, userId, password}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    UpdatePasswordRequest updatePasswordRequest = UpdatePasswordRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      userId: userId,
      password: password,
    );

    var response = await Provider.of<ApiService>(context)
        .updatePassword(updatePasswordRequest);

    if (response.body == 'True') {
      return Response(true, message: 'password_updated');
    }

    return Response(false, message: 'password_change_fail');
  }
}
