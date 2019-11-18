import 'preferences.dart';

class LocalStorage {
  static const String kUserId = 'USER_ID';

  Future<void> saveUserId(String userId) {
    return Preference.setString(kUserId, userId);
  }

  Future<String> getUserId() async {
    return Preference.getString(kUserId, def: '');
  }

  Future<void> reset() async {
    await Preference.removeAll();
  }
}
