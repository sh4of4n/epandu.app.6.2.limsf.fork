import 'dart:async';
import 'dart:io';
import 'package:epandu/utils/local_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class Location {
  final geolocator = Geolocator();
  final locationOptions = LocationOptions(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  double latitude;
  double longitude;
  String address;
  String places;
  double distanceInMeters = 0;

  final localStorage = LocalStorage();

  Future<void> getCurrentLocation() async {
    double _savedLatitude =
        double.tryParse(await localStorage.getUserLatitude());
    double _savedLongitude =
        double.tryParse(await localStorage.getUserLongitude());

    try {
      Position position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);

      latitude = position.latitude;
      longitude = position.longitude;

      // calculate distance between user's old position with current position
      if (_savedLatitude != null && _savedLongitude != null) {
        distanceInMeters = await geolocator.distanceBetween(
            _savedLatitude, _savedLongitude, latitude, longitude);
      }

      // save latest latitude and longitude
      localStorage.saveUserLatitude(latitude.toString());
      localStorage.saveUserLongitude(longitude.toString());

      // await getAddress(latitude, longitude);
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

  Future<double> getDistance({double locLatitude, double locLongitude}) async {
    double _savedLatitude =
        double.tryParse(await localStorage.getUserLatitude());
    double _savedLongitude =
        double.tryParse(await localStorage.getUserLongitude());

    double distance;

    if (locLatitude > -90 &&
        locLatitude < 90 &&
        locLongitude > -180 &&
        locLongitude < 180) {
      distanceInMeters = await geolocator.distanceBetween(
          _savedLatitude, _savedLongitude, locLatitude, locLongitude);

      distance = distanceInMeters;

      return distance;
    }
    return 100000000.0;
  }
}
