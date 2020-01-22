import 'local_storage.dart';

class AppConfig {
  final LocalStorage localStorage = LocalStorage();

  String wsCodeCrypt = 'EPANDU';

  String diCode = 'TBS';

  String businessTypePass = 'visa2u';

  String eWalletUrl =
      'https://tbsweb.tbsdns.com/eCarser.WebService/1_9/MemberService.asmx/';

  String eWalletCaUid = 'visa2u1';
  String eWalletCaPwd = 'visa2u';
}
