import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Feeds extends StatelessWidget {
  final feed;

  Feeds({this.feed});

  final adText = TextStyle(
    fontSize: ScreenUtil().setSp(70),
    fontWeight: FontWeight.bold,
  );

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(750),
          width: ScreenUtil().setWidth(1300),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 3),
                blurRadius: 4.0,
                spreadRadius: 3.0,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    feed[0]
                        .feedMediaFilename
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
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(feed[0].feedDesc, style: adText),
                    Icon(
                      Icons.chevron_right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(80)),
        Container(
          height: ScreenUtil().setHeight(750),
          width: ScreenUtil().setWidth(1300),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 3),
                blurRadius: 4.0,
                spreadRadius: 3.0,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    feed[1]
                        .feedMediaFilename
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
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(feed[1].feedDesc, style: adText),
                    Icon(
                      Icons.chevron_right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
