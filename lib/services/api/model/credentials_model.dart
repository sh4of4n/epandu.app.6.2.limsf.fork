import 'package:flutter/material.dart';

class CredentialsModel extends ChangeNotifier {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String caPwdUrlEncode;

  void setCredentials({
    String codeCrypt,
    String accId,
    String accPwd,
    String accPwdUrlEncode,
  }) {
    wsCodeCrypt = codeCrypt;
    caUid = accId;
    caPwd = accPwd;
    caPwdUrlEncode = accPwdUrlEncode;

    notifyListeners();
  }
}
