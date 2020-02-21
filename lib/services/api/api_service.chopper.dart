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
  Future<Response> getUserRegisteredDI(
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
  Future<Response> getUserByUserPhone(
      {String wsCodeCrypt, String caUid, String caPwd, String userPhone}) {
    final $url =
        '/webapi/GetUserByUserPhone?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&userPhone=$userPhone';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> register(RegisterRequest body) {
    final $url = '/webapi/CreateAppAccount';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
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
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> saveUserPassword(dynamic body) {
    final $url = '/webapi/SaveUserPassword';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getEnrollByCode(
      {String wsCodeCrypt,
      String caUid,
      String caPwd,
      String diCode,
      String icNo,
      String groupId}) {
    final $url =
        '/webapi/GetEnrollByCode?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&icNo=$icNo&groupId=$groupId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getCollectionByStudent(
      {String wsCodeCrypt,
      String caUid,
      String caPwd,
      String diCode,
      String icNo}) {
    final $url =
        '/webapi/GetCollectionByStudent?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&icNo=$icNo';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getDTestByCode(
      {String wsCodeCrypt,
      String caUid,
      String caPwd,
      String diCode,
      String icNo,
      String groupId}) {
    final $url =
        '/webapi/GetDTestByCode?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&icNo=$icNo&groupId=$groupId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getArmasterAppPhotoForCode(
      {String wsCodeCrypt,
      String caUid,
      String caPwd,
      String diCode,
      String userId}) {
    final $url =
        '/webapi/GetArmasterAppPhotoForCode?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&userId=$userId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getTheoryQuestionPaperNoWithCreditControl(
      {String wsCodeCrypt,
      String caUid,
      String caPwd,
      String diCode,
      String groupId,
      String courseCode,
      String langCode,
      String phone,
      String userId}) {
    final $url =
        '/webapi/GetTheoryQuestionPaperNoWithCreditControl?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&groupId=$groupId&courseCode=$courseCode&langCode=$langCode&phone=$phone&userId=$userId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getTheoryQuestionByPaper(
      {String wsCodeCrypt,
      String caUid,
      String caPwd,
      String groupId,
      String courseCode,
      String langCode,
      String paperNo}) {
    final $url =
        '/webapi/GetTheoryQuestionByPaper?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&groupId=$groupId&courseCode=$courseCode&langCode=$langCode&paperNo=$paperNo';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> pinActivation(PinRequest body) {
    final $url = '/webapi/PinActivation';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getDefaultSosContact(
      {String wsCodeCrypt, String caUid, String caPwd}) {
    final $url =
        '/webapi/GetDefaultSosContact?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getSosContact(
      {String wsCodeCrypt,
      String caUid,
      String caPwd,
      String sosContactType,
      String sosContactCode,
      String areaCode}) {
    final $url =
        '/webapi/GetSosContact?wsCodeCrypt=$wsCodeCrypt&caUid=$caUid&caPwd=$caPwd&sosContactType=$sosContactType&sosContactCode=$sosContactCode&areaCode=$areaCode';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> payFpx(dynamic body) {
    final $url = '/webapi/FPX_SendB2CAuthRequest';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
