import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epandu/common_library/services/model/favourite_model.dart';
import 'package:epandu/common_library/services/repository/favourite_repository.dart';
import 'package:epandu/common_library/services/response.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';

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
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  bool _isSearch = false;
  FocusNode searchFocus = FocusNode();
  Timer? _debounce;
  GlobalKey<RefreshIndicatorState> _refresherKey =
      GlobalKey<RefreshIndicatorState>();
  Map imageMap = {};
  final localStorage = LocalStorage();
  String? placeLocalStorage = '';

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  Future getFavPlace({
    required String name,
  }) async {
    // placeLocalStorage = await localStorage.getPlaces();
    var result = await favouriteRepo.getFavPlace(
        placeId: '', type: '', name: name, description: '');
    if (result.isSuccess && result.data != null) {
      // Map<String, dynamic> newResult = {
      //   'isSuccess': result.isSuccess,
      //   'message': result.message,
      //   'data': []
      // };
      for (var element in result.data) {
        favPlacePictureFuture[element.placeId] =
            getFavPlacePicture(placeId: element.placeId);
        // newResult['data'].add((element as FavPlace).toJson());
      }

      // localStorage.savePlaces(jsonEncode(newResult));
      // placeLocalStorage = await localStorage.getPlaces();
      // print('abc');
      // Response.fromJson(jsonDecode(placeLocalStorage!));
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
    if (result.isSuccess) {
      imageMap[placeId] = result;
    }

    return result;
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
  void initState() {
    super.initState();

    favPlaceFuture = getFavPlace(name: '');
    _handlePermission();
  }

  @override
  void dispose() {
    searchFocus.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: _isSearch
            ? TextField(
                focusNode: searchFocus,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search place',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    setState(() {
                      favPlaceFuture = getFavPlace(name: value);
                    });
                  });
                },
              )
            : Text('Favourite Places'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (_isSearch) {
                  _isSearch = false;
                  favPlaceFuture = getFavPlace(name: '');
                } else {
                  _isSearch = true;
                  searchFocus.requestFocus();
                }
              });
            },
            icon: _isSearch ? Icon(Icons.close) : Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var result = await context.router.push(CreateFavouriteRoute());
          if (result.toString() == 'refresh') {
            setState(() {
              favPlaceFuture = getFavPlace(name: '');
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
      body: RefreshIndicator(
        key: _refresherKey,
        onRefresh: () async {
          setState(() {
            favPlaceFuture = getFavPlace(name: '');
          });
          await favPlaceFuture;
        },
        child: FutureBuilder(
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
                    return Text('empty');
                  }
                  if (snapshot.data.data.length == 0) {
                    return Center(child: Text('No Data Found'));
                  }
                  print(snapshot.data);
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
                            FutureBuilder(
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child:
                                            const CircularProgressIndicator(),
                                      ),
                                    );
                                  case ConnectionState.done:
                                    if (snapshot2.data.data.length == 0)
                                      return SizedBox();
                                    else {
                                      return Container(
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
                                          itemCount: snapshot2.data.data.length,
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              width: 8,
                                            );
                                          },
                                          itemBuilder: (context, index2) {
                                            return GestureDetector(
                                              onTap: () {
                                                List gallery = [];
                                                for (var element
                                                    in snapshot2.data.data) {
                                                  gallery.add(element
                                                      .picturePath
                                                      .replaceAll(
                                                          removeBracket, '')
                                                      .split('\r\n')[0]);
                                                }
                                                context.router.push(
                                                  PhotoViewRoute(
                                                    title: snapshot
                                                        .data.data[index].name,
                                                    url: gallery,
                                                    initialIndex: index2,
                                                    type: 'network',
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                        ),
                                      );
                                    }
                                }
                              },
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
                                  ReadMoreText(
                                    snapshot.data.data[index].description,
                                    trimLines: 5,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    moreStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    lessStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
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
                                                    for (var map
                                                        in availableMaps)
                                                      ListTile(
                                                        onTap: () async {
                                                          await map
                                                              .showDirections(
                                                            destination: Coords(
                                                              double.parse(
                                                                  snapshot
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .lat),
                                                              double.parse(
                                                                  snapshot
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .lng),
                                                            ),
                                                          );
                                                          context.router.pop();
                                                        },
                                                        title:
                                                            Text(map.mapName),
                                                        leading:
                                                            SvgPicture.asset(
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
                                          await EasyLoading.show(
                                            maskType: EasyLoadingMaskType.black,
                                          );
                                          await favPlacePictureFuture[snapshot
                                              .data.data[index].placeId];
                                          await EasyLoading.dismiss();
                                          var result =
                                              await context.router.push(
                                            EditFavouritePlaceRoute(
                                              placeId: snapshot
                                                  .data.data[index].placeId,
                                              place: snapshot.data.data[index],
                                              images: imageMap[snapshot
                                                  .data.data[index].placeId],
                                            ),
                                          );

                                          if (result != null) {
                                            Map resultUpdate = (result as Map);
                                            setState(() {
                                              snapshot.data.data[index].type =
                                                  resultUpdate['type'];
                                              snapshot.data.data[index].name =
                                                  resultUpdate['name'];
                                              snapshot.data.data[index]
                                                      .description =
                                                  resultUpdate['description'];
                                              snapshot.data.data[index].lat =
                                                  resultUpdate['lat']
                                                      .toString();
                                              snapshot.data.data[index].lng =
                                                  resultUpdate['lng']
                                                      .toString();
                                            });
                                          }

                                          // if (result.toString() == 'refresh') {
                                          //   setState(() {
                                          //     favPlaceFuture =
                                          //         getFavPlace(name: '');
                                          //   });
                                          // }
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
