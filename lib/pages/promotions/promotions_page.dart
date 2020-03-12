import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context).translate('promotions_lbl'),
          ),
        ),
        body: FutureBuilder(
          future: _getActiveFeeds,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: SpinKitFoldingCube(color: primaryColor));
              case ConnectionState.done:
                if (snapshot is String) {
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
                            onTap: () {},
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      snapshot.data[index].feedMediaFilename
                                          .replaceAll(removeBracket, '')
                                          .split('\r\n')[0],
                                      fit: BoxFit.contain,
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
                  child: Text(
                      AppLocalizations.of(context).translate('http_exception')),
                ));
            }
          },
        ),
      ),
    );
  }
}
