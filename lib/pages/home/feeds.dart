import 'package:epandu/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Feeds extends StatelessWidget {
  final image = ImagesConstant();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: ScreenUtil().setHeight(10),
            bottom: 10.0,
          ),
          child: Text(
            AppLocalizations.of(context).translate('feeds_lbl'),
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 7.0, right: 7.0, bottom: 15.0),
          height: ScreenUtil().setHeight(800),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 2,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: index % 2 == 0
                        ? Image.asset(image.feedSample)
                        : Image.asset(image.feedSample2),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
