import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@RoutePage()
class FuelMapPage extends StatefulWidget {
  final double lat;
  final double lng;
  const FuelMapPage({super.key, required this.lat, required this.lng});

  @override
  State<FuelMapPage> createState() => _FuelMapPageState();
}

class _FuelMapPageState extends State<FuelMapPage> {
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late LatLng position;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final Location _location = Location();

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _location.handlePermission();

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
              onLongPress: (LatLng pos) async {},
              markers: Set<Marker>.of(markers.values),
            ),
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
                      if (!context.mounted) return;
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
