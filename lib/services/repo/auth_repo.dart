import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/api/model/login_model.dart';
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
      var params = LoginRequest(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: appConfig.caUid,
        caPwd: appConfig.caPwd,
        diCode: appConfig.diCode,
        userPhone: phone,
        userPwd: password,
        ipAddress: '0.0.0.0',
      );

      var response = await Networking.getInstance().login(params);
      xml2json.parse(response);
      var jsonData = xml2json.toParker();
      var data = json.decode(jsonData);

      print('data: $data');

      /* if (data.Table[0].msg == null) {
        localStorage.saveUserId(response.user_id.toString());
        // CrashReport().setUserIdentifier(response.user_id.toString());
        // CrashReport().setUserPhone(phone);

        checkDiList(response);

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

      var params = UserRegisteredDiRequest(
          wsCodeCrypt: appConfig.wsCodeCrypt,
          caUid: appConfig.caUid,
          caPwd: appConfig.caPwd,
          diCode: appConfig.diCode,
          userId: userId);

      var response = await Networking.getInstance().getUserRegisteredDi(params);
      xml2json.parse(response);
      var jsonData = xml2json.toParker();
      var data = json.decode(jsonData);

      print('data: $data');
    } catch (exception, stackTrace) {
      return handleError(exception, stackTrace);
    }
  }
}
