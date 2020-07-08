// import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../router.gr.dart';

class HomePageHeader extends StatelessWidget {
  final String instituteLogo;
  final positionStream;

  HomePageHeader({this.instituteLogo, this.positionStream});

  final formatter = NumberFormat('#,##0.00');
  final image = ImagesConstant();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: {1: FractionColumnWidth(.43)},
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        // border: TableBorder.all(),
        children: [
          TableRow(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(20),
                ),
                child: FadeInImage(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(350),
                  placeholder: MemoryImage(kTransparentImage),
                  image: instituteLogo.isNotEmpty
                      ? NetworkImage(instituteLogo)
                      : MemoryImage(kTransparentImage),
                ),
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
                  // height: ScreenUtil().setHeight(400),
                  /* alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('wallet_balance'),
                      style: TextStyle(fontSize: ScreenUtil().setSp(55)),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Text(
                      'RM' + formatter.format(0),
                      style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: ScreenUtil().setSp(76),
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(13),
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(25),
                          vertical: ScreenUtil().setHeight(14),
                        ),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xff231f20), width: 1.2),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Text(
                          AppLocalizations.of(context).translate('reload_lbl'),
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(48),
                            letterSpacing: -0.6,
                            color: Color(0xff231f20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ), */
                  ),
              Container(
                alignment: Alignment.topRight,
                // margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                child: InkWell(
                  onTap: () => ExtendedNavigator.of(context).pushNamed(
                    Routes.profileTab,
                    arguments:
                        ProfileTabArguments(positionStream: positionStream),
                  ),
                  child: Image.asset(
                    image.profileRed,
                    width: 150.w,
                  ),
                ),
                /* child: IconButton(
                  iconSize: 36,
                  icon: Icon(
                    MyCustomIcons.account_icon,
                    color: Color(0xffb3b3b3),
                  ),
                  onPressed: () => Navigator.pushNamed(context, PROFILE_TAB,
                      arguments: positionStream),
                ), */
              ),
            ],
          ),
        ],
      ),
    );
  }
}
