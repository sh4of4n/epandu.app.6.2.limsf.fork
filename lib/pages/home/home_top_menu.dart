import 'package:epandu/app_localizations.dart';
import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTopMenu extends StatelessWidget {
  final iconText;

  HomeTopMenu({this.iconText});

  @override
  Widget build(BuildContext context) {
    return Table(
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
                    Text(AppLocalizations.of(context).translate('rewards_lbl'),
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
                    Text(AppLocalizations.of(context).translate('promo_lbl'),
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
                      MyCustomIcons.scan_icon,
                      size: 26,
                      color: Color(0xff808080),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    Text(AppLocalizations.of(context).translate('scan_lbl'),
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
                      MyCustomIcons.id_icon,
                      size: 26,
                      color: Color(0xff808080),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    Text(AppLocalizations.of(context).translate('id_lbl'),
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
                    Text(AppLocalizations.of(context).translate('inbox_lbl'),
                        style: iconText),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
