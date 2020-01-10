import 'dart:async';

import 'package:epandu/utils/local_storage.dart';
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
  double distanceInMeters = 0;

  final localStorage = LocalStorage();

  // StreamSubscription<Position> positionStream;

  Future<void> getCurrentLocation() async {
    double _savedLatitude =
        double.tryParse(await localStorage.getUserLatitude());
    double _savedLongitude =
        double.tryParse(await localStorage.getUserLongitude());

    try {
      Position position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);

      // calculate distance between user's old position with current position
      if (_savedLatitude != null && _savedLongitude != null) {
        distanceInMeters = await geolocator.distanceBetween(
            _savedLatitude, _savedLongitude, latitude, longitude);
      }

      // override old position
      latitude = position.latitude;
      longitude = position.longitude;

      // save latest latitude and longitude
      localStorage.saveUserLatitude(latitude.toString());
      localStorage.saveUserLongitude(longitude.toString());

      // await getAddress(latitude, longitude);
    } catch (e) {
      print(e);
    }
  }

  // remember to add positionStream.cancel()
  /* Future<void> userTracking() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    // print(geolocationStatus);

    if (geolocationStatus == GeolocationStatus.granted) {
      positionStream = geolocator
          .getPositionStream(locationOptions)
          .listen((Position position) async {

        latitude = position.latitude;
        longitude = position.longitude;

        await getAddress(latitude, longitude);
      });
    }
  } */

  Future<void> getAddress(double lat, double long) async {
    final coordinates = Coordinates(lat, long);

    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    address = first.addressLine;
    places = first.adminArea;
  }
}
