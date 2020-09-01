import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class Promotions extends StatefulWidget {
  final feed;

  Promotions({this.feed});

  @override
  _PromotionsState createState() => _PromotionsState();
}

class _PromotionsState extends State<Promotions> {
  final primaryColor = ColorConstant.primaryColor;
  final authRepo = AuthRepo();

  Future _getActiveFeeds;
  int _startIndex = 0;

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  final adText = TextStyle(
    fontSize: ScreenUtil().setSp(70),
    fontWeight: FontWeight.bold,
    color: Color(0xff231f20),
  );

  @override
  void initState() {
    super.initState();

    _getActiveFeeds = getActiveFeed();
  }

  Future<dynamic> getActiveFeed() async {
    var result = await authRepo.getActiveFeed(
      context: context,
      feedType: 'PROMOTION',
      startIndex: _startIndex,
      noOfRecords: 10,
    );

    if (result.isSuccess) {
      return result.data;
    }
    return result.message;
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            AppLocalizations.of(context).translate('promotions_lbl'),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(60)),
          child: FutureBuilder(
            future: _getActiveFeeds,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return _loadingShimmer();
                case ConnectionState.done:
                  if (snapshot.data is String) {
                    return Center(
                      child: Text(AppLocalizations.of(context)
                          .translate('no_feeds_message')),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          SizedBox(height: ScreenUtil().setHeight(50)),
                          Ink(
                            height: ScreenUtil().setHeight(780),
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
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    height: ScreenUtil().setHeight(600),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                      child: Image.network(
                                        snapshot.data[index].feedMediaFilename
                                            .replaceAll(removeBracket, '')
                                            .split('\r\n')[0],
                                        fit: BoxFit.fill,
                                      ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(snapshot.data[index].feedText,
                                            style: adText),
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
                        ],
                      );
                    },
                  );
                default:
                  return Expanded(
                      child: Center(
                    child: Text(AppLocalizations.of(context)
                        .translate('http_exception')),
                  ));
              }
            },
          ),
        ),
      ),
    );
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
