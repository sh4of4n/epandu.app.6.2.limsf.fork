import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epandu/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

class FavouritePlaceListPage extends StatefulWidget {
  const FavouritePlaceListPage({super.key});

  @override
  State<FavouritePlaceListPage> createState() => _FavouritePlaceListPageState();
}

class _FavouritePlaceListPageState extends State<FavouritePlaceListPage>
    with AutomaticKeepAliveClientMixin {
  late GoogleMapController mapController;
  double _lat = 3.139003;
  double _lng = 101.68685499999992;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Place'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.router.push(CreateFavouriteRoute());
        },
        label: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(Icons.add),
            ),
            Text("Add Place")
          ],
        ),
      ),
      body: ListView.separated(
        addRepaintBoundaries: false,
        addAutomaticKeepAlives: true,
        padding: EdgeInsets.symmetric(
          vertical: 16,
        ),
        itemCount: 20,
        separatorBuilder: (context, index) {
          return Container(
            height: 8,
            color: Colors.grey.shade200,
          );
        },
        itemBuilder: (ctx, index) {
          return Container(
            // color: Colors.red,
            child: Column(
              children: [
                Container(
                  height: 150,
                  child: ListView.separated(
                    addRepaintBoundaries: false,
                    addAutomaticKeepAlives: true,
                    padding: EdgeInsets.only(
                      top: 8,
                      left: 16,
                      right: 16,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 8,
                      );
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.router.push(PhotoViewRoute());
                        },
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://3u8dbs16f2emlqxkbc8tbvgf-wpengine.netdna-ssl.com/wp-content/uploads/2019/06/Coffee-bean-Tea-Leaf-Logo-Cups.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cafe',
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        'The Coffee Bean & Tea Leaf',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Born and brewed in Southern California since 1963, The Coffee Bean & Tea Leaf® is passionate about connecting loyal customers with carefully handcrafted',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: () async {
                              final availableMaps =
                                  await MapLauncher.installedMaps;

                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SafeArea(
                                    child: Wrap(
                                      children: <Widget>[
                                        for (var map in availableMaps)
                                          ListTile(
                                            onTap: () async {
                                              await map.showDirections(
                                                destination: Coords(
                                                  5.244208533751952,
                                                  100.43825519887051,
                                                ),
                                              );
                                              context.router.pop();
                                            },
                                            title: Text(map.mapName),
                                            leading: SvgPicture.asset(
                                              map.icon,
                                              height: 30.0,
                                              width: 30.0,
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.directions),
                            label: Text('Directions'),
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              context.router.push(EditFavouritePlaceRoute());
                            },
                            icon: Icon(Icons.edit),
                            label: Text('Edit'),
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
