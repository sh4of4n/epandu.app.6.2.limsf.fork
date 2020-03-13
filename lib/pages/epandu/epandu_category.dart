import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class EpanduCategory extends StatelessWidget {
  final authRepo = AuthRepo();
  final image = ImagesConstant();
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  final iconText = TextStyle(
    fontSize: ScreenUtil().setSp(60),
  );
  final myImage = ImagesConstant();

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
          // title: Text(AppLocalizations.of(context).translate('epandu_title')),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: <Widget>[
            FadeInImage(
              alignment: Alignment.center,
              placeholder: MemoryImage(kTransparentImage),
              image: AssetImage(
                myImage.logo2,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(80),
            ),
            Table(
              // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              // border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, ENROLLMENT),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(300),
                            height: ScreenUtil().setWidth(300),
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 3),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .translate('enroll_lbl'),
                            style: iconText,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(300),
                            height: ScreenUtil().setWidth(300),
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 3),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .translate('important_info_lbl'),
                            style: iconText,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, KPP),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(300),
                            height: ScreenUtil().setWidth(300),
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 3),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          Text(
                            AppLocalizations.of(context).translate('kpp01_lbl'),
                            style: iconText,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(300),
                            height: ScreenUtil().setWidth(300),
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 3),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .translate('booking_lbl'),
                            style: iconText,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(300),
                            height: ScreenUtil().setWidth(300),
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 3),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          Text(
                            AppLocalizations.of(context).translate('faq_lbl'),
                            style: iconText,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(300),
                            height: ScreenUtil().setWidth(300),
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 3),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          Text(
                            AppLocalizations.of(context).translate('job_lbl'),
                            style: iconText,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
