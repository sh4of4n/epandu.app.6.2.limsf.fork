import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:epandu/services/api/model/auth_model.dart';
import 'package:hive/hive.dart';

import 'model/kpp_model.dart';
import 'package:http/io_client.dart' as http;

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '/webapi/')
abstract class ApiService extends ChopperService {
  static ApiService create() {
    final wsUrlBox = Hive.box('ws_url');

    final client = ChopperClient(
      // client: http.IOClient(
      //   HttpClient()..connectionTimeout = const Duration(seconds: 1),
      // ),
      // The first part of the URL is now here
      baseUrl: wsUrlBox.get('wsUrl'),
      services: [
        // The generated implementation
        _$ApiService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
      interceptors: [
        HeadersInterceptor({'Cache-Control': 'no-cache'}),
        HttpLoggingInterceptor(),
        CurlInterceptor(),
        (Request request) async {
          if (request.method == HttpMethod.Post) {
            chopperLogger.info('Performed a POST request');
          } else if (request.method == HttpMethod.Get) {
            chopperLogger.info('Performed a GET request');
          }
          return request;
        },
        (Response response) async {
          if (response.statusCode != 200) {
            chopperLogger
                .severe('log: ${response.statusCode} ${response.error}');
          }
          return response;
        },
      ],
    );

    // The generated class with the ChopperClient passed in
    return _$ApiService(client);
  }

  // auth_repo
  @Get(
      path:
          'GetUserByUserPhonePwd?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&userPhone={userPhone}&userPwd={userPwd}&ipAddress={ipAddress}')
  Future<Response> login({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('userPhone') String userPhone,
    @Path('userPwd') String userPwd,
    @Path('ipAddress') String ipAddress,
  });

  @Get(
      path:
          'GetUserRegisteredDI?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&userId={userId}')
  Future<Response> getUserRegisteredDI({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('userId') String userId,
  });

  @Get(
      path:
          'IsSessionActive?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&userId={userId}&sessionId={sessionId}&isLogout={isLogout}')
  Future<Response> logout({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('userId') String userId,
    @Path('sessionId') String sessionId,
    @Path('isLogout') String isLogout,
  });

  @Get(
      path:
          'GetUserByUserPhone?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&userPhone={userPhone}')
  Future<Response> getUserByUserPhone({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('userPhone') String userPhone,
  });

  @Post(path: 'CreateAppAccount')
  Future<Response> register(@Body() RegisterRequest body);

  @Get(
      path:
          'GetUserByUserIdPwd?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&userId={userId}&userPwd={userPwd}')
  Future<Response> verifyOldPassword({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('userId') String userId,
    @Path('userPwd') String userPwd,
  });

  @Post(path: 'SaveUserPassword')
  Future<Response> saveUserPassword(@Body() SaveUserPasswordRequest body);
  // end auth_repo

  // profile_repo
  @Get(
      path:
          'GetEnrollByCode?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&icNo={icNo}&groupId={groupId}')
  Future<Response> getEnrollByCode({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('icNo') String icNo,
    @Path('groupId') String groupId,
  });

  /* @Get(
      path:
          'GetStuPracByCode?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&icNo={icNo}&groupId={groupId}')
  Future<Response> getEnrolledClasses({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('icNo') String icNo,
    @Path('groupId') String groupId,
  }); */

  @Get(
      path:
          'GetCollectionByStudent?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&icNo={icNo}')
  Future<Response> getCollectionByStudent({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('icNo') String icNo,
  });

  @Get(
      path:
          'GetDTestByCode?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&icNo={icNo}&groupId={groupId}')
  Future<Response> getDTestByCode({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('icNo') String icNo,
    @Path('groupId') String groupId,
  });
  // end profile_repo

  // kpp_repo
  @Get(
      path:
          'GetArmasterAppPhotoForCode?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&userId={userId}')
  Future<Response> getArmasterAppPhotoForCode({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('userId') String userId,
  });

  @Get(
      path:
          'GetTheoryQuestionPaperNoWithCreditControl?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&groupId={groupId}&courseCode={courseCode}&langCode={langCode}&phone={phone}&userId={userId}')
  Future<Response> getTheoryQuestionPaperNoWithCreditControl({
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

  @Get(
      path:
          'GetTheoryQuestionByPaper?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&groupId={groupId}&courseCode={courseCode}&langCode={langCode}&paperNo={paperNo}')
  Future<Response> getTheoryQuestionByPaper({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('groupId') String groupId,
    @Path('courseCode') String courseCode,
    @Path('langCode') String langCode,
    @Path('paperNo') String paperNo,
  });

  @Post(path: 'PinActivation')
  Future<Response> pinActivation(@Body() PinRequest body);
  // end kpp_repo

  // emergency_repo
  @Get(
      path:
          'GetDefaultSosContact?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}')
  Future<Response> getDefaultSosContact({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
  });

  @Get(
      path:
          'GetSosContact?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&sosContactType={sosContactType}&sosContactCode={sosContactCode}&areaCode={areaCode}')
  Future<Response> getSosContact({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('sosContactType') String sosContactType,
    @Path('sosContactCode') String sosContactCode,
    @Path('areaCode') String areaCode,
  });

  @Get(
      path:
          'GetSosContactSortByNearest?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&sosContactType={sosContactType}&sosContactCode={sosContactCode}&areaCode={areaCode}&latitude={latitude}&longitude={longitude}&maxRadius={maxRadius}')
  Future<Response> getSosContactSortByNearest({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('sosContactType') String sosContactType,
    @Path('sosContactCode') String sosContactCode,
    @Path('areaCode') String areaCode,
    @Path('latitude') String latitude,
    @Path('longitude') String longitude,
    @Path('maxRadius') String maxRadius,
  });
  // end emergency_repo

  @Post(path: 'FPX_SendB2CAuthRequest')
  Future<Response> payFpx(@Body() var body);

  // enrollment

  @Get(path: 'GetDiList?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}')
  Future<Response> getDiList({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
  });

  @Get(
      path:
          'GetGroupIdByDiCodeForOnline?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}')
  Future<Response> getGroupIdByDiCodeForOnline({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
  });

  @Post(path: 'SaveEnrollmentWithParticular')
  Future<Response> saveEnrollmentWithParticular(@Body() var body);
}
