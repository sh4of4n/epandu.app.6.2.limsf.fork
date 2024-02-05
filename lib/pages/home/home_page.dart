import 'dart:async';
import 'dart:io';

// import 'package:app_settings/app_settings.dart';
import 'package:app_settings/app_settings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epandu/common_library/services/location.dart';
import 'package:epandu/common_library/services/model/auth_model.dart';
import 'package:epandu/common_library/services/model/profile_model.dart';
import 'package:epandu/common_library/services/repository/fpx_repository.dart';
import 'package:epandu/common_library/services/repository/inbox_repository.dart';
import 'package:epandu/common_library/services/repository/profile_repository.dart';
import 'package:epandu/common_library/services/response.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:string_validator/string_validator.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:epandu/common_library/utils/app_localizations.dart';
import 'home_page_header.dart';
import 'home_top_menu.dart';

@RoutePage(name: 'Home')
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final fpxRepo = FpxRepo();
  final profileRepo = ProfileRepo();
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
  String latitude = '';
  String longitude = '';
  Location location = Location();

  final _iconText = TextStyle(
    fontSize: ScreenUtil().setSp(55),
    fontWeight: FontWeight.w500,
  );

  String? _message = '';
  bool loadMore = false;
  bool isLoading = false;
  int _startIndex = 0;
  List<FeedByLevel> items = [];
  final appConfig = AppConfig();

  final ScrollController _scrollController = ScrollController();

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);
  List shortcutButton = [
    {
      'image': 'assets/menu/Espenses-icon.png',
      'title': 'eDriving',
      'router': EpanduCategory(),
    },
    {
      'image': 'assets/menu/Espenses-icon.png',
      'title': 'Expenses',
      'router': const ExpFuelListRoute(),
    },
    {
      'image': 'assets/menu/Driving-routes-icon.png',
      'title': 'Driving Route',
      'router': '',
    },
    {
      'image': 'assets/menu/eLearning-icon.png',
      'title': 'eLearning',
      'router': const KppCategory(),
    },
    {
      'image': 'assets/menu/Fovourite-icon.png',
      'title': 'Favourite',
      'router': const FavouritePlaceListRoute(),
    },
    {
      'image': 'assets/menu/Directory-and-rating-icon.png',
      'title': 'Directory & Rating',
      'router': const EmergencyDirectory(),
    },
    // {
    //   'image': 'assets/menu/Jobs-icon.png',
    //   'title': 'Jobs',
    //   'router': const BriefListRoute(),
    // },
    // {
    //   'image': 'assets/menu/More-icon.png',
    //   'title': 'More',
    //   'router': '',
    // },
  ];

  final List<Map<String, String>> _productCategory = [
    {
      'title': 'Tyre',
      'image':
          'https://www.mekanika.com.my/wp-content/uploads/2019/08/uc6-photo-data.png',
    },
    {
      'title': 'Battery',
      'image':
          'https://centurybattery.com.my/wp-content/uploads/2019/04/CB-Optima.png',
    },
    {
      'title': 'Engine Oil',
      'image':
          'https://www.nulon.com.au/images/Product%20Images/NEW_Front%20Images/APX0W20GF6-5.png',
    },
    {
      'title': 'Sport Rim',
      'image':
          'https://carsomemy.s3.ap-southeast-1.amazonaws.com/wp/Konig-Neoform-Rim.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    //Temporary Hide It- Kishor
    //initPlatformState();

    clearAllAppNotifications();
    _openHiveBoxes();
    // getStudentInfo();
    // _getCurrentLocation();
    // _checkLocationPermission();
    _getDiProfile();
    _getActiveFeed();
    _getAppVersion();
    getUnreadNotificationCount();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _startIndex += 10;
        });

        if (_message!.isEmpty) {
          setState(() {
            loadMore = true;
          });

          _getActiveFeed();
        }
      }
    });
  }

  initPlatformState() async {
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        print('IsappBadgeSupported: supported');
        FlutterAppBadger.removeBadge();
      } else {
        print('IsappBadgeSupported:Not supported');
      }
    } on PlatformException {
      print('IsappBadgeSupported :Failed to get badge support.');
    }
  }

  Future<void> clearAllAppNotifications() async {
    // Initialize the local notification plugin
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Cancel all notifications generated by the app
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  loadUrl(feed, BuildContext context) async {
    if (Provider.of<CallStatusModel>(context, listen: false).status == false) {
      Provider.of<CallStatusModel>(context, listen: false).callStatus(true);

      var caUid = await localStorage.getCaUid();
      var caPwd = await localStorage.getCaPwd();
      var merchantNo = await localStorage.getMerchantDbCode();
      if (!context.mounted) return;
      Response<List<UserProfile>?> result =
          await profileRepo.getUserProfile(context: context);
      if (result.isSuccess) {
        // String merchantNo = 'P1001';
        String? phone = result.data![0].phone;
        String? email = result.data![0].eMail;
        String icName = result.data![0].name ?? '';
        String? icNo = result.data![0].icNo;
        String dob = result.data![0].birthDate ?? '';
        String? userId = await localStorage.getUserId();
        String? loginDeviceId = await localStorage.getLoginDeviceId();
        // String profilePic = result.data[0].picturePath != null &&
        //         result.data[0].picturePath.isNotEmpty
        //     ? result.data[0].picturePath
        //         .replaceAll(removeBracket, '')
        //         .split('\r\n')[0]
        //     : '';

        String? url = feed.feedNavigate +
            '?' +
            'appId=${appConfig.appId}' +
            '&appVersion=$appVersion' +
            '&userId=$userId' +
            '&deviceId=$loginDeviceId' +
            '&caUid=$caUid' +
            '&caPwd=${Uri.encodeQueryComponent(caPwd!)}' +
            _getMerchantNo(
                udf: feed.udfReturnParameter, merchantNo: merchantNo) +
            _getIcName(
                udf: feed.udfReturnParameter,
                icName: Uri.encodeComponent(icName)) +
            _getIcNo(udf: feed.udfReturnParameter, icNo: icNo ?? '') +
            _getPhone(udf: feed.udfReturnParameter, phone: phone) +
            _getEmail(udf: feed.udfReturnParameter, email: email) +
            _getBirthDate(
                udf: feed.udfReturnParameter,
                dob: dob.length >= 10 ? dob.substring(0, 10) : '') +
            _getLatitude(udf: feed.udfReturnParameter) +
            _getLongitude(udf: feed.udfReturnParameter) +
            _getPackageCode(udf: feed.udfReturnParameter);
        if (!context.mounted) return;
        context.router.push(
          Webview(url: url),
          //'https://teal-bavarois-ec49bd.netlify.app/#/institute-near-me?appId=ePandu.App&appVersion=6.1.8&userId=E08FBDC357&deviceId=TVDYF3SD7Q62QSARVKCPZS6FKA&caUid=epandu_devp_3&caPwd=123456&latitude=5.4244367&longitude=100.4003283'),
        );

        Provider.of<HomeLoadingModel>(context, listen: false)
            .loadingStatus(false);

        /* launch(url,
                              forceWebView: true, enableJavaScript: true); */
      } else {
        if (!context.mounted) return;
        customDialog.show(
          context: context,
          barrierDismissable: false,
          content: result.message,
          customActions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.translate('ok_btn')),
              onPressed: () {
                context.router.pop();
                Provider.of<HomeLoadingModel>(context, listen: false)
                    .loadingStatus(false);
              },
            ),
          ],
          type: DialogType.general,
        );
      }
    }
  }

  String _getPackageCode({udf}) {
    if (udf != null && udf.contains('package')) {
      int? startIndex = udf.indexOf('{');

      String? packages = udf.substring(startIndex);

      print(packages);

      return '&package=$packages';
    }
    return '';
  }

  _getCurrentLocation(feed, context) async {
    // LocationPermission permission = await checkPermission();
    if (feed.udfReturnParameter != null &&
        feed.udfReturnParameter.contains('latitude') &&
        feed.udfReturnParameter.contains('longitude')) {
      LocationPermission permission = await location.checkLocationPermission();

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        await location.getCurrentLocation();

        localStorage.saveUserLatitude(location.latitude.toString());
        localStorage.saveUserLongitude(location.longitude.toString());

        setState(() {
          latitude = location.latitude.toString();
          longitude = location.longitude.toString();
        });

        loadUrl(feed, context);
      } else {
        Provider.of<HomeLoadingModel>(context, listen: false)
            .loadingStatus(false);

        customDialog.show(
            context: context,
            content:
                AppLocalizations.of(context)!.translate('loc_permission_on'),
            type: DialogType.info);
      }
    } else {
      loadUrl(feed, context);
    }
  }

  _checkLocationPermission(feed, context) async {
    Provider.of<HomeLoadingModel>(context, listen: false).loadingStatus(true);
    // contactBox = Hive.box('emergencyContact');

    // await location.getCurrentLocation();

    bool serviceLocationStatus = await Geolocator.isLocationServiceEnabled();

    // GeolocationStatus geolocationStatus =
    //     await Geolocator().checkGeolocationPermissionStatus();

    if (serviceLocationStatus) {
      _getCurrentLocation(feed, context);
    } else {
      customDialog.show(
        context: context,
        barrierDismissable: false,
        title: Text(
            AppLocalizations.of(context)!.translate('loc_permission_title')),
        content: AppLocalizations.of(context)!.translate('loc_permission_desc'),
        customActions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.translate('yes_lbl')),
            onPressed: () {
              Provider.of<HomeLoadingModel>(context, listen: false)
                  .loadingStatus(false);
              context.router.pop();
              AppSettings.openAppSettings(type: AppSettingsType.location);
            },
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.translate('no_lbl')),
            onPressed: () {
              Provider.of<HomeLoadingModel>(context, listen: false)
                  .loadingStatus(false);

              context.router.pop();

              customDialog.show(
                  context: context,
                  content: AppLocalizations.of(context)!
                      .translate('loc_permission_on'),
                  type: DialogType.info);
            },
          ),
        ],
        type: DialogType.general,
      );
    }
  }

  getOnlinePaymentListByIcNo() async {
    String? icNo = await localStorage.getStudentIc();
    if (!context.mounted) return;
    var result = await fpxRepo.getOnlinePaymentListByIcNo(
      context: context,
      icNo: icNo ?? '',
      startIndex: '-1',
      noOfRecords: '-1',
    );

    if (result.isSuccess) {
      if (!context.mounted) return;
      return customDialog.show(
        context: context,
        title: AppLocalizations.of(context)!.translate('success'),
        content:
            'Paid Amount: ${result.data[0].paidAmt}\nTransaction status: ${result.data[0].status}',
        customActions: <Widget>[
          TextButton(
              child: Text(AppLocalizations.of(context)!.translate('ok_btn')),
              onPressed: () {
                context.router.pop();
              }),
        ],
        type: DialogType.general,
      );
    }
  }

  getUnreadNotificationCount() async {
    var result = await inboxRepo.getUnreadNotificationCount();

    if (result.isSuccess) {
      if (int.tryParse(result.data[0].msgCount)! > 0) {
        if (!context.mounted) return;
        Provider.of<NotificationCount>(context, listen: false).setShowBadge(
          showBadge: true,
        );

        Provider.of<NotificationCount>(context, listen: false)
            .updateNotificationBadge(
          notificationBadge: int.tryParse(result.data[0].msgCount),
        );
      } else {
        if (!context.mounted) return;
        Provider.of<NotificationCount>(context, listen: false).setShowBadge(
          showBadge: false,
        );
      }
    } else {
      if (!context.mounted) return;
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

  String _getMerchantNo({udf, merchantNo}) {
    if (udf != null && udf.contains('merchant_no')) {
      return '&merchantNo=$merchantNo';
    }
    return '';
  }

  String _getIcName({udf, icName}) {
    if (udf != null && udf.contains('name')) {
      return '&icName=${Uri.encodeComponent(icName)}';
    }
    return '';
  }

  String _getIcNo({udf, icNo}) {
    if (udf != null && udf.contains('ic_no')) {
      return '&icNo=$icNo';
    }
    return '';
  }

  String _getPhone({udf, phone}) {
    if (udf != null && udf.contains('phone')) {
      return '&phone=$phone';
    }
    return '';
  }

  String _getEmail({udf, email}) {
    if (udf != null && udf.contains('e_mail')) {
      return '&email=${email ?? ''}';
    }
    return '';
  }

  String _getBirthDate({udf, dob}) {
    if (udf != null && udf.contains('birth_date')) {
      return '&dob=${dob?.substring(0, 10)}';
    }
    return '';
  }

  String _getLatitude({udf}) {
    if (udf != null && udf.contains('latitude')) {
      return '&latitude=$latitude';
    }
    return '';
  }

  String _getLongitude({udf}) {
    if (udf != null && udf.contains('longitude')) {
      return '&longitude=$longitude';
    }
    return '';
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
      isLoading = true;
    });

    Response<List<FeedByLevel>?> result = await authRepo.getActiveFeed(
      context: context,
      feedType: 'MAIN',
      startIndex: _startIndex,
      noOfRecords: 100,
    );
    if (result.isSuccess) {
      if (result.data!.isNotEmpty && mounted) {
        setState(() {
          for (int i = 0; i < result.data!.length; i += 1) {
            items.add(result.data![i]);
          }
        });
      } else if (mounted) {
        setState(() {
          loadMore = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _message = result.message;
          loadMore = false;
        });
      }
    }
    if (!mounted) return;
    setState(() {
      isLoading = false;
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
        if (!context.mounted) return;
        customDialog.show(
          context: context,
          content: 'App version is outdated and must be updated.',
          barrierDismissable: false,
          customActions: [
            TextButton(
              onPressed: () async {
                if (Platform.isIOS) {
                  await launchUrl(Uri.parse(
                      'https://${result.data[0].newVerApplestoreUrl}'));
                } else {
                  await launchUrl(
                      Uri.parse(result.data[0].newVerGooglestoreUrl));
                }
              },
              child: const Text('Ok'),
            ),
          ],
          type: DialogType.general,
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
          stops: const [0.45, 0.65],
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
        floatingActionButton: SizedBox(
          width: 75,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                context.router.push(const EmergencyDirectory());
              },
              backgroundColor: Colors.transparent,
              child: Image.asset(
                ImagesConstant().sos,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
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
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
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
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
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
                  if (!context.mounted) return;
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
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(60)),
                        child: HomePageHeader(
                          instituteLogo: instituteLogo,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      HomeTopMenu(
                          iconText: _iconText,
                          getDiProfile: () => _getDiProfile(),
                          getActiveFeed: () {
                            items.clear();
                            _getActiveFeed();
                          }),
                      LimitedBox(maxHeight: ScreenUtil().setHeight(30)),
                      items.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: 200 + 8.8,
                              child: ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                scrollDirection: Axis.horizontal,
                                separatorBuilder:
                                    (BuildContext ctx, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      var feedValue = items[index].feedNavigate;
                                      if (feedValue != null) {
                                        bool isUrl = isURL(feedValue);

                                        // Navigation
                                        if (!isUrl) {
                                          switch (feedValue) {
                                            case 'ETESTING':
                                              context.router
                                                  .push(EtestingCategory());
                                              break;
                                            case 'EDRIVING':
                                              context.router
                                                  .push(EpanduCategory());
                                              break;
                                            case 'ENROLLMENT':
                                              context.router
                                                  .push(const Enrollment());
                                              break;
                                            case 'DI_ENROLLMENT':
                                              String packageCodeJson =
                                                  _getPackageCode(
                                                      udf: items[index]
                                                          .udfReturnParameter);

                                              context.router
                                                  .push(
                                                    DiEnrollment(
                                                        packageCodeJson:
                                                            packageCodeJson
                                                                .replaceAll(
                                                                    '&package=',
                                                                    '')),
                                                  )
                                                  .then((value) =>
                                                      getOnlinePaymentListByIcNo());
                                              break;
                                            case 'KPP':
                                              context.router
                                                  .push(const KppCategory());
                                              break;
                                            case 'VCLUB':
                                              context.router
                                                  .push(const ValueClub());
                                              break;
                                            case 'MULTILVL':
                                              context.router.push(
                                                Multilevel(
                                                  feed: items[index],
                                                ),
                                              );
                                              break;
                                            default:
                                              break;
                                          }
                                        } else {
                                          _checkLocationPermission(
                                              items[index], context);
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 200,
                                      width: 300,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: (items[index]
                                                          .feedMediaFilename ??
                                                      '')
                                                  .replaceAll(removeBracket, '')
                                                  .split('\r\n')[0],
                                              fit: BoxFit.cover,
                                            ),
                                            // Image.network(
                                            //   (items[index].feedMediaFilename ??
                                            //           '')
                                            //       .replaceAll(removeBracket, '')
                                            //       .split('\r\n')[0],
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    items[index].feedText ?? '',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const Icon(Icons.chevron_right),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: items.length + 1,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return const SizedBox(
                                    width: 8,
                                  );
                                },
                              ),
                            ),
                      const SizedBox(
                        height: 8,
                      ),
                      GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          crossAxisCount: 4,
                          childAspectRatio: 0.9,
                          children: shortcutButton.map(
                            (e) {
                              return GestureDetector(
                                onTap: () {
                                  if (e['router'] != '') {
                                    context.router.push(e['router']);
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: Image.asset(
                                        e['image'],
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Text(
                                        e['title'],
                                        style: const TextStyle(),
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).toList()

                          // <Widget>[

                          //     GestureDetector(
                          //       onTap: () {
                          //         context.router.push(item);
                          //       },
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceEvenly,
                          //         children: [
                          //           Flexible(
                          //             flex: 2,
                          //             child: Container(
                          //               child: Image.asset(
                          //                 'assets/menu/Espenses-icon.png',
                          //               ),
                          //             ),
                          //           ),
                          //           Flexible(
                          //             flex: 1,
                          //             child: Text('eDriving'),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   GestureDetector(
                          //     onTap: () {
                          //       context.router.push(CreateFuelRoute());
                          //     },
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceEvenly,
                          //       children: [
                          //         Container(
                          //           child: Image.asset(
                          //             'assets/menu/Espenses-icon.png',
                          //           ),
                          //         ),
                          //         Text('Expenses'),
                          //       ],
                          //     ),
                          //   ),
                          //   GestureDetector(
                          //     onTap: () {
                          //       // context.router.push(CreateServiceCarRoute());
                          //     },
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceEvenly,
                          //       children: [
                          //         Container(
                          //           child: Image.asset(
                          //             'assets/menu/Driving-routes-icon.png',
                          //           ),
                          //         ),
                          //         Text('Driving Route'),
                          //       ],
                          //     ),
                          //   ),
                          //   GestureDetector(
                          //     onTap: () {
                          //       context.router.push(KppCategory());
                          //     },
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceEvenly,
                          //       children: [
                          //         Container(
                          //           child: Image.asset(
                          //             'assets/menu/eLearning-icon.png',
                          //           ),
                          //         ),
                          //         Text('eLearning'),
                          //       ],
                          //     ),
                          //   ),
                          //   GestureDetector(
                          //     onTap: () {
                          //       context.router.push(FavouritePlaceListRoute());
                          //     },
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceEvenly,
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
                          //   GestureDetector(
                          //     onTap: () {
                          //       context.router.push(EmergencyDirectory());
                          //     },
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceEvenly,
                          //       children: [
                          //         Container(
                          //           child: Image.asset(
                          //             'assets/menu/Directory-and-rating-icon.png',
                          //           ),
                          //         ),
                          //         Text(
                          //           'Directory & Rating',
                          //           overflow: TextOverflow.ellipsis,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          //   GestureDetector(
                          //     onTap: () {
                          //       // context.router.push(CreateServiceCarRoute());
                          //     },
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceEvenly,
                          //       children: [
                          //         Container(
                          //           child: Image.asset(
                          //             'assets/menu/Jobs-icon.png',
                          //           ),
                          //         ),
                          //         Text('Jobs'),
                          //       ],
                          //     ),
                          //   ),
                          //   GestureDetector(
                          //     onTap: () {
                          //       // context.router.push(CreateServiceCarRoute());
                          //     },
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceEvenly,
                          //       children: [
                          //         Container(
                          //           child: Image.asset(
                          //             'assets/menu/More-icon.png',
                          //           ),
                          //         ),
                          //         Text('More'),
                          //       ],
                          //     ),
                          //   ),
                          // ],
                          ),
                      const SizedBox(
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
                                GestureDetector(
                                  onTap: () {
                                    // String url =
                                    //     'https://joyful-scone-c340bf.netlify.app/';
                                    // loadUrl(url, context);
                                    // final Uri telLaunchUri = Uri(
                                    //   scheme: 'tel',
                                    //   path: '0124148186',
                                    // );
                                    // launchUrl(telLaunchUri);
                                  },
                                  child: const Text(
                                    'Discover More',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.chevron_right),
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
                              separatorBuilder: (BuildContext ctx, int index) {
                                return Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(_productCategory[index]
                                                ['title']!),
                                          ),
                                        ],
                                      ),
                                      // Image.network(
                                      //   'https://www.mekanika.com.my/wp-content/uploads/2019/08/uc6-photo-data.png',
                                      //   fit: BoxFit.contain,
                                      //   height: 100,
                                      // ),
                                      CachedNetworkImage(
                                        imageUrl: _productCategory[index]
                                            ['image']!,
                                        fit: BoxFit.contain,
                                        height: 100,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: _productCategory.length + 1,
                              itemBuilder: (BuildContext ctx, int index) {
                                return const SizedBox(
                                  width: 8,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
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
                              separatorBuilder: (BuildContext ctx, int index) {
                                return Container(
                                  height: 200,
                                  width: 300,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://www.mekanika.com.my/wp-content/uploads/2019/08/uc6-photo-data.png',
                                          // 'https://tbsweb.tbsdns.com/WebCache/epandu_devp_3/EPANDU/R3W77BWEY6B6TQI7DB5YM5RC5Q/image/Feed/RW42FFIRRQSB4LGEN3ZX2FWOKM_n0_20210628181116.jpg',
                                          fit: BoxFit.contain,
                                          height: 165,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
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
                              itemCount: 10,
                              itemBuilder: (BuildContext ctx, int index) {
                                return const SizedBox(
                                  width: 8,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
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
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://i.pinimg.com/736x/44/f8/41/44f8418a4afe49d2bbcf213cf9e66b7d.jpg',
                              fit: BoxFit.contain,
                              // height: 150,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
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
