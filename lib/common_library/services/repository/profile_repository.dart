import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/profile_model.dart';
import '../networking.dart';
import '../response.dart';
import '../../../utils/app_config.dart';
import '../../utils/local_storage.dart';

class ProfileRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Response> getUserProfile({context, customUserId}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String userId = await localStorage.getUserId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&appCode=${appConfig.appCode}&appId=${appConfig.appId}&userId=${customUserId ?? userId}';

    var response = await networking.getData(
      path: 'GetUserProfile?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetUserProfileResponse getUserProfileResponse =
          GetUserProfileResponse.fromJson(response.data);
      var responseData = getUserProfileResponse.userProfile;

      return Response(true, data: responseData);
    }

    return Response(false,
        message: 'Failed to load profile. Please try again later.');
  }

  Future<Response> saveUserProfile({
    context,
    String name,
    String address,
    String postcode,
    String state,
    String country,
    String email,
    String registerAs,
    String icNo,
    String nationality,
    String dateOfBirthString,
    String gender,
    String race,
    String nickName,
    List<int> userProfileImage,
    String userProfileImageBase64String,
    bool removeUserProfileImage,
    @required String enqLdlGroup,
    @required String cdlGroup,
    String langCode,
    @required bool findDrvJobs,
  }) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String diCode = await localStorage.getDiCode();
    String userId = await localStorage.getUserId();

    SaveProfileRequest params = SaveProfileRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      appCode: appConfig.appCode,
      appId: appConfig.appId,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode ?? appConfig.diCode,
      userId: userId,
      name: name,
      nickName: nickName ?? '',
      icNo: icNo ?? '',
      nationality: nationality ?? 'WARGANEGARA',
      dateOfBirthString: dateOfBirthString ?? '',
      gender: gender ?? '',
      race: race ?? '',
      address: address ?? '',
      postcode: postcode ?? '',
      state: state ?? '',
      country: country ?? '',
      email: email ?? '',
      userProfileImage: userProfileImage,
      userProfileImageBase64String: userProfileImageBase64String ?? '',
      removeUserProfileImage: removeUserProfileImage ?? false,
      enqLdlGroup: enqLdlGroup,
      cdlGroup: cdlGroup,
      langCode: langCode ?? 'en-MY',
      findDrvJobs: findDrvJobs, //bool set to false
    );

    String body = jsonEncode(params);
    String api = 'SaveUserProfileWithIC';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    // Success
    if (response.isSuccess && response.data != null) {
      localStorage.saveBirthDate(dateOfBirthString ?? '');
      localStorage.saveStudentIc(icNo ?? '');
      localStorage.saveName(name ?? '');
      localStorage.saveEmail(email ?? '');
      localStorage.savePostCode(postcode ?? '');
      localStorage.saveNickName(nickName ?? '');

      return Response(true, message: 'Profile updated successfully.');
    }

    return Response(false,
        message: 'Failed to update profile. Please try again later.');
  }

  Future getTrainerList() async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String merchantNo = await localStorage.getMerchantDbCode();
    // String phoneCountryCode = await localStorage.getCountryCode();
    // String phone = await localStorage.getUserPhone();
    // String loginId = (phoneCountryCode + phone).replaceAll('+6', '');

    String path = 'wsCodeCrypt=${appConfig.wsCodeCrypt}' +
        '&caUid=$caUid' +
        '&caPwd=$caPwd' +
        '&diCode=$merchantNo';

    var response = await networking.getData(
      path: 'GetTrainerList?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetTrainerListResponse getTrainerListResponse =
          GetTrainerListResponse.fromJson(response.data);

      return Response(true, data: getTrainerListResponse.trainer);
    }

    return Response(false,
        message: 'Failed to load trainer list. Please try again later.');
  }

  Future getVehicleList() async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();
    String merchantNo = await localStorage.getMerchantDbCode();
    // String phoneCountryCode = await localStorage.getCountryCode();
    // String phone = await localStorage.getUserPhone();
    // String loginId = (phoneCountryCode + phone).replaceAll('+6', '');

    String path = 'wsCodeCrypt=${appConfig.wsCodeCrypt}' +
        '&caUid=$caUid' +
        '&caPwd=$caPwd' +
        '&diCode=$merchantNo';

    var response = await networking.getData(
      path: 'GetVehicleList?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetVehicleListResponse getVehicleListResponse =
          GetVehicleListResponse.fromJson(response.data);

      return Response(true, data: getVehicleListResponse.vehicle);
    }

    return Response(false,
        message: 'Failed to load vehicle list. Please try again later.');
  }

  /* Future getStudentProfile() async {
    String userId = await localStorage.getUserId();
    String diCode = await localStorage.getDiCode();

    String params =
        'GetUserRegisteredDI?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${credentials.caUid}&caPwd=${credentials.caPwdUrlEncode}&diCode=$diCode&userId=$userId';

    var response = await networking.getData(path: params);
  }

  Future getStudentProfilePicture() async {} */

  // already obtained from getUserRegisteredDi
  /* Future<Response> getCustomerData() async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    //  Temporarily use TBS as diCode
    String diCode = appConfig.diCode;
    // String diCode = await localStorage.getDiCode();
    String icNo = await localStorage.getStudentIc();

    Map<String, String> param = {
      'wsCodeCrypt': appConfig.wsCodeCrypt,
      'caUid': caUid,
      'caPwd': caPwd,
      'diCode': diCode,
      'icNo': icNo,
    };

    String method = 'GetCustomerByCode';

    var response = await networking.getData(method: method, param: param);

    var responseData = response.data;
  } */

  // now using GetEnrollByCode
  /* Future<Response> getEnrolledClasses() async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwd();

    //  Temporarily use TBS as diCode
    String diCode = appConfig.diCode;
    // String diCode = await localStorage.getDiCode();
    String groupId = await localStorage.getEnrolledGroupId();
    String icNo = await localStorage.getStudentIc();

    EnrolledClassesRequest enrolledClassesRequest = EnrolledClassesRequest(
      wsCodeCrypt: appConfig.wsCodeCrypt,
      caUid: caUid,
      caPwd: caPwd,
      diCode: diCode,
      icNo: icNo,
      groupId: groupId,
    );

    Map<String, String> param = enrolledClassesRequest.toJson();

    String method = 'GetStuPracByCode';

    var response = await networking.getData(method: method, param: param);

    Map<String, dynamic> classesData;

    String encodeData;
    String processedData;
    var decodedData;

    EnrolledClassesResponse enrolledClassesResponse;

    if (response.isSuccess) {
      if (response.data != null &&
          response.data['GetStuPracByCodeResponse']['GetStuPracByCodeResult']
                  ['StuPracInfo'] !=
              null) {
        //  if response.data is not a list of object
        if (response.data['GetStuPracByCodeResponse']['GetStuPracByCodeResult']
                ['StuPracInfo']['StuPrac'][0] ==
            null) {
          classesData = response.data['GetStuPracByCodeResponse']
              ['GetStuPracByCodeResult']['StuPracInfo']['StuPrac'];

          encodeData = '{"StuPrac": [${jsonEncode(classesData)}]}';
          processedData = encodeData.replaceAll('null', '""');
          decodedData = jsonDecode(processedData);
        }
        // if response.data is a list of object
        else {
          decodedData = response.data['GetStuPracByCodeResponse']
              ['GetStuPracByCodeResult']['StuPracInfo'];
        }

        enrolledClassesResponse = EnrolledClassesResponse.fromJson(decodedData);

        return Response(true, data: enrolledClassesResponse.stuPrac);
      }
    }

    return Response(false);
  } */

/*   Future<Response> getStudentEtestingLog() async {
    String params =
        'GetStudentFullLogByCode?wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=${credentials.caUid}&caPwd=${credentials.caPwdUrlEncode}';

    var response = await networking.getData(path: params);

    var responseData = response;
  } */
}
