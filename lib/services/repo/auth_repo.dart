import 'dart:convert';
import 'package:epandu/services/result.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/api/model/auth_model.dart';

class AuthRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Result> getWsUrl({
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

    String params =
        '?wsCodeCrypt=$wsCodeCrypt&acctUid=$acctUid&acctPwd=${Uri.encodeQueryComponent(acctPwd)}&loginType=$loginType&misc=';

    String apiMethod = '/LoginPub';

    var response =
        await Networking(customUrl: '$wsUrl$apiMethod').getData(path: params);

    var responseData;

    if (response['string']['LoginAcctInfo'] != null)
      responseData = response['string']['LoginAcctInfo']['LoginAcct'];

    if (responseData != null && responseData['WsUrl'] != null) {
      localStorage.saveWsUrl(responseData['WsUrl']);
      localStorage.saveCaUid(acctUid);
      localStorage.saveCaPwd(acctPwd);
      localStorage.saveCaPwdEncode(Uri.encodeQueryComponent(acctPwd));

      return Result(true, data: responseData['WsUrl'], message: '');
    }
    return Result(false, message: 'No URL found with this client account.');
  }

  Future login({String phone, String password}) async {
    String caUid = await localStorage.getCaUid();
    String caPwdUrlEncode = await localStorage.getCaPwdEncode();

    var params =
        'GetUserByUserPhonePwd?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwdUrlEncode&diCode=${appConfig.diCode}&userPhone=$phone&userPwd=$password&ipAddress=0.0.0.0';

    var response = await networking.getData(path: params);

    var responseData;

    if (response != null) {
      responseData = response['GetUserByUserPhonePwdResponse']
          ['GetUserByUserPhonePwdResult']['UserInfo']['Table1'];
    }

    if (response != null && responseData['msg'] == null) {
      print(responseData['userId']);
      print(responseData['sessionId']);

      localStorage.saveUserId(responseData['userId']);
      localStorage.saveSessionId(responseData['sessionId']);

      var result = await checkDiList();

      return result;
    } else if (response != null &&
        responseData['msg'] == 'Reset Password Success') {
      return Result(true, message: responseData['msg']);
    }

    return Result(false, message: 'Invalid username or password.');
  }

  Future<Result> checkDiList() async {
    String caUid = await localStorage.getCaUid();
    String caPwdUrlEncode = await localStorage.getCaPwdEncode();
    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();

    var params =
        'GetUserRegisteredDI?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwdUrlEncode&diCode=$diCode&userId=$userId';

    var response = await networking.getData(path: params);

    var responseData = response['GetUserRegisteredDIResponse']
        ['GetUserRegisteredDIResult']['ArmasterInfo'];

    // API returns one DI
    if (responseData != null && responseData['Armaster'][0] == null) {
      localStorage.saveUsername(responseData['Armaster']['name'].toString());
      localStorage.saveUserPhone(responseData['Armaster']
              ['phone_country_code'] +
          responseData['Armaster']['phone'].toString());
      localStorage.saveEmail(responseData['Armaster']['e_mail'].toString());
      localStorage
          .saveNationality(responseData['Armaster']['nationality'].toString());
      localStorage.saveGender(responseData['Armaster']['gender'].toString());
      localStorage.saveStudentIc(responseData['Armaster']['ic_no'].toString());
      localStorage.saveAddress(responseData['Armaster']['add'].toString());
      localStorage.saveCountry(responseData['Armaster']['country'].toString());
      localStorage.saveState(responseData['Armaster']['state'].toString());
      localStorage
          .savePostCode(responseData['Armaster']['postcode'].toString());

      return Result(true, data: responseData['Armaster']);
    }
    // API returns more than one DI
    else if (responseData != null && responseData['Armaster'][0] != null) {
      localStorage.saveUsername(responseData['Armaster'][0]['name'].toString());
      localStorage.saveUserPhone(responseData['Armaster'][0]
              ['phone_country_code'] +
          responseData['Armaster'][0]['phone'].toString());
      localStorage.saveEmail(responseData['Armaster'][0]['e_mail'].toString());
      localStorage.saveNationality(
          responseData['Armaster'][0]['nationality'].toString());
      localStorage.saveGender(responseData['Armaster'][0]['gender'].toString());
      localStorage
          .saveStudentIc(responseData['Armaster'][0]['ic_no'].toString());
      localStorage.saveAddress(responseData['Armaster'][0]['add'].toString());
      localStorage
          .saveCountry(responseData['Armaster'][0]['country'].toString());
      localStorage.saveState(responseData['Armaster'][0]['state'].toString());
      localStorage
          .savePostCode(responseData['Armaster'][0]['postcode'].toString());

      return Result(true, data: responseData['Armaster']);
    }
    // API returns null
    else if (responseData == null) {
      String diCode = 'TBS';
      localStorage.saveDiCode(diCode);

      return Result(true, data: 'empty');
    } else {
      return Result(false,
          message:
              'Oops! An unexpected error occurred. Please try again later.');
    }
  }

  //logout
  Future<void> logout() async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String caPwdUrlEncode = await localStorage.getCaPwdEncode();
    String userId = await localStorage.getUserId();
    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String sessionId = await localStorage.getSessionId();

    var params =
        'IsSessionActive?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwdUrlEncode&diCode=$diCode&userId=$userId&sessionId=$sessionId&isLogout=true';

    await networking.getData(path: params);
    await localStorage.reset();

    await getWsUrl(
      acctUid: caUid,
      acctPwd: caPwd,
      loginType: appConfig.wsCodeCrypt,
    );
  }

  // Register
  // Also used for invite friends
  Future<Result> checkExistingUser({
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
    String caPwdUrlEncode = await localStorage.getCaPwdEncode();
    String userPhone;
    String params;
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

    params =
        'GetUserByUserPhone?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwdUrlEncode&userPhone=$userPhone';

    var response = await networking.getData(path: params);

    var responseData = response['GetUserByUserPhoneResponse']
        ['GetUserByUserPhoneResult']['UserInfo'];

    if (responseData == null) {
      // Number not registered
      var result = await register(
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
    } else {
      return Result(false, message: responseData.toString());
    }
  }

  Future<Result> register(
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

    // If user registered as normal or student
    // if (registerAs == 'NORMAL')
    //   api = 'CreateAppAccount';
    // else if (registerAs == 'STUDENT') api = 'CreateMemberAccount';

    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    var message = '';

    if (response['CreateAppAccountResult'].isNotEmpty) {
      if (type == 'INVITE')
        message = 'Your invitation has been sent. Yay!';
      else
        message =
            'You are now registered, you will receive a SMS notification.';

      return Result(true, message: message);
    }

    if (type == 'INVITE')
      message = 'Invitation failed, please try again later.';
    else
      message = 'Registration failed, please try again later.';

    return Result(false, message: message);
  }

  Future<Result> verifyOldPassword({currentPassword, newPassword}) async {
    String caUid = await localStorage.getCaUid();
    String caPwdUrlEncode = await localStorage.getCaPwdEncode();
    String userId = await localStorage.getUserId();

    String params =
        'GetUserByUserIdPwd?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwdUrlEncode&userId=$userId&userPwd=$currentPassword';

    var response = await networking.getData(path: params);

    var responseData =
        response['GetUserByUserIdPwdResponse']['GetUserByUserIdPwdResult'];

    if (responseData != null && responseData.contains('Valid user.')) {
      var result = await updatePassword(userId: userId, password: newPassword);

      return result;
    }

    return Result(false, message: 'Incorrect password.');
  }

  Future<Result> updatePassword({userId, password}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    UpdatePasswordRequest updatePasswordRequest = UpdatePasswordRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      userId: userId,
      password: password,
    );

    String body = jsonEncode(updatePasswordRequest);

    String api = 'SaveUserPassword';

    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    var responseData = response['SaveUserPasswordResult'];

    if (responseData == true) {
      return Result(true, message: 'Password successfully updated.');
    }
    return Result(false,
        message: 'Failed to change password. Please try again later.');
  }

  Future<Result> getStudentEnrollmentData() async {
    String caUid = await localStorage.getCaUid();
    String caPwdUrlEncode = await localStorage.getCaPwdEncode();
    //  Temporarily use TBS as diCode
    String diCode = 'TBS';
    // String diCode = await localStorage.getDiCode();
    String groupId = '';
    String icNo = await localStorage.getStudentIc();

    String params =
        'GetEnrollByCode?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwdUrlEncode&diCode=$diCode&icNo=$icNo&groupId=$groupId';

    var response = await networking.getData(path: params);

    var responseData;

    if (response != null &&
        response['GetEnrollByCodeResponse']['GetEnrollByCodeResult']
                ['EnrollInfo'] !=
            null) {
      responseData = response['GetEnrollByCodeResponse']
          ['GetEnrollByCodeResult']['EnrollInfo']['Enroll'];
    }

    return Result(true, data: responseData);

    /* if (responseData != null && responseData[0] == null) {
      localStorage.saveEnrolledGroupId(responseData['group_id']);
      localStorage.saveBlacklisted(responseData['blacklisted']);
      // String tranDate = responseData['trandate'];
      // String fees = responseData['fees_agree'];
      // String hours = responseData['hrs_agree'];
      // String additionalCharges = responseData['addhr_chrg'];
    } */
  }
}
