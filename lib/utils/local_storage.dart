import 'preferences.dart';

class LocalStorage {
  static const String kUserId = 'USER_ID';
  static const String kDiCode = 'DI_CODE';
  static const String kSessionId = 'SESSION_ID';

  Future<void> saveUserId(String userId) {
    return Preference.setString(kUserId, userId);
  }

  Future<String> getUserId() async {
    return Preference.getString(kUserId, def: '');
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
