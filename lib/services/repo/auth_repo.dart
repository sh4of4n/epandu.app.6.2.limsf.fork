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

  Future login(context, phone, password) async {
    var params =
        'GetUserByUserPhonePwd?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}&diCode=${appConfig.diCode}&userPhone=$phone&userPwd=$password&ipAddress=0.0.0.0';

    var response = await networking.getData(path: params);

    var responseData = response['GetUserByUserPhonePwdResponse']
        ['GetUserByUserPhonePwdResult']['UserInfo']['Table1'];

    if (responseData['msg'] == null) {
      print(responseData['userId']);
      print(responseData['sessionId']);

      localStorage.saveUserId(responseData['userId']);
      localStorage.saveSessionId(responseData['sessionId']);

      var result = await checkDiList();

      return result;
    } else {
      // throw Exception(responseData['msg']);

      return Result(false, message: responseData['msg']);
    }
  }

  Future<Result> checkDiList() async {
    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();

    var params =
        'GetUserRegisteredDI?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}&diCode=$diCode&userId=$userId';

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
  Future logout() async {
    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();
    String sessionId = await localStorage.getSessionId();

    var params =
        'IsSessionActive?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}&diCode=$diCode&userId=$userId&sessionId=$sessionId&isLogout=true';

    await localStorage.reset();
    await networking.getData(path: params);
  }

  // Register
  // Also used for invite friends
  Future<Result> checkExistingUser({
    context,
    String countryCode,
    String phone,
    String userId,
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
  }) async {
    String userPhone;
    String params;
    // String defPhone;

    if (countryCode.contains('60')) {
      if (phone.startsWith('0')) {
        userPhone = countryCode + phone.substring(1);
        // defPhone = phone.substring(1);
      } else {
        userPhone = countryCode + phone;
        // defPhone = phone;
      }
    }

    if (userId.isEmpty) userId = 'TBS';

    params =
        'GetUserByUserPhone?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}&userPhone=$userPhone';

    var response = await networking.getData(path: params);

    var responseData = response['GetUserByUserPhoneResponse']
        ['GetUserByUserPhoneResult']['UserInfo'];

    if (responseData == null) {
      // Number not registered
      var result = await register(
        context,
        countryCode,
        phone,
        userId,
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
      );

      return result;
    } else {
      return Result(false, message: responseData);
    }
  }

  Future<Result> register(context, countryCode, phone, userId, name, add1, add2,
      add3, postCode, city, state, country, email, icNo) async {
    /* String params = """{
      'wsCodeCrypt': '${appConfig.wsCodeCrypt}',
      'caUid': '${appConfig.caUid}',
      'caPwd': '${appConfig.caPwd}',
      'appCode': '',
      'diCode': '${appConfig.diCode}',
      'userId': $userId,
      'name': $name,
      'icNo': ${icNo ?? ''},
      'passportNo': '',
      'phoneCountryCode': $countryCode,
      'phone': $phone,
      'nationality': '',
      'dateOfBirthString': '',
      'gender': '',
      'race': '',
      'add1': '${add1 ?? ''}',
      'add2': '${add2 ?? ''}',
      'add3': '${add3 ?? ''}',
      'postcode': '${postCode ?? ''}',
      'city': '${city ?? ''}',
      'state': '${state ?? ''}',
      'country': '${country ?? ''}',
      'email': '${email ?? ''}',
    }"""; */

    RegisterRequest params = RegisterRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: appConfig.caUid,
      caPwd: appConfig.caPwd,
      appCode: '',
      diCode: appConfig.diCode,
      userId: userId,
      name: name,
      icNo: icNo ?? '',
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

    if (response != null) {
      return Result(true, data: response);
    }

    return Result(false, message: '');
  }
}
