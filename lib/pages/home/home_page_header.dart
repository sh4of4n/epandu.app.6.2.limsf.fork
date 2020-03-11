import 'package:epandu/app_localizations.dart';
import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePageHeader extends StatelessWidget {
  final String instituteLogo;

  HomePageHeader({this.instituteLogo});

  final formatter = NumberFormat('#,##0.00');

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: {1: FractionColumnWidth(.45)},
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      // border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            FadeInImage(
              alignment: Alignment.centerLeft,
              height: ScreenUtil().setHeight(400),
              placeholder: MemoryImage(kTransparentImage),
              image: instituteLogo != null
                  ? NetworkImage(instituteLogo)
                  : MemoryImage(kTransparentImage),
            ),
            /* Opacity(
                  opacity: 0.5,
                  child: Icon(
                    MyCustomIcons.touch_me_icon,
                    color: Color(0xff808080),
                    size: 30,
                  ),
                ), */
            Container(
              height: ScreenUtil().setHeight(420),
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'eWallet balance',
                    style: TextStyle(fontSize: ScreenUtil().setSp(55)),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    'RM' + formatter.format(0),
                    style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: ScreenUtil().setSp(80),
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  LimitedBox(
                    maxWidth: ScreenUtil().setWidth(500),
                    maxHeight: ScreenUtil().setHeight(100),
                    child: OutlineButton(
                      borderSide: BorderSide(color: Color(0xff808080)),
                      shape: StadiumBorder(),
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context).translate('reload_lbl'),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(55),
                          letterSpacing: -0.3,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff808080),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                iconSize: 40,
                icon: Icon(
                  MyCustomIcons.account_icon,
                  color: Color(0xffb3b3b3),
                ),
                onPressed: () => Navigator.pushNamed(context, PROFILE),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
