import 'package:app_settings/app_settings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:epandu/services/api/model/provider_model.dart';
import 'package:epandu/services/location.dart';
import 'package:epandu/services/repository/profile_repository.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:validators/validators.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../app_localizations.dart';
import '../../router.gr.dart';

class Feeds extends StatefulWidget {
  final feed;
  final String appVersion;

  Feeds({this.feed, this.appVersion});

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  final adText = TextStyle(
    fontSize: ScreenUtil().setSp(70),
    fontWeight: FontWeight.bold,
    color: Color(0xff231f20),
  );

  final adTabText = TextStyle(
    fontSize: ScreenUtil().setSp(60),
    fontWeight: FontWeight.bold,
    color: Color(0xff231f20),
  );

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  // get location
  Location location = Location();

  String latitude = '';
  String longitude = '';

  final customDialog = CustomDialog();

  final localStorage = LocalStorage();
  final profileRepo = ProfileRepo();
  final appConfig = AppConfig();

  _checkLocationPermission(feed, context) async {
    // contactBox = Hive.box('emergencyContact');

    // await location.getCurrentLocation();

    bool serviceLocationStatus = await Geolocator().isLocationServiceEnabled();

    // GeolocationStatus geolocationStatus =
    //     await Geolocator().checkGeolocationPermissionStatus();

    if (serviceLocationStatus) {
      _getCurrentLocation(feed, context);
    } else {
      customDialog.show(
        context: context,
        barrierDismissable: false,
        title: Text(
            AppLocalizations.of(context).translate('loc_permission_title')),
        content: AppLocalizations.of(context).translate('loc_permission_desc'),
        customActions: <Widget>[
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('yes_lbl')),
            onPressed: () {
              ExtendedNavigator.of(context).pop();
              ExtendedNavigator.of(context).pop();
              AppSettings.openLocationSettings();
            },
          ),
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('no_lbl')),
            onPressed: () {
              ExtendedNavigator.of(context).pop();
              ExtendedNavigator.of(context).pop();
            },
          ),
        ],
        type: DialogType.GENERAL,
      );
    }
  }

  _getCurrentLocation(feed, context) async {
    await location.getCurrentLocation();

    localStorage.saveUserLatitude(location.latitude.toString());
    localStorage.saveUserLongitude(location.longitude.toString());

    setState(() {
      latitude = location.latitude.toString();
      longitude = location.longitude.toString();
    });

    loadUrl(feed, context);
  }

  loadUrl(feed, context) async {
    if (Provider.of<CallStatusModel>(context, listen: false).status == false) {
      Provider.of<CallStatusModel>(context, listen: false).callStatus(true);

      var result = await profileRepo.getUserProfile(context: context);

      if (result.isSuccess) {
        String merchantNo = 'P1001';
        String phone = result.data[0].phone;
        String email = result.data[0].eMail;
        String icName = result.data[0].name;
        String icNo = result.data[0].icNo;
        String dob = result.data[0].birthDate;
        String userId = await localStorage.getUserId();
        String loginDeviceId = await localStorage.getLoginDeviceId();
        String profilePic = result.data[0].picturePath != null &&
                result.data[0].picturePath.isNotEmpty
            ? result.data[0].picturePath
                .replaceAll(removeBracket, '')
                .split('\r\n')[0]
            : '';

        String url = feed.feedNavigate +
            '?' +
            'appId=${appConfig.appId}' +
            '&appVersion=${widget.appVersion}' +
            '&userId=$userId' +
            '&deviceId=$loginDeviceId' +
            _getMerchantNo(
                udf: feed.udfReturnParameter, merchantNo: merchantNo) +
            _getIcName(
                udf: feed.udfReturnParameter,
                icName: Uri.encodeComponent(icName)) +
            _getIcNo(
                udf: feed.udfReturnParameter, icNo: icNo == null ? '' : icNo) +
            _getPhone(udf: feed.udfReturnParameter, phone: phone) +
            _getEmail(udf: feed.udfReturnParameter, email: email) +
            _getBirthDate(
                udf: feed.udfReturnParameter, dob: dob?.substring(0, 10)) +
            _getLatitude(udf: feed.udfReturnParameter) +
            _getLongitude(udf: feed.udfReturnParameter);

        ExtendedNavigator.of(context)
            .push(Routes.webview, arguments: WebviewArguments(url: url));

        /* launch(url,
                              forceWebView: true, enableJavaScript: true); */
      } else {
        customDialog.show(
          context: context,
          barrierDismissable: false,
          content: result.message,
          customActions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context).translate('ok_btn')),
              onPressed: () {
                ExtendedNavigator.of(context).pop();
              },
            ),
          ],
          type: DialogType.GENERAL,
        );
      }
    }
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 600) {
        return defaultLayout();
      }
      return tabLayout();
    });
  }

  defaultLayout() {
    if (widget.feed != null)
      return Container(
        // height: ScreenUtil().setHeight(1700),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.feed.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Ink(
                  // height: ScreenUtil().setHeight(780),
                  width: ScreenUtil().setWidth(1300),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 0.4),
                        blurRadius: 0.3,
                        spreadRadius: 0.5,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      var feedValue = widget.feed[index].feedNavigate;

                      if (feedValue != null) {
                        bool isUrl = isURL(feedValue);

                        // Navigation
                        if (!isUrl) {
                          switch (feedValue) {
                            case 'ENROLLMENT':
                              ExtendedNavigator.of(context)
                                  .push(Routes.enrollment);
                              break;
                            case 'KPP':
                              ExtendedNavigator.of(context)
                                  .push(Routes.kppCategory);
                              break;
                            case 'VCLUB':
                              ExtendedNavigator.of(context)
                                  .push(Routes.valueClub);
                              break;
                            default:
                              break;
                          }
                        } else {
                          _checkLocationPermission(widget.feed[index], context);
                        }
                      }
                      /* else {
                          ExtendedNavigator.of(context)
                              .push(Routes.promotions);
                        } */
                    },
                    child: Column(
                      children: <Widget>[
                        /* Container(
                            // width: double.infinity,
                            // height: ScreenUtil().setHeight(600),
                            width: 1300.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: feed[index].feedMediaFilename != null
                                  ? Image.network(
                                      feed[index]
                                          .feedMediaFilename
                                          .replaceAll(removeBracket, '')
                                          .split('\r\n')[0],
                                      fit: BoxFit.contain,
                                    )
                                  : Container(),
                            ),
                          ), */
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: widget.feed[index].feedMediaFilename != null
                                ? Image.network(
                                    widget.feed[index].feedMediaFilename
                                        .replaceAll(removeBracket, '')
                                        .split('\r\n')[0],
                                    fit: BoxFit.contain,
                                  )
                                : Container(),
                          ),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(180),
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(70),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(widget.feed[index].feedText ?? '',
                                  style: adText),
                              if (widget.feed[index].feedText != null &&
                                  widget.feed[index].feedText.isNotEmpty)
                                Icon(
                                  Icons.chevron_right,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(50)),
              ],
            );
          },
        ),
      );
    return _loadingShimmer();
  }

  tabLayout() {
    if (widget.feed != null)
      return Container(
        // height: ScreenUtil().setHeight(1700),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.feed.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Ink(
                  // height: ScreenUtil().setHeight(980),
                  width: ScreenUtil().setWidth(1300),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 0.4),
                        blurRadius: 0.3,
                        spreadRadius: 0.5,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      var feedValue = widget.feed[index].feedNavigate;

                      if (feedValue != null) {
                        bool isUrl = isURL(feedValue);

                        // Navigation
                        if (!isUrl) {
                          switch (feedValue) {
                            case 'ENROLLMENT':
                              ExtendedNavigator.of(context)
                                  .push(Routes.enrollment);
                              break;
                            case 'KPP':
                              ExtendedNavigator.of(context)
                                  .push(Routes.kppCategory);
                              break;
                            case 'VCLUB':
                              ExtendedNavigator.of(context)
                                  .push(Routes.valueClub);
                              break;
                            default:
                              break;
                          }
                        } else {
                          _checkLocationPermission(widget.feed[index], context);
                        }
                      }
                      /* else {
                        ExtendedNavigator.of(context)
                            .push(Routes.promotions);
                      } */
                    },
                    child: Column(
                      children: <Widget>[
                        /* Container(
                          width: double.infinity,
                          height: ScreenUtil().setHeight(800),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: feed[index].feedMediaFilename != null
                                ? Image.network(
                                    feed[index]
                                        .feedMediaFilename
                                        .replaceAll(removeBracket, '')
                                        .split('\r\n')[0],
                                    fit: BoxFit.fill,
                                  )
                                : Container(),
                          ),
                        ), */
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: widget.feed[index].feedMediaFilename != null
                                ? Image.network(
                                    widget.feed[index].feedMediaFilename
                                        .replaceAll(removeBracket, '')
                                        .split('\r\n')[0],
                                    fit: BoxFit.contain,
                                  )
                                : Container(),
                          ),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(180),
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(70),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(widget.feed[index].feedText ?? '',
                                  style: adText),
                              if (widget.feed[index].feedText != null &&
                                  widget.feed[index].feedText.isNotEmpty)
                                Icon(
                                  Icons.chevron_right,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(50)),
              ],
            );
          },
        ),
      );
    return _loadingTabShimmer();
  }

  _loadingShimmer() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
          child: Column(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.grey[200],
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
        ),
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
          child: Column(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.grey[200],
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
        ),
      ],
    );
  }

  _loadingTabShimmer() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
          child: Column(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.grey[200],
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
        ),
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
          child: Column(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.grey[200],
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
        ),
      ],
    );
  }
}
