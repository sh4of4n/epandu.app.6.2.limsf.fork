import 'package:epandu/services/api/model/auth_model.dart';

import 'local_storage.dart';
import 'package:flutter/material.dart';

class AppConfig {
  final LocalStorage localStorage = LocalStorage();
  String wsCodeCrypt = 'EPANDU';

  String caUid = 'epandu1_devp_3';
  String caPwd = 'wTA@D@cUHR&3Mq@\$';
  String caPwdUrlEncode = 'wTA%40D%40cUHR%263Mq%40%24';

  String diCode = 'TBS';

  getCredentials() async {
    // await localStorage.reset();
    String type = await localStorage.getServerType();

    if (type == 'DEVP') {
      caUid = 'epandu1_devp_3';
      caPwd = 'wTA@D@cUHR&3Mq@\$';
      caPwdUrlEncode = 'wTA%40D%40cUHR%263Mq%40%24';
    } else if (type == 'PROD') {
      caUid = 'epandu_prod';
      caPwd = 'vWh7SmgDRJ%TW4xa';
      caPwdUrlEncode = 'vWh7SmgDRJ%25TW4xa';
    }
  }

  /* static String getCaUid({@required String type}) {
    String caUid;

    if (type == 'DEVP')
      caUid = 'epandu1_devp_3';
    else if (type == 'PROD') caUid = 'epandu_prod';

    return caUid;
  }

  getCaPwd({@required String type}) {
    String caPwd;

    if (type == 'DEVP')
      caPwd = 'wTA@D@cUHR&3Mq@\$';
    else if (type == 'PROD') caPwd = 'wTA@D@cUHR&3Mq@\$';

    return caPwd;
  } */

  Future<String> getBaseUrl() async {
    String type = await localStorage.getServerType();
    String wsUrl = await localStorage.getWsUrl();
    String url;

    if (type == 'DEVP' && wsUrl.isEmpty)
      url =
          'http://tbsweb.tbsdns.com/ePandu.Mainservice/1_2/MainService.svc/webapi/';
    else if (type == 'PROD' && wsUrl.isEmpty)
      url = 'https://epandu.com/ePandu.MainService/1_2/MainService.svc/webapi/';
    else
      url = '$wsUrl/webapi/';

    return url;
  }
}
