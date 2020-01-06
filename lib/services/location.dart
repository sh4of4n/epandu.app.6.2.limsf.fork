import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class Location {
  final geolocator = Geolocator();
  final locationOptions = LocationOptions(
    accuracy: LocationAccuracy.medium,
    distanceFilter: 200,
  );
  double latitude;
  double longitude;
  String address;
  String places;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);

      latitude = position.latitude;
      longitude = position.longitude;

      await getAddress(latitude, longitude);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAddress(double lat, double long) async {
    final coordinates = Coordinates(lat, long);

    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    address = first.addressLine;
    places = first.adminArea;
  }
}
