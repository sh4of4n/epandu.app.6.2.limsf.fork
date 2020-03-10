import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePageHeader extends StatelessWidget {
  final instituteLogo;

  HomePageHeader({this.instituteLogo});

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
              height: ScreenUtil().setHeight(450),
              placeholder: MemoryImage(kTransparentImage),
              image: MemoryImage(instituteLogo ?? kTransparentImage),
            ),
            Container(
              height: ScreenUtil().setHeight(420),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'eWallet balance',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(56),
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    'RM0.00',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(80),
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(520),
                    height: ScreenUtil().setHeight(100),
                    child: OutlineButton(
                      borderSide: BorderSide(color: Colors.black),
                      shape: StadiumBorder(),
                      onPressed: () {},
                      child: Text('+Reload eWallet',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                iconSize: 45,
                icon: Icon(
                  MyCustomIcons.account_icon,
                  color: Color(0xff666666),
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
