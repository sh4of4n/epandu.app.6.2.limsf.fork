import 'dart:convert';
import '../../common_library/services/model/GetLeaveRoomResponse.dart';
import '../../common_library/services/model/createroom_response.dart';
import '../../common_library/services/model/invitefriend_model.dart';
import '../../common_library/services/model/inviteroom_model.dart';
import '../../common_library/services/model/inviteroom_response.dart';
import '../../common_library/services/model/leaveroom_model.dart';
import '../../common_library/services/model/m_room_model.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/services/model/response.dart';
import '../../common_library/services/networking.dart';
import '../../common_library/utils/local_storage.dart';
import '../../common_library/services//model/changegroupname_model.dart';
import '../../common_library/services//model/createroom_model.dart';
import '../../../utils/app_config.dart';

class ChatRoomRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Response> createChatSupportByMember() async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? merchantNo = await localStorage.getMerchantDbCode();
    String? mLoginId = await localStorage.getUserPhone();
    String? deviceId = await localStorage.getLoginDeviceId();

    CreateRoom params = CreateRoom(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: caUid,
        caPwd: caPwd,
        merchantNo: merchantNo,
        mLoginId: mLoginId,
        appId: appConfig.appId,
        deviceId: deviceId,
        appCode: appConfig.appCode);

    String body = jsonEncode(params);
    String api = 'CreateChatSupportByMember';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    // Success
    if (response.isSuccess && response.data != null) {
      GetCreateRoomResponse getCreateRoomResponse =
          GetCreateRoomResponse.fromJson(response.data);
      return Response(true, data: getCreateRoomResponse.room);
    }

    return Response(false,
        message: 'Failed to create room. Please try again later.');
  }

  Future<Response> createChatSupportByMemberFromWebView(
      String merchantNo) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();

    String? mLoginId = await localStorage.getUserPhone();
    String? deviceId = await localStorage.getLoginDeviceId();
    // String? userId = await localStorage.getUserId();
    // String? nickName = await localStorage.getNickName();

    CreateRoom params = CreateRoom(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: caUid,
        caPwd: caPwd,
        merchantNo: merchantNo,
        mLoginId: mLoginId,
        appId: appConfig.appId,
        deviceId: deviceId,
        appCode: appConfig.appCode);

    String body = jsonEncode(params);
    String api = 'CreateChatSupportByMember';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    // Success
    if (response.isSuccess && response.data != null) {
      GetCreateRoomResponse getCreateRoomResponse =
          GetCreateRoomResponse.fromJson(response.data);
      return Response(true, data: getCreateRoomResponse.room);
    }

    return Response(false,
        message: 'Failed to create room. Please try again later.');
  }

  Future<Response> getRoomList(String roomId) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? merchantNo = await localStorage.getMerchantDbCode();
    String? mLoginId = await localStorage.getUserPhone();
    String? appId = appConfig.appId;
    String? deviceId = await localStorage.getLoginDeviceId();
    String? appCode = appConfig.appCode;

    String path = 'wsCodeCrypt=${appConfig.wsCodeCrypt}' +
        '&caUid=$caUid' +
        '&caPwd=$caPwd' +
        '&merchantNo=$merchantNo' +
        '&mLoginId=$mLoginId' +
        '&appId=$appId' +
        '&deviceId=$deviceId' +
        '&roomId=$roomId' +
        '&appCode=$appCode';

    var response = await networking.getData(
      path: 'GetRoomByMember?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetRoomListResponse getRoomListResponse =
          GetRoomListResponse.fromJson(response.data);
      return Response(true, data: getRoomListResponse.roomlist);
    }

    return Response(false,
        message: 'Failed to load room list. Please try again later.');
  }

  Future<Response> getRoomMembersList(String roomId) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? merchantNo = await localStorage.getMerchantDbCode();
    String? mLoginId = await localStorage.getUserPhone();
    String? appId = appConfig.appId;
    //String? deviceId = await localStorage.getLoginDeviceId();
    String? appCode = appConfig.appCode;

    String path = 'wsCodeCrypt=${appConfig.wsCodeCrypt}' +
        '&caUid=$caUid' +
        '&caPwd=$caPwd' +
        '&merchantNo=$merchantNo' +
        '&loginId=$mLoginId' +
        '&appId=$appId' +
        // '&deviceId=$deviceId' +
        '&appCode=$appCode' +
        '&roomId=$roomId';
    var response = await networking.getData(
      path: 'GetMemberByRoom?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetRoomMemberListResponse getRoomMemberListResponse =
          GetRoomMemberListResponse.fromJson(response.data);

      return Response(true, data: getRoomMemberListResponse.roomMemberslist);
    }

    return Response(false,
        message: 'Failed to load room members list. Please try again later.');
  }

  Future<Response> getMemberByPhoneNumber(String phoneNumber) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? merchantNo = await localStorage.getMerchantDbCode();
    String? mLoginId = await localStorage.getUserPhone();
    String? appId = appConfig.appId;
    String? deviceId = await localStorage.getLoginDeviceId();
    String? appCode = appConfig.appCode;

    String path = 'wsCodeCrypt=${appConfig.wsCodeCrypt}' +
        '&caUid=$caUid' +
        '&caPwd=$caPwd' +
        '&merchantNo=$merchantNo' +
        '&mLoginId=$mLoginId' +
        '&appId=$appId' +
        '&deviceId=$deviceId' +
        '&appCode=$appCode' +
        '&phoneNumber=$phoneNumber';
    var response = await networking.getData(
      path: 'GetMemberByPhoneNumber?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetMemberByPhoneResponse getMemberByPhoneResponse =
          GetMemberByPhoneResponse.fromJson(response.data);

      return Response(true, data: getMemberByPhoneResponse.userProfile);
    }

    return Response(false,
        message: 'Failed to load friend data. Please try again later.');
  }

  Future<Response> chatWithMember(String phoneNumber) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? merchantNo = await localStorage.getMerchantDbCode();
    String? mLoginId = await localStorage.getUserPhone();

    InviteRoom params = InviteRoom(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: caUid,
        caPwd: caPwd,
        merchantNo: merchantNo,
        mLoginId: mLoginId,
        appId: appConfig.appId,
        appCode: appConfig.appCode,
        otherMLoginId: phoneNumber);

    String body = jsonEncode(params);
    String api = 'ChatWithMember';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    // Success
    if (response.isSuccess && response.data != null) {
      GetInviteRoomResponse getInviteRoomResponse =
          GetInviteRoomResponse.fromJson(response.data);
      return Response(true, data: getInviteRoomResponse.room);
    }

    return Response(false,
        message: 'Failed to invite friend. Please try again later');
  }

  Future<Response> createNewGroup(String phoneNumber, String roomName) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? merchantNo = await localStorage.getMerchantDbCode();
    String? mLoginId = await localStorage.getUserPhone();
    String? deviceId = await localStorage.getLoginDeviceId();
    InviteRoom params = InviteRoom(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: caUid,
        caPwd: caPwd,
        merchantNo: merchantNo,
        mLoginId: mLoginId,
        appId: appConfig.appId,
        deviceId: deviceId,
        appCode: appConfig.appCode,
        otherMLoginId: phoneNumber,
        roomName: roomName);

    String body = jsonEncode(params);
    String api = 'CreateNewGroup';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    // Success
    if (response.isSuccess && response.data != null) {
      GetInviteRoomResponse getInviteRoomResponse =
          GetInviteRoomResponse.fromJson(response.data);
      return Response(true, data: getInviteRoomResponse.room);
    }

    return Response(false,
        message: 'Failed to invite friend. Please try again later');
  }

  Future<Response> addMemberToGroup(String phoneNumber, String roomId) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? merchantNo = await localStorage.getMerchantDbCode();
    String? deviceId = await localStorage.getLoginDeviceId();
    String? mLoginId = await localStorage.getUserPhone();

    InviteRoom params = InviteRoom(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: caUid,
        caPwd: caPwd,
        merchantNo: merchantNo,
        mLoginId: mLoginId,
        appId: appConfig.appId,
        deviceId: deviceId,
        appCode: appConfig.appCode,
        otherMLoginId: phoneNumber,
        roomId: roomId);

    String body = jsonEncode(params);
    String api = 'addMemberToGroup';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    // Success
    if (response.isSuccess && response.data != null) {
      GetInviteRoomResponse getInviteRoomResponse =
          GetInviteRoomResponse.fromJson(response.data);
      return Response(true, data: getInviteRoomResponse.room);
    }

    return Response(false,
        message: 'Failed to invite friend. Please try again later');
  }

  Future<Response> changeGroupName(String roomId, String groupName) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? merchantNo = await localStorage.getMerchantDbCode();
    String? mLoginId = await localStorage.getUserPhone();
    String? deviceId = await localStorage.getLoginDeviceId();
    ChnageGroupNameRequest params = ChnageGroupNameRequest(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: caUid,
        caPwd: caPwd,
        merchantNo: merchantNo,
        mLoginId: mLoginId,
        appId: appConfig.appId,
        deviceId: deviceId,
        appCode: appConfig.appCode,
        roomId: roomId,
        groupName: groupName);

    String body = jsonEncode(params);
    String api = 'ChangeGroupName';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    // Success
    if (response.isSuccess && response.data != null) {
      GetInviteRoomResponse getInviteRoomResponse =
          GetInviteRoomResponse.fromJson(response.data);
      return Response(true, data: getInviteRoomResponse.room);
    }

    return Response(false,
        message: 'Failed to invite friend. Please try again later');
  }

  Future<Response> leaveRoom(String roomId) async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? merchantNo = await localStorage.getMerchantDbCode();
    String? mLoginId = await localStorage.getUserPhone();
    String? deviceId = await localStorage.getLoginDeviceId();

    LeaveRoom params = LeaveRoom(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: caUid,
        caPwd: caPwd,
        merchantNo: merchantNo,
        mLoginId: mLoginId,
        appId: appConfig.appId,
        deviceId: deviceId,
        appCode: appConfig.appCode,
        roomId: roomId);

    String body = jsonEncode(params);
    String api = 'LeaveRoom';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    // Success
    if (response.isSuccess && response.data != null) {
      GetLeaveRoomResponse getLeaveRoomResponse =
          GetLeaveRoomResponse.fromJson(response.data);
      return Response(true, data: getLeaveRoomResponse.room);
    }

    return Response(false,
        message: 'Failed to leave room. Please try again later.');
  }
}
