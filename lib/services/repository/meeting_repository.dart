import 'dart:convert';
import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/model/webinar_model.dart';

import '../../app_localizations.dart';

class ChatRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();
  //user ID = Dbcode

  Future<Response> getUserMeetingAccount({context}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String userID = await localStorage.getUserId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&dbcode=$userID&meetingTool=Zoom';

    var response = await networking.getData(
      path: 'GetUserMeetingAccount?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetUserMeetingAccountResponse getUserMeetingAccountResponse =
          GetUserMeetingAccountResponse.fromJson(response.data);

      print("get response message: " + response.message);

      return Response(true, data: getUserMeetingAccountResponse.zmMeetingUser);
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('no_records_found'));
  }

  Future<Response> saveUserMeetingAccount(
      {context, meetingUserId, personalMeetingId, refreshToken}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String userId = await localStorage.getUserId();

    SaveUserMeetingAccount savePickupRequest = SaveUserMeetingAccount(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: caUid,
        caPwd: caPwd,
        dbcode: userId,
        meetingTool: "Zoom",
        meetingUserID: meetingUserId,
        personalMeetingId: personalMeetingId,
        refrshToken: refreshToken);

    String body = jsonEncode(savePickupRequest);
    String api = 'SaveUserMeetingAccount';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    print("post response message: " + response.message);

    if (response.isSuccess && response.data == 'True') {
      return Response(true);
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: response.message.replaceAll(r'\u000d\u000a', ''));
  }

  Future<Response> saveMeeting(
      {context,
      meetingTool,
      meetingId,
      password,
      meetingUrl,
      meetingStatus,
      purpose,
      subject,
      description,
      meetingDateString,
      startTime,
      endTime,
      meetingSpeaker,
      meetingLanguage,
      banner,
      bannerBase64String,
      removeBanner,
      dataKey}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String userId = await localStorage.getUserId();

    SaveMeeting saveMeeting = SaveMeeting(
        wsCodeCrypt: appConfig.wsCodeCrypt,
        caUid: caUid,
        caPwd: caPwd,
        dbcode: userId,
        meetingTool: meetingTool,
        uuid: "",
        meetingId: meetingId,
        password: password,
        meetingUrl: meetingUrl,
        meetingUserId: "",
        meetingStatus: meetingStatus,
        purpose: purpose,
        subject: subject,
        description: description,
        meetingDateString: meetingDateString,
        startTime: startTime,
        endTime: endTime,
        meetingSpeaker: meetingSpeaker,
        meetingLanguage: meetingLanguage,
        audiences: "",
        fees: 0,
        banner: banner,
        bannerBase64String: bannerBase64String,
        removeBanner: removeBanner,
        dataKey: dataKey);

    String body = jsonEncode(saveMeeting);
    String api = 'SaveMeetingWithMeetingInfo';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess && response.data == 'True') {
      return Response(true);
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: response.message.replaceAll(r'\u000d\u000a', ''));
  }

  Future<Response> getMeetingByStatusResponse(
      {context,
      meetingTool,
      startIndex,
      noOfRecords,
      status,
      byStartTime,
      isAscending}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String userID = "";

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&dbcode=$userID&meetingTool=&meetingStatus=$status&startIndex=$startIndex&noOfRecords=$noOfRecords&byStartTime=$byStartTime&isAscending=$isAscending';

    var response = await networking.getData(
      path: 'GetMeetingByStatusWithDateSorting?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetMeetingByStatusResponse getMeetingByStatusResponse =
          GetMeetingByStatusResponse.fromJson(response.data);

      return Response(true, data: getMeetingByStatusResponse.zoomMeeting);
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('no_records_found'));
  }

  Future<Response> getUserRegisteredDI({context}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&diCode=$diCode&userId=$userId';

    var response = await networking.getData(
      path: 'GetUserRegisteredDI?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetUserRegisteredDIResponse getUserRegisteredDIResponse =
          GetUserRegisteredDIResponse.fromJson(response.data);

      return Response(true, data: getUserRegisteredDIResponse.zoomUser);
    } else if (response.message != null &&
        response.message.contains('timeout')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('timeout_exception'));
    } else if (response.message != null &&
        response.message.contains('socket')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('socket_exception'));
    } else if (response.message != null && response.message.contains('http')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('http_exception'));
    } else if (response.message != null &&
        response.message.contains('format')) {
      return Response(false,
          message: AppLocalizations.of(context).translate('format_exception'));
    }

    return Response(false,
        message: AppLocalizations.of(context).translate('no_records_found'));
  }
}
