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

      return Result(true, data: responseData['Armaster']);
    }
    // API returns more than one DI
    else if (responseData != null && responseData['Armaster'][0] != null) {
      localStorage.saveUsername(responseData['Armaster'][0]['name'].toString());
      localStorage.saveUserPhone(responseData['Armaster'][0]
              ['phone_country_code'] +
          responseData['Armaster'][0]['phone'].toString());
      localStorage.saveEmail(responseData['Armaster'][0]['e_mail'].toString());

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

  /* // Register
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
  } */
}
