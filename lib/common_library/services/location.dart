import 'dart:async';
import '../utils/local_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class Location {
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
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latitude = position.latitude;
    longitude = position.longitude;
  }

  Future<LocationPermission> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    return permission;
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
      distanceInMeters = Geolocator.distanceBetween(
          _savedLatitude, _savedLongitude, locLatitude, locLongitude);

      distance = distanceInMeters;

      return distance;
    }
    return 100000000.0;
  }
}
