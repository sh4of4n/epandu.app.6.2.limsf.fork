import 'package:chopper/chopper.dart';
import 'package:epandu/services/api/model/auth_model.dart';
import 'package:hive/hive.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '/webapi/')
abstract class ApiService extends ChopperService {
  static ApiService create() {
    final wsUrlBox = Hive.box('ws_url');

    final client = ChopperClient(
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
            chopperLogger.severe('${response.statusCode}');
          }
          return response;
        },
      ],
    );

    // The generated class with the ChopperClient passed in
    return _$ApiService(client);
  }

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
  Future<Response> checkDiList({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('userId') String userId,
  });

  @Get(
      path:
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

  @Get(
      path:
          'GetUserByUserPhone?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&userPhone={userPhone}')
  Future<Response> checkExistingUser({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('userPhone') String userPhone,
  });

  @Post(
    path: 'CreateAppAccount',
    headers: {'Content-Type': 'application/json'},
  )
  Future<Response> register(@Body() RegisterRequest body);

  @Get(
    path:
        'GetUserByUserIdPwd?wsCodeCrypt={wsCodeCrypt}&caUid={caUid}&caPwd={caPwd}&diCode={diCode}&userId={userId}&userPwd={userPwd}',
    headers: {'Content-Type': 'application/json'},
  )
  Future<Response> verifyOldPassword({
    @Path('wsCodeCrypt') String wsCodeCrypt,
    @Path('caUid') String caUid,
    @Path('caPwd') String caPwd,
    @Path('diCode') String diCode,
    @Path('userId') String userId,
    @Path('userPwd') String userPwd,
  });

  @Post(path: 'SaveUserPassword')
  Future<Response> updatePassword(@Body() UpdatePasswordRequest body);
}
