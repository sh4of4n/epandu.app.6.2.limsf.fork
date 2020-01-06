import 'package:epandu/services/response.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/services/api/networking.dart';

class EmergencyRepo {
  final appConfig = AppConfig();
  final localStorage = LocalStorage();
  final networking = Networking();

  // GetDefaultSosContact
  Future<Response> getDefEmergencyContact() async {}
  // GetSosContact
  Future<Response> getEmergencyContact() async {}
}
