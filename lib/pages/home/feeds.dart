import 'package:epandu/services/repository/profile_repository.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Feeds extends StatelessWidget {
  final feed;

  Feeds({this.feed});

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

  final localStorage = LocalStorage();

  final profileRepo = ProfileRepo();

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
    if (feed != null)
      return Container(
        // height: ScreenUtil().setHeight(1700),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: feed.length,
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
                      var feedValue = feed[index].feedNavigate;

                      if (feedValue != null) {
                        bool isUrl = Uri.parse(feedValue).isAbsolute;

                        // Navigation
                        if (!isUrl) {
                          switch (feedValue) {
                            case 'ENROLLMENT':
                              Navigator.pushNamed(context, ENROLLMENT);
                              break;
                            case 'KPP':
                              Navigator.pushNamed(context, KPP);
                              break;
                            case 'VCLUB':
                              Navigator.pushNamed(context, VALUE_CLUB);
                              break;
                          }
                        } else {
                          var result = await profileRepo.getUserProfile(
                              context: context);

                          String merchantNo = 'P1001';
                          String phone = result.data[0].phone;
                          String email = result.data[0].eMail;
                          String icName = result.data[0].name;
                          String icNo = result.data[0].icNo;
                          String dob = result.data[0].birthDate;
                          String userId = await localStorage.getUserId();
                          String profilePic =
                              result.data[0].picturePath != null &&
                                      result.data[0].picturePath.isNotEmpty
                                  ? result.data[0].picturePath
                                      .replaceAll(removeBracket, '')
                                      .split('\r\n')[0]
                                  : '';

                          String url = feedValue +
                              '/#/?' +
                              'merchantNo=$merchantNo' +
                              '&icName=$icName' +
                              '&icNo=$icNo' +
                              '&phone=$phone' +
                              '&email=$email' +
                              '&dob=${dob.substring(0, 10)}' +
                              '&userId=$userId';

                          launch(url,
                              forceWebView: true, enableJavaScript: true);
                        }
                      } else {
                        Navigator.pushNamed(context, PROMOTIONS);
                      }
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
                              Text(feed[index].feedText, style: adText),
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
    if (feed != null)
      return Container(
        // height: ScreenUtil().setHeight(1700),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: feed.length,
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
                      var feedValue = feed[index].feedNavigate;

                      if (feedValue != null) {
                        bool isUrl = Uri.parse(feedValue).isAbsolute;

                        // Navigation
                        if (!isUrl) {
                          switch (feedValue) {
                            case 'ENROLLMENT':
                              Navigator.pushNamed(context, ENROLLMENT);
                              break;
                            case 'KPP':
                              Navigator.pushNamed(context, KPP);
                              break;
                            case 'VCLUB':
                              Navigator.pushNamed(context, VALUE_CLUB);
                              break;
                          }
                        } else {
                          var result = await profileRepo.getUserProfile(
                              context: context);

                          String merchantNo = 'P1001';
                          String phone = result.data[0].phone;
                          String email = result.data[0].eMail;
                          String icName = result.data[0].name;
                          String icNo = result.data[0].icNo;
                          String dob = result.data[0].birthDate;
                          String userId = await localStorage.getUserId();
                          String profilePic =
                              result.data[0].picturePath != null &&
                                      result.data[0].picturePath.isNotEmpty
                                  ? result.data[0].picturePath
                                      .replaceAll(removeBracket, '')
                                      .split('\r\n')[0]
                                  : '';

                          String url = feedValue +
                              '/#/?' +
                              'merchantNo=$merchantNo' +
                              '&icName=$icName' +
                              '&icNo=$icNo' +
                              '&phone=$phone' +
                              '&email=$email' +
                              '&dob=${dob.substring(0, 10)}' +
                              '&userId=$userId';

                          launch(url,
                              forceWebView: true, enableJavaScript: true);
                        }
                      } else {
                        Navigator.pushNamed(context, PROMOTIONS);
                      }
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
                              Text(feed[index].feedText, style: adTabText),
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
