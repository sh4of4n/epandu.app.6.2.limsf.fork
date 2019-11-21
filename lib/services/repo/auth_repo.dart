import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/api/model/auth_model.dart';
import 'package:epandu/services/repo/base_repo.dart';
import 'package:epandu/services/result.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

class AuthRepo extends BaseRepo {
  final appConfig = AppConfig();
  final xml2json = Xml2Json();
  final localStorage = LocalStorage();

  Future<Result> login(context, phone, password) async {
    try {
      /* var params = LoginRequest(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: appConfig.caUid,
        caPwd: appConfig.caPwd,
        diCode: appConfig.diCode,
        userPhone: phone,
        userPwd: password,
        ipAddress: '0.0.0.0',
      ); */

      var params =
          'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}&diCode=${appConfig.diCode}&userPhone=$phone&userPwd=$password&ipAddress=0.0.0.0';

      var response = await Networking.getInstance().login(params);
      xml2json.parse(response.toString());
      var jsonData = xml2json.toParker();
      var data = json.decode(jsonData);

      return Result(true, data: data);
      // print('response: $response');
      // print('data: $data');

      /* if (data.Table[0].msg == null) {
        // localStorage.saveUserId(response.user_id.toString());
        // CrashReport().setUserIdentifier(response.user_id.toString());
        // CrashReport().setUserPhone(phone);

        // checkDiList(response);

        return Result(true, data: response);
      } else {
        return Result(false, message: data.Table[0].msg);
      } */
    } catch (exception, stackTrace) {
      return handleError(exception, stackTrace);
    }
  }

  Future<Result> checkDiList(loginResponse) async {
    try {
      String userId = await localStorage.getUserId();

      /* var params = UserRegisteredDiRequest(
          wsCodeCrypt: appConfig.wsCodeCrypt,
          caUid: appConfig.caUid,
          caPwd: appConfig.caPwd,
          diCode: appConfig.diCode,
          userId: userId); */

      var params =
          'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}&diCode=${appConfig.diCode}&userId=$userId';

      var response = await Networking.getInstance().getUserRegisteredDi(params);
      xml2json.parse(response.toString());
      var jsonData = xml2json.toParker();
      var data = json.decode(jsonData);

      print('response: $response');
      print('data: $data');
    } catch (exception, stackTrace) {
      return handleError(exception, stackTrace);
    }
  }

  // Register
  Future<Result> checkExistingUser(
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
  ) async {
    try {
      String userPhone;
      String params;
      String defPhone;

      if (countryCode.includes('60')) {
        if (phone.startsWith('0')) {
          userPhone = countryCode + phone.substring(1);
          defPhone = phone.substring(1);
        } else {
          userPhone = countryCode + phone;
          defPhone = phone;
        }
      }

      params =
          'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${appConfig.caUid}&caPwd=${appConfig.caPwdUrlEncode}&userPhone=$userPhone';

      var response = await Networking.getInstance().checkExistingUser(params);
      xml2json.parse(response.toString());
      var jsonData = xml2json.toParker();
      var data = json.decode(jsonData);

      print('response: $response');
      print('data: $data');

      // response returns null
    } catch (exception, stackTrace) {
      return handleError(exception, stackTrace);
    }
  }

  Future<Result> register(
    context,
    countryCode,
    phone,
    userId,
    name,
    add1,
    add2,
    add3,
    postCode,
    city,
    state,
    country,
    email,
  ) async {
    try {
      var params = RegisterRequest(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: appConfig.caUid,
        caPwd: appConfig.caPwd,
        appCode: '',
        diCode: appConfig.diCode,
        userId: userId,
        name: name,
        icNo: '',
        passportNo: '',
        phoneCountryCode: countryCode,
        phone: phone,
        nationality: '',
        dateOfBirthString: '',
        gender: '',
        race: '',
        add1: add1,
        add2: add2,
        add3: add3,
        postcode: postCode,
        city: city,
        state: state,
        country: country,
        email: email,
      );

      var response = await Networking.getInstance().register(params);
      xml2json.parse(response.toString());
      var jsonData = xml2json.toParker();
      var data = json.decode(jsonData);

      print('response: $response');
      print('data: $data');
      // response returns User ID
    } catch (exception, stackTrace) {
      return handleError(exception, stackTrace);
    }
  }
}
