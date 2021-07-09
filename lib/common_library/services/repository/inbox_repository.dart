import '../networking.dart';
import '../response.dart';
import '../../../utils/app_config.dart';
import '../../utils/local_storage.dart';
import '../model/inbox_model.dart';

class InboxRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Response> getNotificationListByUserId() async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwdEncode();
    String? userId = await localStorage.getUserId();
    String? lastMsgDoc = await localStorage.getMsgDoc();
    String? lastMsgRef = await localStorage.getMsgRef();
    String appId = appConfig.appId;

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&appId=$appId&userId=$userId&lastMsgDoc=$lastMsgDoc&lastMsgRef=$lastMsgRef';

    var response = await networking.getData(
      path: 'GetNotificationListByUserIdLastMsg?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetNotificationListByUserIdResponse getNotificationListByUserIdResponse;

      getNotificationListByUserIdResponse =
          GetNotificationListByUserIdResponse.fromJson(response.data);

      return Response(true, data: getNotificationListByUserIdResponse.table1);
    }

    return Response(false, message: 'No records found.');
  }

  Future<Response> getUnreadNotificationCount() async {
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwdEncode();
    String? userId = await localStorage.getUserId();
    String appId = appConfig.appId;
    String? lastMsgDoc = await localStorage.getMsgDoc();
    String? lastMsgRef = await localStorage.getMsgRef();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&appId=$appId&userId=$userId&lastMsgDoc=$lastMsgDoc&lastMsgRef=$lastMsgRef';

    var response = await networking.getData(
      path: 'GetUnreadNotificationCount?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetUnreadNotificationCountResponse getUnreadNotificationCountResponse;

      getUnreadNotificationCountResponse =
          GetUnreadNotificationCountResponse.fromJson(response.data);

      return Response(true, data: getUnreadNotificationCountResponse.msgCount);
    }

    return Response(false, message: 'No records found.');
  }
}
