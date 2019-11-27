import 'preferences.dart';

class LocalStorage {
  static const String kUserId = 'USER_ID';
  static const String kUsername = 'USERNAME';
  static const String kUserPhone = 'USER_PHONE';
  static const String kEmail = 'EMAIL';
  static const String kDiCode = 'DI_CODE';
  static const String kSessionId = 'SESSION_ID';

  Future<void> saveUserId(String userId) {
    return Preference.setString(kUserId, userId);
  }

  Future<String> getUserId() async {
    return Preference.getString(kUserId, def: '');
  }

  Future<void> saveUsername(String username) {
    return Preference.setString(kUsername, username);
  }

  Future<String> getUsername() async {
    return Preference.getString(kUsername, def: '');
  }

  Future<void> saveUserPhone(String userPhone) {
    return Preference.setString(kUserPhone, userPhone);
  }

  Future<String> getUserPhone() async {
    return Preference.getString(kUserPhone, def: '');
  }

  Future<void> saveEmail(String email) {
    return Preference.setString(kEmail, email);
  }

  Future<String> getEmail() async {
    return Preference.getString(kEmail, def: '');
  }

  Future<void> saveDiCode(String diCode) async {
    return Preference.setString(kDiCode, diCode);
  }

  Future<String> getDiCode() async {
    return Preference.getString(kDiCode, def: '');
  }

  Future<void> saveSessionId(String sessionId) async {
    return Preference.setString(kSessionId, sessionId);
  }

  Future<String> getSessionId() async {
    return Preference.getString(kSessionId, def: '');
  }

  Future<void> reset() async {
    await Preference.removeAll();
  }
}
