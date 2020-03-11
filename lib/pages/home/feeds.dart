import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

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
    if (feed != null)
      return Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(780),
            width: ScreenUtil().setWidth(1300),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 0),
                  blurRadius: 1.0,
                  spreadRadius: 1.2,
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
          SizedBox(height: ScreenUtil().setHeight(60)),
          Container(
            height: ScreenUtil().setHeight(780),
            width: ScreenUtil().setWidth(1300),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 0),
                  blurRadius: 1.0,
                  spreadRadius: 1.2,
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
    return _loadingShimmer();
  }

  _loadingShimmer() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
          child: Column(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.grey[200],
                highlightColor: Colors.white,
                child: Container(
                  width: ScreenUtil().setWidth(1300),
                  height: ScreenUtil().setHeight(750),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[200],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
          child: Column(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.grey[200],
                highlightColor: Colors.white,
                child: Container(
                  width: ScreenUtil().setWidth(1300),
                  height: ScreenUtil().setHeight(750),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[200],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
