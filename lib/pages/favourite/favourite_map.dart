import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:huawei_map/map.dart';

@RoutePage()
class FavourieMapPage extends StatefulWidget {
  final double lat;
  final double lng;
  const FavourieMapPage({
    Key? key,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  @override
  State<FavourieMapPage> createState() => _FavourieMapPageState();
}

class _FavourieMapPageState extends State<FavourieMapPage> {
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late LatLng position;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  void initState() {
    // HuaweiMapInitializer.initializeMap();
    super.initState();
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    print(position);
    mapController.moveCamera(
      CameraUpdate.newLatLng(
        LatLng(position.latitude, position.longitude),
      ),
    );
  }

  Future<bool> _handlePermission() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 64.0),
        child: FloatingActionButton(
          onPressed: () {
            _getCurrentPosition();
          },
          child: const Icon(Icons.gps_fixed),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  mapController = controller;
                });
                mapController.moveCamera(
                  CameraUpdate.newLatLng(
                    LatLng(widget.lat, widget.lng),
                  ),
                );
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.lng), zoom: 21.0),
              zoomControlsEnabled: false,
              onTap: (LatLng pos) {},
              onCameraMove: (CameraPosition cameraPosition) {
                print(cameraPosition.zoom);
              },
              onLongPress: (LatLng pos) async {
                // double screenWidth = MediaQuery.of(context).size.width *
                //     MediaQuery.of(context).devicePixelRatio;
                // double screenHeight = MediaQuery.of(context).size.height *
                //     MediaQuery.of(context).devicePixelRatio;

                // double middleX = screenWidth / 2;
                // double middleY = screenHeight / 2;

                // ScreenCoordinate screenCoordinate =
                //     ScreenCoordinate(x: middleX.round(), y: middleY.round());

                // LatLng middlePoint =
                //     await mapController.getLatLng(screenCoordinate);
                // MarkerId a = MarkerId('value');
                // setState(() {
                //   markers[a] = Marker(
                //     markerId: const MarkerId('value'),
                //     position: middlePoint,
                //     icon: BitmapDescriptor.defaultMarker,
                //   );
                // });
              },
              markers: Set<Marker>.of(markers.values),
            ),
            // FlutterMap(
            //   options: MapOptions(
            //     center: LatLng(51.509364, -0.128928),
            //     zoom: 9.2,
            //   ),
            //   nonRotatedChildren: [
            //     AttributionWidget.defaultWidget(
            //       source: 'OpenStreetMap contributors',
            //       onSourceTapped: null,
            //     ),
            //   ],
            //   children: [
            //     TileLayer(
            //       urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            //       userAgentPackageName: 'com.example.app',
            //     ),
            //   ],
            // ),
            // HuaweiMap(
            //   mapType: MapType.normal,
            //   tiltGesturesEnabled: true,
            //   buildingsEnabled: true,
            //   compassEnabled: true,
            //   zoomControlsEnabled: false,
            //   rotateGesturesEnabled: true,
            //   myLocationButtonEnabled: true,
            //   myLocationEnabled: true,
            //   trafficEnabled: true,
            //   initialCameraPosition: CameraPosition(
            //     target: const LatLng(41.012959, 28.997438),
            //     zoom: 12,
            //   ),
            // ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 25,
              top: (MediaQuery.of(context).size.height - kToolbarHeight) / 2 -
                  19,
              child: const Icon(
                Icons.location_on,
                size: 50,
                color: Colors.red,
              ),
            ),
            Positioned(
              bottom: 16,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 32,
                  child: ElevatedButton(
                    onPressed: () async {
                      double screenWidth = MediaQuery.of(context).size.width *
                          MediaQuery.of(context).devicePixelRatio;
                      double screenHeight = MediaQuery.of(context).size.height *
                          MediaQuery.of(context).devicePixelRatio;

                      double middleX = screenWidth / 2;
                      double middleY = screenHeight / 2;

                      ScreenCoordinate screenCoordinate = ScreenCoordinate(
                          x: middleX.round(), y: middleY.round());

                      LatLng middlePoint =
                          await mapController.getLatLng(screenCoordinate);

                      await context.router.pop(middlePoint);
                    },
                    child: const Text('Select'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
