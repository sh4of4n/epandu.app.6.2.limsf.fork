import 'local_storage.dart';

class AppConfig {
  final LocalStorage localStorage = LocalStorage();

  String wsCodeCrypt = 'EPANDU';

  String diCode = 'TBS';

  // Future<String> getBaseUrl() async {
  //   String wsUrl = await localStorage.getWsUrl();
  //   String url = '$wsUrl/webapi/';

  //   return url;
  // }
}
