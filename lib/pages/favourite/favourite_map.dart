import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// import 'package:huawei_map/map.dart';

class FavourieMapPage extends StatefulWidget {
  FavourieMapPage({Key? key}) : super(key: key);

  @override
  State<FavourieMapPage> createState() => _FavourieMapPageState();
}

class _FavourieMapPageState extends State<FavourieMapPage> {
  // GoogleMapController? mapController;

  @override
  void initState() {
    // HuaweiMapInitializer.initializeMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // GoogleMap(
            //   onMapCreated: (GoogleMapController controller) {
            //     setState(() {
            //       mapController = controller;
            //     });
            //   },
            //   initialCameraPosition:
            //       CameraPosition(target: LatLng(-33.852, 151.211), zoom: 11.0),
            //   onTap: (LatLng pos) {},
            //   onLongPress: (LatLng pos) {
            //     print(pos);
            //   },
            // ),
            FlutterMap(
              options: MapOptions(
                center: LatLng(51.509364, -0.128928),
                zoom: 9.2,
              ),
              nonRotatedChildren: [
                AttributionWidget.defaultWidget(
                  source: 'OpenStreetMap contributors',
                  onSourceTapped: null,
                ),
              ],
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
              ],
            ),
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
              bottom: 16,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 32,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Select'),
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
