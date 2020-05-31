import 'package:badges/badges.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:epandu/app_localizations.dart';
import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/services.dart';

class HomeTopMenu extends StatefulWidget {
  final iconText;

  HomeTopMenu({this.iconText});

  @override
  _HomeTopMenuState createState() => _HomeTopMenuState();
}

class _HomeTopMenuState extends State<HomeTopMenu> {
  final myImage = ImagesConstant();
  bool _showBadge = false;
  String barcode = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _getBadge();
  }

  _getBadge() async {
    var badgeValue = await Hive.box('ws_url').get('show_badge');

    if (badgeValue != null) {
      setState(() {
        _showBadge = badgeValue;
      });
    }
  }

  Future _scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

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
                      onTap: _scan,
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
                            Text(
                                AppLocalizations.of(context)
                                    .translate('scan_lbl'),
                                style: widget.iconText),
                          ],
                        ),
                      ),
                    ),
                    /* InkWell(
                      onTap: () => Navigator.pushNamed(context, PAY),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              MyCustomIcons.scan_helper,
                              size: 26,
                              color: Color(0xff808080),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('pay_lbl'),
                                style: widget.iconText),
                          ],
                        ),
                      ),
                    ), */
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, INVITE),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              MyCustomIcons.invite_icon,
                              size: 26,
                              color: Color(0xff808080),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('invite_lbl'),
                              style: widget.iconText,
                            ),
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
                      onTap: () =>
                          Navigator.pushNamed(context, IDENTITY_BARCODE),
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
                                style: widget.iconText),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, INBOX),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Badge(
                              showBadge: _showBadge,
                              child: Icon(
                                MyCustomIcons.inbox_icon,
                                size: 26,
                                color: Color(0xff808080),
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('inbox_lbl'),
                                style: widget.iconText),
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
