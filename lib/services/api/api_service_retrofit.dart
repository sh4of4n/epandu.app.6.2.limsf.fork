/* import 'dart:convert';
import 'package:epandu/utils/request_log.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import 'model/auth_model.dart';
import 'model/kpp_model.dart';

part 'api_service_retrofit.g.dart';

@RestApi(baseUrl: '/webapi/')
abstract class ApiServiceRetrofit {
  factory ApiServiceRetrofit(Dio dio, {String baseUrl}) = _ApiServiceRetrofit;
  static ApiServiceRetrofit create() {
    var dio = Dio();
    dio.options.baseUrl = Hive.box('ws_url').get('wsUrl');
    dio.interceptors.add(
        LogInterceptor(responseBody: true, requestHeader: true, error: true));
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (Response response) {
          if (response.data != null && response.data is String) {
            response.data = jsonDecode(response.data);
          }
          return response;
        },
        onRequest: (RequestOptions options) {
          if (options.data != null) {
            RequestLog.printWrapped(
                'Request params: ' + jsonEncode(options.data));
          }
        },
        onError: (DioError e) async {
          return e;
        },
      ),
    );

    return ApiServiceRetrofit(dio);
  }

  // auth_repo
  @GET(
      'GetUserByUserPhonePwd?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&userPhone={userPhone}&userPwd={userPwd}&ipAddress={ipAddress}')
  Future<LoginResponse> login({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('userPhone') String userPhone,
    @Path('userPwd') String userPwd,
    @Path('ipAddress') String ipAddress,
  });

  @GET(
      'GetUserRegisteredDI?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&userId={userId}')
  Future<UserRegisteredDiResponse> getUserRegisteredDI({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('userId') String userId,
  });

  @GET(
      'IsSessionActive?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&userId={userId}&sessionId={sessionId}&isLogout={isLogout}')
  Future<void> logout({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('userId') String userId,
    @Path('sessionId') String sessionId,
    @Path('isLogout') String isLogout,
  });

  @GET(
      'GetUserByUserPhone?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&userPhone={userPhone}')
  Future<HttpResponse> getUserByUserPhone({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('userPhone') String userPhone,
  });

  @POST('CreateAppAccount')
  Future<HttpResponse> register(@Body() RegisterRequest body);

  @GET(
      'GetUserByUserIdPwd?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&userId={userId}&userPwd={userPwd}')
  Future<HttpResponse> verifyOldPassword({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('userId') String userId,
    @Path('userPwd') String userPwd,
  });

  @POST('SaveUserPassword')
  Future<HttpResponse> saveUserPassword(@Body() SaveUserPasswordRequest body);
  // end auth_repo

  // profile_repo
  @GET(
      'GetEnrollByCode?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&icNo={icNo}&groupId={groupId}')
  Future<HttpResponse> getEnrollByCode({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('icNo') String icNo,
    @Path('groupId') String groupId,
  });

  /* @GET(
      
          'GetStuPracByCode?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&icNo={icNo}&groupId={groupId}')
  Future<Response> getEnrolledClasses({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('icNo') String icNo,
    @Path('groupId') String groupId,
  }); */

  @GET(
      'GetCollectionByStudent?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&icNo={icNo}')
  Future<HttpResponse> getCollectionByStudent({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('icNo') String icNo,
  });

  @GET(
      'GetDTestByCode?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&icNo={icNo}&groupId={groupId}')
  Future<HttpResponse> getDTestByCode({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('icNo') String icNo,
    @Path('groupId') String groupId,
  });
  // end profile_repo

  // kpp_repo
  @GET(
      'GetArmasterAppPhotoForCode?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&userId={userId}')
  Future<HttpResponse> getArmasterAppPhotoForCode({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('userId') String userId,
  });

  @GET(
      'GetTheoryQuestionPaperNoWithCreditControl?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&groupId={groupId}&courseCode={courseCode}&langCode={langCode}&phone={phone}&userId={userId}')
  Future<HttpResponse> getTheoryQuestionPaperNoWithCreditControl({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('groupId') String groupId,
    @Path('courseCode') String courseCode,
    @Path('langCode') String langCode,
    @Path('phone') String phone,
    @Path('userId') String userId,
  });

  @GET(
      'GetTheoryQuestionByPaper?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&groupId={groupId}&courseCode={courseCode}&langCode={langCode}&paperNo={paperNo}')
  Future<HttpResponse> getTheoryQuestionByPaper({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('groupId') String groupId,
    @Path('courseCode') String courseCode,
    @Path('langCode') String langCode,
    @Path('paperNo') String paperNo,
  });

  @POST('PinActivation')
  Future<HttpResponse> pinActivation(@Body() PinRequest body);
  // end kpp_repo

  // emergency_repo
  @GET(
      'GetDefaultSosContact?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}')
  Future<HttpResponse> getDefaultSosContact({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
  });

  @GET(
      'GetSosContact?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&sosContactType={sosContactType}&sosContactCode={sosContactCode}&areaCode={areaCode}')
  Future<HttpResponse> getSosContact({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('sosContactType') String sosContactType,
    @Path('sosContactCode') String sosContactCode,
    @Path('areaCode') String areaCode,
  });
  // end emergency_repo

  @POST('FPX_SendB2CAuthRequest')
  Future<HttpResponse> payFpx(@Body() var body);
}
 */
