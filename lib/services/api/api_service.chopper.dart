// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ApiService extends ApiService {
  _$ApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ApiService;

  @override
  Future<Response> login(
      {String wsCodeCrypt,
      String caUid,
      String caPwd,
      String diCode,
      String userPhone,
      String userPwd,
      String ipAddress}) {
    final $url =
        '/webapi/GetUserByUserPhonePwd?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&userPhone=$userPhone&userPwd=$userPwd&ipAddress=$ipAddress';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> checkDiList(
      {String wsCodeCrypt,
      String caUid,
      String caPwd,
      String diCode,
      String userId}) {
    final $url =
        '/webapi/GetUserRegisteredDI?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&userId=$userId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<void> logout(
      {String wsCodeCrypt,
      String caUid,
      String caPwd,
      String diCode,
      String userId,
      String sessionId,
      String isLogout}) {
    final $url =
        '/webapi/IsSessionActive?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&userId=$userId&sessionId=$sessionId&isLogout=$isLogout';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send($request);
  }

  @override
  Future<Response> checkExistingUser(
      {String wsCodeCrypt, String caUid, String caPwd, String userPhone}) {
    final $url =
        '/webapi/GetUserByUserPhone?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&userPhone=$userPhone';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> register(RegisterRequest body) {
    final $url = '/webapi/CreateAppAccount';
    final $headers = {'Content-Type': 'application/json'};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> verifyOldPassword(
      {String wsCodeCrypt,
      String caUid,
      String caPwd,
      String diCode,
      String userId,
      String userPwd}) {
    final $url =
        '/webapi/GetUserByUserIdPwd?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&userId=$userId&userPwd=$userPwd';
    final $headers = {'Content-Type': 'application/json'};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> updatePassword(UpdatePasswordRequest body) {
    final $url = '/webapi/SaveUserPassword';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
