import '../networking.dart';
import '../response.dart';
import '../../../utils/app_config.dart';
import '../../utils/local_storage.dart';
import '../model/inbox_model.dart';

class InboxRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Response> getNotificationListByUserId({context}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String userId = await localStorage.getUserId();
    String appId = appConfig.appId;

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&appId=$appId&userId=$userId';

    var response = await networking.getData(
      path: 'GetNotificationListByUserId?$path',
    );

    if (response.isSuccess && response.data != null) {
      GetNotificationListByUserIdResponse getNotificationListByUserIdResponse;

      getNotificationListByUserIdResponse =
          GetNotificationListByUserIdResponse.fromJson(response.data);

      return Response(true,
          data: getNotificationListByUserIdResponse.msgOutbox);
    }

    return Response(false, message: 'No records found.');
  }
}
