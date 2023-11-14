import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';

class BottomMenu extends StatelessWidget {
  final myImage = ImagesConstant();
  final primaryColor = ColorConstant.primaryColor;
  final iconText = TextStyle(
    fontSize: ScreenUtil().setSp(55),
    fontWeight: FontWeight.w500,
  );

  BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      color: Colors.transparent,
      // color: primaryColor,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Ink(
              width: double.infinity,
              color: Colors.white,
            ),
          ),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              myImage.contestIcon,
                              height: 26,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                                AppLocalizations.of(context)!
                                    .translate('contest_and_win'),
                                style: iconText),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              myImage.aboutIcon,
                              height: 26,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                                AppLocalizations.of(context)!.translate('about'),
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
              onTap: () {},
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: EdgeInsets.only(
                  top: 60.h,
                ),
                margin: EdgeInsets.only(bottom: 80.h),
                child: FadeInImage(
                  alignment: Alignment.center,
                  placeholder: MemoryImage(kTransparentImage),
                  height: 100.h,
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
