import 'package:epandu/services/repository/emergency_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../app_localizations.dart';

class EmergencyDirectory extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;
  // final contactBox = Hive.box('emergencyContact');
  final emergencyRepo = EmergencyRepo();
  final myImage = ImagesConstant();
  final iconText = TextStyle(
    fontSize: ScreenUtil().setSp(60),
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xffffcd11)],
          stops: [0.65, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context).translate('sos_lbl')),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(50)),
          child: Column(
            children: <Widget>[
              FadeInImage(
                alignment: Alignment.center,
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(
                  myImage.emergencyImage,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(80),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(60)),
                child: Table(children: [
                  TableRow(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(40)),
                        child: InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, DIRECTORY_LIST,
                              arguments: 'POLICE'),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(350),
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.policeIcon,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('police_lbl'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(40)),
                        child: InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, DIRECTORY_LIST,
                              arguments: 'AMBULANCE'),
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(350),
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.ambulanceIcon,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('ambulance_lbl'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(40)),
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(350),
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.bombaIcon,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('bomba_lbl'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(40)),
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: <Widget>[
                              FadeInImage(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(350),
                                placeholder: MemoryImage(kTransparentImage),
                                image: AssetImage(
                                  myImage.workshopIcon,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('workshop_lbl'),
                                style: iconText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
