import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epandu/common_library/services/repository/favourite_repository.dart';
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
  final favouriteRepo = FavouriteRepo();
  Future? favPlaceFuture;
  Map<String, Future> favPlacePictureFuture = {};
  Future? favPlacePictureFutureTest;

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  Future getFavPlace() async {
    var result = await favouriteRepo.getFavPlace(
        placeId: '', type: '', name: '', description: '');
    if (result.isSuccess && result.data != null) {
      for (var element in result.data) {
        // setState(() {
        favPlacePictureFuture[element.placeId] =
            getFavPlacePicture(placeId: element.placeId);
        // favPlacePictureFutureTest =
        //     getFavPlacePicture(placeId: element.placeId);
        // });
      }
    }
    return result;
  }

  Future getFavPlacePicture({
    required String placeId,
  }) async {
    var result = await favouriteRepo.getFavPlacePicture(
      placeId: placeId,
      bgnLimit: 0,
      endLimit: 100,
    );
    return result;
  }

  @override
  void initState() {
    super.initState();
    favPlaceFuture = getFavPlace();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Place'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  favPlacePictureFutureTest =
                      getFavPlacePicture(placeId: "dwdw");
                });
              },
              icon: Icon(Icons.ac_unit))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Object? result = await context.router.push(CreateFavouriteRoute());
          if (result.toString() == 'refresh') {
            setState(() {
              favPlaceFuture = getFavPlace();
            });
          }
        },
        label: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(Icons.add),
            ),
            Text('Add Place')
          ],
        ),
      ),
      body: FutureBuilder(
        future: favPlaceFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
            case ConnectionState.active:
              return Center(child: const CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return Text('error');
                }
                return ListView.separated(
                  addRepaintBoundaries: false,
                  addAutomaticKeepAlives: true,
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  itemCount: snapshot.data.data.length,
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
                            child: FutureBuilder(
                              future: favPlacePictureFuture[snapshot
                                  .data
                                  .data[index]
                                  .placeId], // a previously-obtained Future<String> or null
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot2) {
                                switch (snapshot2.connectionState) {
                                  case ConnectionState.waiting:
                                  case ConnectionState.none:
                                  case ConnectionState.active:
                                    return Center(
                                        child:
                                            const CircularProgressIndicator());
                                  case ConnectionState.done:
                                    if (snapshot2.data.data.length == 0)
                                      return Center(
                                          child: Text('No photo found'));
                                    else {
                                      return ListView.separated(
                                        addRepaintBoundaries: false,
                                        addAutomaticKeepAlives: true,
                                        padding: EdgeInsets.only(
                                          top: 8,
                                          left: 16,
                                          right: 16,
                                        ),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot2.data.data.length,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            width: 8,
                                          );
                                        },
                                        itemBuilder: (context, index2) {
                                          return GestureDetector(
                                            onTap: () {
                                              context.router.push(
                                                  PhotoViewRoute(
                                                      url: snapshot2
                                                          .data
                                                          .data[index2]
                                                          .picturePath
                                                          .replaceAll(
                                                              removeBracket, '')
                                                          .split('\r\n')[0]));
                                            },
                                            child: Container(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                child: AspectRatio(
                                                  aspectRatio: 1 / 1,
                                                  child: CachedNetworkImage(
                                                    imageUrl: snapshot2
                                                        .data
                                                        .data[index2]
                                                        .picturePath
                                                        .replaceAll(
                                                            removeBracket, '')
                                                        .split('\r\n')[0],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data.data[index].type,
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  snapshot.data.data[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  snapshot.data.data[index].description,
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
                                                        await map
                                                            .showDirections(
                                                          destination: Coords(
                                                            double.parse(
                                                                snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .lat),
                                                            double.parse(
                                                                snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .lng),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    OutlinedButton.icon(
                                      onPressed: () async {
                                        var result = await context.router.push(
                                          EditFavouritePlaceRoute(
                                            placeId: snapshot
                                                .data.data[index].placeId,
                                          ),
                                        );

                                        if (result.toString() == 'refresh') {
                                          setState(() {
                                            favPlaceFuture = getFavPlace();
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.edit),
                                      label: Text('Edit'),
                                      style: OutlinedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
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
                );
              } else if (snapshot.hasError) {
                return Text('error');
              } else {
                return Text('else');
              }
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
