import 'dart:async';
import 'dart:io';

// import 'package:app_settings/app_settings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/inbox_repository.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/pages/elearning/elearning.dart';
import 'package:epandu/router.gr.dart';
import 'package:epandu/common_library/services/model/provider_model.dart';
// import 'package:epandu/common_library/services/location.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/common_library/services/repository/kpp_repository.dart';
import 'package:epandu/services/provider/notification_count.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/common_library/utils/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:string_validator/string_validator.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:epandu/common_library/utils/app_localizations.dart';
import 'bottom_menu.dart';
import 'feeds.dart';
import 'home_page_header.dart';
import 'home_top_menu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final authRepo = AuthRepo();
  final kppRepo = KppRepo();
  final inboxRepo = InboxRepo();
  final customDialog = CustomDialog();
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  // String _username = '';
  var studentEnrollmentData;
  // var feed;
  final myImage = ImagesConstant();
  // get location
  // Location location = Location();
  // StreamSubscription<Position> positionStream;

  String? instituteLogo = '';
  bool isLogoLoaded = false;
  String appVersion = '';
  // String latitude = '';
  // String longitude = '';

  final _iconText = TextStyle(
    fontSize: ScreenUtil().setSp(55),
    fontWeight: FontWeight.w500,
  );

  String? _message = '';
  bool _loadMore = false;
  bool _isLoading = false;
  int _startIndex = 0;
  List<dynamic> items = [];

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _openHiveBoxes();
    // getStudentInfo();
    // _getCurrentLocation();
    // _checkLocationPermission();
    _getDiProfile();
    _getActiveFeed();
    _getAppVersion();
    getUnreadNotificationCount();

    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _startIndex += 10;
          });

          if (_message!.isEmpty) {
            setState(() {
              _loadMore = true;
            });

            _getActiveFeed();
          }
        }
      });
  }

  getUnreadNotificationCount() async {
    var result = await inboxRepo.getUnreadNotificationCount();

    if (result.isSuccess) {
      if (int.tryParse(result.data[0].msgCount)! > 0) {
        Provider.of<NotificationCount>(context, listen: false).setShowBadge(
          showBadge: true,
        );

        Provider.of<NotificationCount>(context, listen: false)
            .updateNotificationBadge(
          notificationBadge: int.tryParse(result.data[0].msgCount),
        );
      } else
        Provider.of<NotificationCount>(context, listen: false).setShowBadge(
          showBadge: false,
        );
    } else {
      Provider.of<NotificationCount>(context, listen: false).setShowBadge(
        showBadge: false,
      );
    }
  }

  _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  void dispose() {
    // positionStream.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _getDiProfile() async {
    // String instituteLogoPath = await localStorage.getInstituteLogo();

    var result = await authRepo.getDiProfile(context: context);

    if (result.isSuccess && result.data != null) {
      // Uint8List decodedImage = base64Decode(
      //     result.data);
      if (mounted) {
        setState(() {
          instituteLogo = result.data;
          isLogoLoaded = true;
        });
      }
    }

    /* if (instituteLogoPath.isEmpty) {
      var result = await authRepo.getDiProfile(context: context);

      if (result.isSuccess && result.data != null) {
        // Uint8List decodedImage = base64Decode(
        //     result.data);

        setState(() {
          instituteLogo = result.data;
          isLogoLoaded = true;
        });
      }
    } else {
      // Uint8List decodedImage = base64Decode(instituteLogoPath);

      setState(() {
        instituteLogo = instituteLogoPath;
        isLogoLoaded = true;
      });
    } */
  }

  Future<void> _getActiveFeed() async {
    setState(() {
      _isLoading = true;
    });

    var result = await authRepo.getActiveFeed(
      context: context,
      feedType: 'MAIN',
      startIndex: _startIndex,
      noOfRecords: 10,
    );

    /* if (result.isSuccess) {
      setState(() {
        feed = result.data;
      });
    } */

    if (result.isSuccess) {
      if (result.data.length > 0 && mounted)
        setState(() {
          for (int i = 0; i < result.data.length; i += 1) {
            items.add(result.data[i]);
          }
        });
      else if (mounted)
        setState(() {
          _loadMore = false;
        });
    } else {
      if (mounted)
        setState(() {
          _message = result.message;
          _loadMore = false;
        });
    }

    setState(() {
      _isLoading = false;
    });
  }

  /* _checkLocationPermission() async {
    // contactBox = Hive.box('emergencyContact');

    // await location.getCurrentLocation();

    bool serviceLocationStatus = await Geolocator().isLocationServiceEnabled();

    // GeolocationStatus geolocationStatus =
    //     await Geolocator().checkGeolocationPermissionStatus();

    if (serviceLocationStatus) {
      _getCurrentLocation();
    } else {
      customDialog.show(
        context: context,
        barrierDismissable: false,
        title: Text(
            AppLocalizations.of(context).translate('loc_permission_title')),
        content: AppLocalizations.of(context).translate('loc_permission_desc'),
        customActions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context).translate('yes_lbl')),
            onPressed: () {
              context.router.pop();
              context.router.pop();
              AppSettings.openLocationSettings();
            },
          ),
          TextButton(
            child: Text(AppLocalizations.of(context).translate('no_lbl')),
            onPressed: () {
              context.router.pop();
              context.router.pop();
            },
          ),
        ],
        type: DialogType.GENERAL,
      );
    }
  }

  _getCurrentLocation() async {
    await location.getCurrentLocation();

    localStorage.saveUserLatitude(location.latitude.toString());
    localStorage.saveUserLongitude(location.longitude.toString());

    setState(() {
      latitude = location.latitude.toString();
      longitude = location.longitude.toString();
    });
  } */

  // remember to add positionStream.cancel()
  /* Future<void> _userTracking() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    // print(geolocationStatus);

    if (geolocationStatus == GeolocationStatus.granted) {
      positionStream = geolocator
          .getPositionStream(locationOptions)
          .listen((Position position) async {
        localStorage.saveUserLatitude(position.latitude.toString());
        localStorage.saveUserLongitude(position.longitude.toString());

        setState(() {
          latitude = location.latitude.toString();
          longitude = location.longitude.toString();
        });
      });
    }
  } */

  _openHiveBoxes() async {
    await Hive.openBox('telcoList');
    await Hive.openBox('serviceList');
    await Hive.openBox('inboxStorage');
    // await Hive.openBox('emergencyContact');
  }

  shimmer() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
      child: Column(
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.white,
            child: Container(
              width: ScreenUtil().setWidth(1300),
              height: ScreenUtil().setHeight(750),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _validateAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;

    var result = await authRepo.validateAppVersion(appVersion: appVersion);

    if (result.isSuccess) {
      if (int.tryParse(appVersion.split('.')[0])! <
              int.tryParse(result.data[0].appMinVersion.split('.')[0])! ||
          int.tryParse(appVersion.split('.')[1])! <
              int.tryParse(result.data[0].appMinVersion.split('.')[1])! ||
          int.tryParse(appVersion.split('.')[2])! <
              int.tryParse(result.data[0].appMinVersion.split('.')[2])!) {
        customDialog.show(
          context: context,
          content: 'App version is outdated and must be updated.',
          barrierDismissable: false,
          customActions: [
            TextButton(
              onPressed: () async {
                if (Platform.isIOS) {
                  await launchUrl(Uri.parse(
                      'https://' + result.data[0].newVerApplestoreUrl));
                } else {
                  await launchUrl(
                      Uri.parse(result.data[0].newVerGooglestoreUrl));
                }
              },
              child: Text('Ok'),
            ),
          ],
          type: DialogType.GENERAL,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            primaryColor,
          ],
          stops: [0.45, 0.65],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        backgroundColor: Colors.transparent,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: Container(
        //   margin: EdgeInsets.only(top: 120.h),
        //   height: 350.h,
        //   width: 450.w,
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       context.router.push(EmergencyDirectory());
        //     },
        //     child: Image.asset(
        //       myImage.sos,
        //       // width: ScreenUtil().setWidth(300),
        //     ),
        //     backgroundColor: Colors.transparent,
        //   ),
        // ),
        // bottomNavigationBar: BottomMenu(
        //   iconText: _iconText,
        //   // positionStream: positionStream,
        // ),
        floatingActionButton: Container(
          width: 75,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {},
              child: Image.asset(
                ImagesConstant().sos,
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.white,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.home,
                            color: Colors.grey,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.menu,
                            color: Colors.grey,
                          ),
                          Text(
                            'Menu',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: <Widget>[
              RefreshIndicator(
                onRefresh: () async {
                  String? caUid = await localStorage.getCaUid();
                  String? caPwd = await localStorage.getCaPwd();

                  await authRepo.getWsUrl(
                    context: context,
                    acctUid: caUid,
                    acctPwd: caPwd,
                    loginType: AppConfig().wsCodeCrypt,
                  );

                  await _validateAppVersion();

                  setState(() {
                    _startIndex = 0;
                    items.clear();
                    _message = '';
                  });

                  _getDiProfile();
                  _getActiveFeed();
                  _getAppVersion();
                  getUnreadNotificationCount();
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(60)),
                          child: HomePageHeader(
                            instituteLogo: instituteLogo,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        HomeTopMenu(
                          iconText: _iconText,
                          getDiProfile: () => _getDiProfile(),
                          getActiveFeed: () => _getActiveFeed(),
                        ),
                        LimitedBox(maxHeight: ScreenUtil().setHeight(30)),
                        SizedBox(
                          height: 175,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (BuildContext ctx, int index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: Image.network(
                                  'https://tbsweb.tbsdns.com/WebCache/epandu_devp_3/EPANDU/R3W77BWEY6B6TQI7DB5YM5RC5Q/image/Feed/RW42FFIRRQSB4LGEN3ZX2FWOKM_n0_20210628181116.jpg',
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                            itemCount: 50,
                            itemBuilder: (BuildContext ctx, int index) {
                              return SizedBox(
                                width: 8,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          // crossAxisSpacing: 8,
                          // mainAxisSpacing: 8,
                          crossAxisCount: 4,
                          children: <Widget>[
                            // for (int i = 0; i < 8; i++)
                            //   GestureDetector(
                            //     onTap: (){
                            //       context.router.push(CreateServiceCarRoute());
                            //     },
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Container(
                            //           child: Image.asset(
                            //             'assets/menu/Fovourite-icon.png',
                            //           ),
                            //         ),
                            //         Text('Favourite'),
                            //       ],
                            //     ),
                            //   ),

                            GestureDetector(
                              onTap: () {
                                // context.router.push(CreateServiceCarRoute());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/menu/eDriving-icon.png',
                                    ),
                                  ),
                                  Text('eDriving'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.router.push(CreateFuelRoute());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/menu/Espenses-icon.png',
                                    ),
                                  ),
                                  Text('Expenses'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // context.router.push(CreateServiceCarRoute());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/menu/Driving-routes-icon.png',
                                    ),
                                  ),
                                  Text('Driving Route'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.router.push(ElearningRoute());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/menu/eLearning-icon.png',
                                    ),
                                  ),
                                  Text('eLearning'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.router.push(CreateFavouriteRoute());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/menu/Fovourite-icon.png',
                                    ),
                                  ),
                                  Text('Favourite'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.router.push(EmergencyDirectory());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/menu/Directory-and-rating-icon.png',
                                    ),
                                  ),
                                  Text(
                                    'Directory & Rating',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // context.router.push(CreateServiceCarRoute());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/menu/Jobs-icon.png',
                                    ),
                                  ),
                                  Text('Jobs'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // context.router.push(CreateServiceCarRoute());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/menu/More-icon.png',
                                    ),
                                  ),
                                  Text('More'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Discover More',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                scrollDirection: Axis.horizontal,
                                separatorBuilder:
                                    (BuildContext ctx, int index) {
                                  return Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          primaryColor,
                                          Colors.white,
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('TYRE'),
                                            ),
                                          ],
                                        ),
                                        Image.network(
                                          'https://www.mekanika.com.my/wp-content/uploads/2019/08/uc6-photo-data.png',
                                          fit: BoxFit.contain,
                                          height: 100,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: 50,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return SizedBox(
                                    width: 8,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Promotions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 200 + 8.8,
                              child: ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                scrollDirection: Axis.horizontal,
                                separatorBuilder:
                                    (BuildContext ctx, int index) {
                                  return Container(
                                    height: 200,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          child: Image.network(
                                            'https://tbsweb.tbsdns.com/WebCache/epandu_devp_3/EPANDU/R3W77BWEY6B6TQI7DB5YM5RC5Q/image/Feed/RW42FFIRRQSB4LGEN3ZX2FWOKM_n0_20210628181116.jpg',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text('Find Out More'),
                                              Spacer(),
                                              Icon(Icons.chevron_right),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: 50,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return SizedBox(
                                    width: 8,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Highlights',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Image.network(
                                'https://i.pinimg.com/736x/44/f8/41/44f8418a4afe49d2bbcf213cf9e66b7d.jpg',
                                fit: BoxFit.contain,
                                // height: 150,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 64.0,
                        ),
                        // Feeds(
                        //   feed: items,
                        //   isLoading: _isLoading,
                        //   appVersion: appVersion,
                        // ),
                        // if (_loadMore) shimmer(),
                      ],
                    ),
                  ),
                ),
              ),
              Consumer<HomeLoadingModel>(
                builder: (BuildContext context, loadingModel, child) {
                  return LoadingModel(
                    isVisible: loadingModel.isLoading,
                    color: primaryColor,
                  );
                },
              ),
              /* LoadingModel(
                isVisible:
                    Provider.of<FeedsLoadingModel>(context, listen: false)
                        .isLoading,
                color: primaryColor,
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
