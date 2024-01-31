import 'dart:async';
import 'package:geocoder/geocoder.dart';

import '../utils/local_storage.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;
  String? address;
  String? places;
  double distanceInMeters = 0;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  final localStorage = LocalStorage();

  Future<void> getCurrentLocation() async {
    final hasPermission = await handlePermission();

    if (!hasPermission) {
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latitude = position.latitude;
    longitude = position.longitude;
  }

  Future<LocationPermission> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    return permission;
  }

  Future<void> getAddress(double? lat, double? long) async {
    final coordinates = Coordinates(lat!, long!);

    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    address = first.addressLine;
    places = first.adminArea;
  }

  Future<double> getDistance(
      {required double locLatitude, required double locLongitude}) async {
    double? savedLatitude =
        double.tryParse((await localStorage.getUserLatitude())!);
    double? savedLongitude =
        double.tryParse((await localStorage.getUserLongitude())!);

    double distance;

    if (locLatitude > -90 &&
        locLatitude < 90 &&
        locLongitude > -180 &&
        locLongitude < 180) {
      distanceInMeters = Geolocator.distanceBetween(
          savedLatitude!, savedLongitude!, locLatitude, locLongitude);

      distance = distanceInMeters;

      return distance;
    }
    return 100000000.0;
  }

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}
