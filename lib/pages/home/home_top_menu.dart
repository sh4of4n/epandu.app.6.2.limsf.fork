import 'package:epandu/app_localizations.dart';
import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTopMenu extends StatelessWidget {
  final iconText;

  HomeTopMenu({this.iconText});

  final myImage = ImagesConstant();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(350),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Table(
              // border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              MyCustomIcons.gift_icon,
                              size: 26,
                              color: Color(0xff808080),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('rewards_lbl'),
                                style: iconText),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              MyCustomIcons.promo_icon,
                              size: 26,
                              color: Color(0xff808080),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('promo_lbl'),
                                style: iconText),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Image.memory(kTransparentImage,
                              width: ScreenUtil().setWidth(150)),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              MyCustomIcons.id_icon,
                              size: 26,
                              color: Color(0xff808080),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('id_lbl'),
                                style: iconText),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              MyCustomIcons.inbox_icon,
                              size: 26,
                              color: Color(0xff808080),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('inbox_lbl'),
                                style: iconText),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, EPANDU),
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(60),
                ),
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
                child: FadeInImage(
                  alignment: Alignment.center,
                  placeholder: MemoryImage(kTransparentImage),
                  height: ScreenUtil().setHeight(100),
                  image: AssetImage(
                    myImage.logo2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
