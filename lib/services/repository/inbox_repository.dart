import 'package:epandu/services/api/networking.dart';
import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/model/inbox_model.dart';

import '../../app_localizations.dart';

class InboxRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  Future<Response> getNotificationListByUserId({context}) async {
    String caUid = await localStorage.getCaUid();
    String caPwd = await localStorage.getCaPwdEncode();
    String userId = await localStorage.getUserId();

    String path =
        'wsCodeCrypt=${appConfig.wsCodeCrypt}&caUid=$caUid&caPwd=$caPwd&appId=ePandu.App&userId=$userId';

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

    return Response(false,
        message: AppLocalizations.of(context).translate('no_records_found'));
  }
}
